# Fix Materialization Errors

Automated tool for resolving Turbot Guardrails `Turbot > Materialize` controls stuck in an error state. Connects directly to the Guardrails RDS database via IAM authentication and processes error controls until all are cleared.

## How It Works

Each materialize control in an error state has a `resource_id` which is the `policy_type_id` it operates on. The script:

1. **Find errors** — Queries `controls` for materialize controls in `error` state
2. **Collect policy types** — Extracts the unique `policy_type_id`s from the error controls
3. **Process in parallel** — Runs up to 5 (configurable) `policy_type_id`s concurrently, each in its own thread with its own DB connection:
   - **UPDATE** — Sets `next_tick_timestamp` on `policy_values` rows for that `policy_type_id`, telling the async system to re-process them
   - **Poll** — Each poll waits the full grace period (~7 min = 100s max tick delay + 5 min processing buffer) then checks the count
4. **Re-trigger controls** — When a policy_type's `policy_values` count is already 0 but the control is still in error, the script sets `next_tick_timestamp` on the control itself to trigger re-evaluation, then waits 30s before rechecking
5. **Repeat** — Loops back to step 1 until no error controls remain

### Resilience

- **Automatic reconnection** on database errors and IAM token expiry (tokens refresh every 10 minutes)
- **Transient error recovery** — query failures trigger a reconnect and retry, not an exit
- **Grace period per cycle** — after each UPDATE, waits ~7 min (100s max tick delay + 5 min processing buffer) for async workers to pick items off the queue before checking the count
- **Retry on stall** — if a policy_type's count hasn't decreased, re-runs the UPDATE and waits again. Gives up after 3 consecutive stalled attempts (configurable via `--max-attempts`). Resets the counter any time progress is made.
- **Overall progress tracking** — the script only exits when an entire iteration makes zero progress (error count doesn't decrease). Partial progress continues.

## Prerequisites

- Python 3.8+
- Network access to the RDS instance (run from a bastion host)
- IAM permissions for `rds:connect` on the target database
- AWS credentials configured (instance profile, environment variables, or AWS config)

## Installation

```bash
pip install -r requirements.txt
```

## Configuration

Copy `workspaces.yaml.example` to `workspaces.yaml` and fill in your connection details:

```bash
cp workspaces.yaml.example workspaces.yaml
```

```yaml
workspaces:
  my_workspace:
    db_host: "your-rds-instance.xxxxxxxxxxxx.us-east-1.rds.amazonaws.com"
    db_port: 5432
    db_name: "turbot"
    db_user: "turbot"
    db_schema: "my_workspace"
    region: "us-east-1"
```

Each workspace entry maps to a Guardrails environment with its own schema name. The `workspaces.yaml` file is gitignored to avoid committing credentials.

## Usage

```bash
# Run with defaults (5 parallel, ~7 min between checks, stall after 3 checks)
python fix_materialize_errors.py --workspace my_workspace

# Fewer parallel workers for a heavily loaded DB
python fix_materialize_errors.py --workspace my_workspace --parallel 3

# More patience before declaring a policy_type stalled
python fix_materialize_errors.py --workspace my_workspace --max-attempts 5

# Check current state — shows error controls and policy_values counts without making changes
python fix_materialize_errors.py --workspace my_workspace --check

# Run in background via nohup
nohup python fix_materialize_errors.py --workspace my_workspace > fix.log 2>&1 &

# Tail the summary log for progress
tail -f fix_materialize_my_workspace_summary.log

# Verbose logging (shows per-batch, per-worker detail)
python fix_materialize_errors.py --workspace my_workspace --verbose
```

### Options

| Flag | Default | Description |
|------|---------|-------------|
| `--workspace` | *(required)* | Workspace name from `workspaces.yaml` |
| `--config` | `workspaces.yaml` | Path to config file |
| `--check` | off | Report current state without making changes |
| `--parallel` | `5` | Max policy_type_ids to process concurrently |
| `--max-attempts` | `3` | Consecutive update/check cycles with no reduction before giving up (~7 min each) |
| `--display-limit` | `20` | Max control IDs to display per iteration |
| `--verbose` | off | Enable debug logging |

## Example Output

Progress is logged every 30 seconds (or immediately on state change) with a per-control table:

```
2026-03-09 14:00:00 [INFO] [mat-fix] Connecting to rds-host.amazonaws.com (schema: my_workspace)...
2026-03-09 14:00:01 [INFO] [mat-fix] Connected.
2026-03-09 14:00:01 [INFO] [mat-fix] Materialize control_type_id: 358701876868111
2026-03-09 14:00:01 [INFO] [mat-fix] --- Iteration 1 | elapsed: 0h 0m | 3 error controls ---
2026-03-09 14:00:01 [INFO] [mat-fix]   control_id         policy_type_id     pv_complete    status
2026-03-09 14:00:01 [INFO] [mat-fix]   ------------------ ------------------ -------------- --------------
2026-03-09 14:00:01 [INFO] [mat-fix]   185208031498485    194826182736281    0/340          processing
2026-03-09 14:00:01 [INFO] [mat-fix]   185208031498129    194826182736445    0/1000         processing
2026-03-09 14:00:01 [INFO] [mat-fix]   185208031498887    194826182736102    0/52           processing
...
2026-03-09 14:07:31 [INFO] [mat-fix] --- Iteration 2 | elapsed: 0h 7m | 3 error controls ---
2026-03-09 14:07:31 [INFO] [mat-fix]   control_id         policy_type_id     pv_complete    status
2026-03-09 14:07:31 [INFO] [mat-fix]   ------------------ ------------------ -------------- --------------
2026-03-09 14:07:31 [INFO] [mat-fix]   185208031498485    194826182736281    340/340        re-trigger
2026-03-09 14:07:31 [INFO] [mat-fix]   185208031498129    194826182736445    612/1000       processing
2026-03-09 14:07:31 [INFO] [mat-fix]   185208031498887    194826182736102    52/52          re-trigger
2026-03-09 14:07:31 [INFO] [mat-fix] Re-triggered 2 controls (policy_values already at 0). Waiting 30s for re-evaluation...
...
2026-03-09 14:15:00 [INFO] [mat-fix] No error controls found. Done!
```

### Summary Log

A machine-readable summary log is written to `fix_materialize_{workspace}_summary.log`:

```
2026-03-09 14:00:01  PROGRESS  | iteration=1    | elapsed=0h 0m  | error_controls=3    | policy_types=3    | resolved=0    | retriggered=0  | stalled=0
2026-03-09 14:07:31  PROGRESS  | iteration=2    | elapsed=0h 7m  | error_controls=3    | policy_types=3    | resolved=1    | retriggered=2  | stalled=0
2026-03-09 14:15:00  COMPLETE  | iteration=3    | elapsed=0h 15m | total_resolved=3    | total_retriggered=2 | total_stalled=0
```
