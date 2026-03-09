#!/usr/bin/env python3
"""
Fix Turbot > Materialize controls in an error state.

Connects to a Turbot Guardrails RDS database via IAM authentication and
repeatedly:
  1. Finds materialize controls in 'error' state
  2. Collects the unique policy_type_ids (resource_id from each error control)
  3. Processes them in parallel batches — each updates its policy_values
     next_tick_timestamp and polls until the count drains to 0
  4. Repeats until no error controls remain

Resilient to transient DB errors and IAM token expiry. Only exits on
success (no errors remain) or when all policy_types are stalled.

Usage:
    python fix_materialize_errors.py --workspace vaec1
    python fix_materialize_errors.py --workspace vaec1 --check
    python fix_materialize_errors.py --workspace vaec1 --parallel 3
"""

import argparse
import logging
import sys
import time
import threading
from pathlib import Path

import boto3
import psycopg2
import yaml

MATERIALIZE_AKA = "tmod:@turbot/turbot#/control/types/materialize"

# IAM auth tokens are valid for 15 minutes; refresh well before expiry
TOKEN_REFRESH_SECONDS = 600

# The UPDATE sets next_tick_timestamp to now + random(0..100000) ms.
# Max tick delay is 100s. Add a processing buffer for the async workers
# to actually pick up and complete the work.
MAX_TICK_DELAY_SECONDS = 100
PROCESSING_BUFFER_SECONDS = 300  # 5 minutes
GRACE_PERIOD_SECONDS = MAX_TICK_DELAY_SECONDS + PROCESSING_BUFFER_SECONDS

# Root logger configuration
logging.basicConfig(
    level=logging.INFO,
    format="%(asctime)s [%(levelname)s] [%(name)s] %(message)s",
    datefmt="%Y-%m-%d %H:%M:%S",
)
log = logging.getLogger("mat-fix")

# Summary logger — append-only file for tailing progress
summary_log = logging.getLogger("mat-fix.summary")
summary_log.propagate = False  # don't duplicate to console


def setup_summary_log(workspace_name):
    """Set up the summary log file handler."""
    summary_path = Path(__file__).parent / f"fix_materialize_{workspace_name}_summary.log"
    handler = logging.FileHandler(summary_path, mode="a")
    handler.setFormatter(logging.Formatter(
        "%(asctime)s  %(message)s", datefmt="%Y-%m-%d %H:%M:%S"
    ))
    summary_log.addHandler(handler)
    summary_log.setLevel(logging.INFO)
    log.info("Summary log: %s", summary_path)
    return summary_path


def load_config(config_path, workspace_name):
    """Load workspace configuration from YAML file."""
    with open(config_path) as f:
        config = yaml.safe_load(f)

    workspaces = config.get("workspaces", {})
    if workspace_name not in workspaces:
        available = ", ".join(workspaces.keys()) or "(none)"
        log.error("Workspace '%s' not found. Available: %s", workspace_name, available)
        sys.exit(1)

    return workspaces[workspace_name]


def get_iam_auth_token(db_host, db_port, region, db_user):
    """Generate an IAM authentication token for RDS."""
    client = boto3.client("rds", region_name=region)
    return client.generate_db_auth_token(
        DBHostname=db_host,
        Port=db_port,
        DBUsername=db_user,
        Region=region,
    )


class DBConnection:
    """Manages a database connection with automatic IAM token refresh and reconnection."""

    def __init__(self, ws_config, logger):
        self.ws_config = ws_config
        self.log = logger
        self.conn = None
        self.connected_at = 0

    def _connect(self):
        token = get_iam_auth_token(
            self.ws_config["db_host"],
            self.ws_config["db_port"],
            self.ws_config["region"],
            self.ws_config["db_user"],
        )
        self.conn = psycopg2.connect(
            host=self.ws_config["db_host"],
            port=self.ws_config["db_port"],
            dbname=self.ws_config["db_name"],
            user=self.ws_config["db_user"],
            password=token,
            sslmode="require",
        )
        self.conn.autocommit = True
        self.connected_at = time.time()

    def get(self):
        """Return an active connection, reconnecting if token is stale."""
        if self.conn is None or (time.time() - self.connected_at) >= TOKEN_REFRESH_SECONDS:
            if self.conn is not None:
                self.log.debug("Refreshing IAM token / reconnecting...")
                try:
                    self.conn.close()
                except Exception:
                    pass
            self._connect()
        return self.conn

    def reconnect(self):
        """Force a reconnection (e.g. after a connection error)."""
        try:
            if self.conn:
                self.conn.close()
        except Exception:
            pass
        self.conn = None
        self._connect()

    def close(self):
        if self.conn:
            try:
                self.conn.close()
            except Exception:
                pass
            self.conn = None


# ---------------------------------------------------------------------------
# Database queries
# ---------------------------------------------------------------------------

def get_materialize_control_type_id(conn, schema):
    """Look up the control_type_id for the materialize control type."""
    sql = f"SELECT resource_id FROM {schema}.akas WHERE aka = %s"
    with conn.cursor() as cur:
        cur.execute(sql, (MATERIALIZE_AKA,))
        row = cur.fetchone()
        if not row:
            raise RuntimeError(
                f"Could not find materialize control type in {schema}.akas"
            )
        return row[0]


def get_error_controls(conn, schema, control_type_id):
    """Get materialize controls in error state. Returns list of (id, resource_id).
    Each resource_id is a policy_type_id that needs to be re-processed."""
    sql = f"""
        SELECT id, resource_id
        FROM {schema}.controls
        WHERE control_type_id = %s
          AND state = 'error'
    """
    with conn.cursor() as cur:
        cur.execute(sql, (control_type_id,))
        return cur.fetchall()


def get_policy_values_count(conn, schema, policy_type_id):
    """Get count of policy_values for a given policy_type_id."""
    sql = f"""
        SELECT count(*)
        FROM {schema}.policy_values
        WHERE policy_type_id = %s
    """
    with conn.cursor() as cur:
        cur.execute(sql, (policy_type_id,))
        return cur.fetchone()[0]


def update_policy_values(conn, schema, policy_type_id):
    """Update policy values to trigger re-processing. Returns count of updated rows."""
    sql = f"""
        WITH to_update AS (
            SELECT id FROM {schema}.policy_values
            WHERE policy_type_id = %s
              AND (next_tick_timestamp IS NULL OR next_tick_timestamp > {schema}.now_ms())
            FOR UPDATE SKIP LOCKED
        )
        UPDATE {schema}.policy_values pv
        SET next_tick_timestamp = {schema}.now_ms() + (floor(random() * 100000) || ' milliseconds')::interval
        FROM to_update
        WHERE pv.id = to_update.id
        RETURNING pv.id
    """
    with conn.cursor() as cur:
        cur.execute(sql, (policy_type_id,))
        return cur.rowcount


# ---------------------------------------------------------------------------
# Per-policy_type worker (runs in its own thread with its own DB connection)
# ---------------------------------------------------------------------------

def process_policy_type(policy_type_id, ws_config, schema, max_attempts):
    """
    Process a single policy_type_id:
      1. Run UPDATE to set next_tick_timestamp
      2. Wait grace period, check count
      3. If count is 0 → success
      4. If count hasn't decreased → re-run UPDATE and check again
      5. After max_attempts with no progress → give up

    Returns True on success (count reached 0), False if stalled.
    """
    ptlog = logging.getLogger(f"mat-fix.pt-{policy_type_id}")
    ptlog.info("Starting policy_type_id %s", policy_type_id)

    db = DBConnection(ws_config, ptlog)
    try:
        db.get()
    except Exception as e:
        ptlog.error("Connection failed: %s", e)
        return False

    try:
        # Check initial count
        pv_count = get_policy_values_count(db.get(), schema, policy_type_id)
        ptlog.info("policy_values count: %d", pv_count)

        if pv_count == 0:
            ptlog.info("Already at 0, nothing to do.")
            return True

        stall_count = 0
        while stall_count < max_attempts:
            # Run the UPDATE
            updated = update_policy_values(db.get(), schema, policy_type_id)
            ptlog.info("Updated %d policy values (next_tick_timestamp set). "
                       "Stalled attempts: %d/%d",
                       updated, stall_count, max_attempts)

            # Wait grace period for async workers to process
            ptlog.info("Waiting %ds for async processing (max tick %ds + buffer %ds)...",
                       GRACE_PERIOD_SECONDS, MAX_TICK_DELAY_SECONDS,
                       PROCESSING_BUFFER_SECONDS)
            time.sleep(GRACE_PERIOD_SECONDS)

            # Check count
            try:
                count = get_policy_values_count(db.get(), schema, policy_type_id)
            except Exception as e:
                ptlog.warning("Error checking count: %s. Reconnecting...", e)
                try:
                    db.reconnect()
                    count = get_policy_values_count(db.get(), schema, policy_type_id)
                except Exception as e2:
                    ptlog.error("Retry failed: %s", e2)
                    stall_count += 1
                    continue

            ptlog.info("policy_values remaining: %d (was %d)", count, pv_count)

            if count == 0:
                ptlog.info("Drained.")
                return True

            if count < pv_count:
                ptlog.info("Progress made (%d -> %d). Resetting stall counter.",
                           pv_count, count)
                pv_count = count
                stall_count = 0
            else:
                stall_count += 1
                ptlog.warning("No reduction (still %d). Stalled attempts: %d/%d",
                              count, stall_count, max_attempts)

        ptlog.error("Gave up after %d consecutive stalled attempts. Count stuck at %d.",
                     max_attempts, pv_count)
        return False

    except Exception as e:
        ptlog.error("Unexpected error: %s", e)
        return False
    finally:
        db.close()


# ---------------------------------------------------------------------------
# Main loop
# ---------------------------------------------------------------------------

def connect_and_resolve(ws_config):
    """Connect to the DB and resolve the materialize control_type_id.
    Returns (db, schema, control_type_id) or exits on failure."""
    schema = ws_config["db_schema"]

    log.info("Connecting to %s (schema: %s)...", ws_config["db_host"], schema)
    db = DBConnection(ws_config, log)

    try:
        db.get()
        log.info("Connected.")
    except Exception as e:
        log.error("Initial connection failed: %s", e)
        sys.exit(1)

    control_type_id = None
    for attempt in range(3):
        try:
            control_type_id = get_materialize_control_type_id(db.get(), schema)
            log.info("Materialize control_type_id: %s", control_type_id)
            break
        except Exception as e:
            log.warning("Failed to look up control_type_id (attempt %d): %s",
                        attempt + 1, e)
            time.sleep(5)
            try:
                db.reconnect()
            except Exception:
                pass

    if control_type_id is None:
        log.error("Could not resolve materialize control_type_id after retries.")
        db.close()
        sys.exit(1)

    return db, schema, control_type_id


def check_state(ws_config):
    """Report current state: each error control with its policy_type_id and policy_values count."""
    db, schema, control_type_id = connect_and_resolve(ws_config)

    try:
        error_controls = get_error_controls(db.get(), schema, control_type_id)
        log.info("Materialize controls in error state: %d", len(error_controls))

        if not error_controls:
            log.info("No errors found.")
            return True

        # Cache policy_values counts per policy_type_id (avoid repeated queries)
        pv_cache = {}
        total_pv = 0

        row_fmt = "%-18s %-18s %s"
        log.info("")
        log.info(row_fmt, "control_id", "policy_type_id", "policy_value_count")
        log.info(row_fmt, "-" * 18, "-" * 18, "-" * 18)
        for ctrl_id, policy_type_id in error_controls:
            if policy_type_id not in pv_cache:
                pv_cache[policy_type_id] = get_policy_values_count(
                    db.get(), schema, policy_type_id)
                total_pv += pv_cache[policy_type_id]
            log.info(row_fmt, ctrl_id, policy_type_id, pv_cache[policy_type_id])

        log.info("")
        log.info("Total: %d error controls, %d unique policy_types, %d policy_values",
                 len(error_controls), len(pv_cache), total_pv)

        return False
    finally:
        db.close()


def run(ws_config, max_attempts=3, parallel=5, display_limit=20):
    """Main loop: fix error controls until none remain or all are stalled."""
    db, schema, control_type_id = connect_and_resolve(ws_config)
    start_time = time.time()

    iteration = 0
    total_drained = 0
    total_stalled = 0

    try:
        while True:
            iteration += 1
            elapsed = int(time.time() - start_time)
            log.info("=" * 60)
            log.info("Iteration %d  (elapsed: %dh %dm)",
                     iteration, elapsed // 3600, (elapsed % 3600) // 60)
            log.info("=" * 60)

            # Get error controls
            try:
                error_controls = get_error_controls(db.get(), schema, control_type_id)
            except Exception as e:
                log.warning("Error querying controls: %s. Reconnecting...", e)
                try:
                    db.reconnect()
                    error_controls = get_error_controls(db.get(), schema, control_type_id)
                except Exception as e2:
                    log.error("Retry failed: %s. Waiting before next attempt...", e2)
                    time.sleep(30)
                    continue

            log.info("Materialize controls in error state: %d", len(error_controls))

            if not error_controls:
                log.info("No error controls found. Done!")
                summary_log.info(
                    "COMPLETE  | iteration=%-4d | elapsed=%dh %dm | "
                    "total_drained=%-4d | total_stalled=%-4d | errors_remaining=0",
                    iteration, elapsed // 3600, (elapsed % 3600) // 60,
                    total_drained, total_stalled,
                )
                return True

            # Collect unique policy_type_ids (resource_id from each control)
            policy_type_ids = list({rid for _, rid in error_controls})
            log.info("Unique policy_type_ids to process: %d", len(policy_type_ids))

            summary_log.info(
                "ITERATION | iteration=%-4d | elapsed=%dh %dm | "
                "error_controls=%-4d | unique_policy_types=%-4d",
                iteration, elapsed // 3600, (elapsed % 3600) // 60,
                len(error_controls), len(policy_type_ids),
            )

            for ctrl_id, resource_id in error_controls[:display_limit]:
                log.info("  Control id=%s, policy_type_id=%s", ctrl_id, resource_id)
            if len(error_controls) > display_limit:
                log.info("  ... and %d more", len(error_controls) - display_limit)

            # Process policy_type_ids in parallel, up to --parallel at a time
            all_succeeded = True
            for batch_start in range(0, len(policy_type_ids), parallel):
                batch = policy_type_ids[batch_start:batch_start + parallel]
                log.info("Processing batch: %d policy_type_ids in parallel [%s]",
                         len(batch), ", ".join(str(pt) for pt in batch))

                results = {}

                def worker(pt_id):
                    results[pt_id] = process_policy_type(
                        pt_id, ws_config, schema, max_attempts,
                    )

                threads = []
                for pt_id in batch:
                    t = threading.Thread(target=worker, args=(pt_id,), name=f"pt-{pt_id}")
                    t.start()
                    threads.append(t)

                for t in threads:
                    t.join()

                batch_ok = sum(1 for ok in results.values() if ok)
                batch_fail = sum(1 for ok in results.values() if not ok)
                total_drained += batch_ok
                total_stalled += batch_fail
                log.info("Batch complete: %d drained, %d stalled", batch_ok, batch_fail)

                elapsed = int(time.time() - start_time)
                summary_log.info(
                    "BATCH     | iteration=%-4d | elapsed=%dh %dm | "
                    "batch_drained=%-4d | batch_stalled=%-4d | "
                    "cumulative_drained=%-4d | cumulative_stalled=%-4d",
                    iteration, elapsed // 3600, (elapsed % 3600) // 60,
                    batch_ok, batch_fail, total_drained, total_stalled,
                )

                if batch_fail:
                    failed = [pt for pt, ok in results.items() if not ok]
                    log.warning("Stalled policy_type_ids: %s", failed)
                    all_succeeded = False

            if not all_succeeded:
                # Check if ANY progress was made this iteration
                remaining = None
                try:
                    remaining = get_error_controls(db.get(), schema, control_type_id)
                except Exception as e:
                    log.warning("Error checking progress: %s. Reconnecting...", e)
                    try:
                        db.reconnect()
                        remaining = get_error_controls(db.get(), schema, control_type_id)
                    except Exception as e2:
                        log.warning("Retry failed: %s. Assuming progress and continuing...", e2)

                if remaining is not None and len(remaining) >= len(error_controls):
                    elapsed = int(time.time() - start_time)
                    log.error("No progress this iteration (%d errors before, %d after). Exiting.",
                              len(error_controls), len(remaining))
                    summary_log.info(
                        "STALLED   | iteration=%-4d | elapsed=%dh %dm | "
                        "errors_remaining=%-4d | total_drained=%-4d | total_stalled=%-4d",
                        iteration, elapsed // 3600, (elapsed % 3600) // 60,
                        len(remaining), total_drained, total_stalled,
                    )
                    return False
                if remaining is not None:
                    log.warning("Partial progress (%d -> %d errors). Continuing...",
                                len(error_controls), len(remaining))

            log.info("Starting next iteration...")
    finally:
        db.close()


def main():
    parser = argparse.ArgumentParser(
        description="Fix Turbot Materialize controls in error state"
    )
    parser.add_argument(
        "--workspace", required=True,
        help="Workspace name from the config file"
    )
    parser.add_argument(
        "--config", default=str(Path(__file__).parent / "workspaces.yaml"),
        help="Path to workspaces YAML config (default: workspaces.yaml in script dir)"
    )
    parser.add_argument(
        "--check", action="store_true",
        help="Report current state (error controls and policy_values counts) without making changes"
    )
    parser.add_argument(
        "--max-attempts", type=int, default=3,
        help="Consecutive update/check cycles with no reduction before giving up on a policy_type (default: 3)"
    )
    parser.add_argument(
        "--parallel", type=int, default=5,
        help="Max policy_type_ids to process concurrently (default: 5)"
    )
    parser.add_argument(
        "--display-limit", type=int, default=20,
        help="Max control IDs to display per iteration (default: 20)"
    )
    parser.add_argument(
        "--verbose", action="store_true",
        help="Enable debug logging"
    )
    args = parser.parse_args()

    if args.verbose:
        logging.getLogger().setLevel(logging.DEBUG)

    ws_config = load_config(args.config, args.workspace)

    if args.check:
        ok = check_state(ws_config)
        sys.exit(0 if ok else 1)

    setup_summary_log(args.workspace)

    success = run(
        ws_config,
        max_attempts=args.max_attempts,
        parallel=args.parallel,
        display_limit=args.display_limit,
    )
    sys.exit(0 if success else 1)


if __name__ == "__main__":
    main()
