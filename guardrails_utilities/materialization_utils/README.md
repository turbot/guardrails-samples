# Fix Materialization Errors

Automated tool for resolving Turbot Guardrails `Turbot > Materialize` controls stuck in an error state. Connects directly to the Guardrails RDS database via IAM authentication and processes error controls until all are cleared.

## How It Works

Each materialize control in an error state has a `resource_id` which is the `policy_type_id` it operates on. The script:

1. **Find errors** — Queries `controls` for materialize controls in `error` state
2. **Collect policy types** — Extracts the unique `policy_type_id`s from the error controls
3. **Process in parallel** — Runs up to 5 (configurable) `policy_type_id`s concurrently, each in its own thread with its own DB connection:
   - **UPDATE** — Sets `next_tick_timestamp` on `policy_values` rows for that `policy_type_id`, telling the async system to re-process them
   - **Poll** — Each poll waits the full grace period (~7 min (400s) = 100s max tick delay + 5 min processing buffer) then checks the count. This gives async workers time to pick items off the queue between each check.
4. **Repeat** — Loops back to step 1 until no error controls remain

### Resilience

- **Automatic reconnection** on database errors and IAM token expiry (tokens refresh every 10 minutes)
- **Transient error recovery** — query failures trigger a reconnect and retry, not an exit
- **Grace period per cycle** — after each UPDATE, waits ~7 min (400s)utes (100s max tick delay + 5 min processing buffer) for async workers to pick items off the queue before checking the count
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

Edit `workspaces.yaml` with connection details for each workspace:

```yaml
workspaces:
  vaec1:
    db_host: "your-rds-host.us-gov-west-1.rds.amazonaws.com"
    db_port: 5432
    db_name: "turbot"
    db_user: "turbot"
    db_schema: "vaec1"
    region: "us-gov-west-1"
```

Each workspace entry maps to a Guardrails environment with its own schema name.

## Usage

```bash
# Run with defaults (5 parallel, ~7 min (400s) between checks, stall after 3 checks)
python fix_materialize_errors.py --workspace vaec1

# Fewer parallel workers for a heavily loaded DB
python fix_materialize_errors.py --workspace vaec1 --parallel 3

# More patience before declaring a policy_type stalled
python fix_materialize_errors.py --workspace vaec1 --max-attempts 5

# Check current state — shows error controls and policy_values counts without making changes
python fix_materialize_errors.py --workspace vaec1 --check

# Run in background via nohup
nohup python fix_materialize_errors.py --workspace vaec1 > fix_vaec1.log 2>&1 &

# Tail the summary log for progress
tail -f fix_materialize_vaec1_summary.log

# Verbose logging
python fix_materialize_errors.py --workspace vaec1 --verbose
```

### Options

| Flag | Default | Description |
|------|---------|-------------|
| `--workspace` | *(required)* | Workspace name from `workspaces.yaml` |
| `--config` | `workspaces.yaml` | Path to config file |
| `--check` | off | Report current state without making changes |
| `--parallel` | `5` | Max policy_type_ids to process concurrently |
| `--max-attempts` | `3` | Consecutive update/check cycles with no reduction before giving up (~7 min (400s) each) |
| `--display-limit` | `20` | Max control IDs to display per iteration |
| `--verbose` | off | Enable debug logging |

## Example Output

```
2026-03-03 14:00:00 [INFO] [mat-fix] Connecting to rds-host.amazonaws.com (schema: vaec1)...
2026-03-03 14:00:01 [INFO] [mat-fix] Connected.
2026-03-03 14:00:01 [INFO] [mat-fix] Materialize control_type_id: 358701876868111
2026-03-03 14:00:01 [INFO] [mat-fix] ============================================================
2026-03-03 14:00:01 [INFO] [mat-fix] Iteration 1
2026-03-03 14:00:01 [INFO] [mat-fix] ============================================================
2026-03-03 14:00:01 [INFO] [mat-fix] Materialize controls in error state: 12
2026-03-03 14:00:01 [INFO] [mat-fix] Unique policy_type_ids to process: 8
2026-03-03 14:00:01 [INFO] [mat-fix]   Control id=123, policy_type_id=456789
2026-03-03 14:00:01 [INFO] [mat-fix]   Control id=124, policy_type_id=456790
2026-03-03 14:00:01 [INFO] [mat-fix]   ... and 6 more
2026-03-03 14:00:01 [INFO] [mat-fix] Processing batch: 5 policy_type_ids in parallel [456789, 456790, ...]
2026-03-03 14:00:01 [INFO] [mat-fix.pt-456789] Starting policy_type_id 456789
2026-03-03 14:00:01 [INFO] [mat-fix.pt-456789] policy_values count: 340
2026-03-03 14:00:01 [INFO] [mat-fix.pt-456789] Updated 340 policy values (next_tick_timestamp set)
2026-03-03 14:00:31 [INFO] [mat-fix.pt-456789] policy_values remaining: 112
2026-03-03 14:01:01 [INFO] [mat-fix.pt-456789] policy_values remaining: 0
2026-03-03 14:01:01 [INFO] [mat-fix.pt-456789] Drained.
...
2026-03-03 14:02:30 [INFO] [mat-fix] Batch complete: 5 succeeded, 0 stalled
2026-03-03 14:02:30 [INFO] [mat-fix] Processing batch: 3 policy_type_ids in parallel [456794, 456795, 456796]
...
2026-03-03 14:04:00 [INFO] [mat-fix] Batch complete: 3 succeeded, 0 stalled
2026-03-03 14:04:30 [INFO] [mat-fix] ============================================================
2026-03-03 14:04:30 [INFO] [mat-fix] Iteration 2
2026-03-03 14:04:30 [INFO] [mat-fix] ============================================================
2026-03-03 14:04:30 [INFO] [mat-fix] Materialize controls in error state: 0
2026-03-03 14:04:30 [INFO] [mat-fix] No error controls found. Done!
```

### Summary Log (tail -f fix_materialize_vaec1_summary.log)

```
2026-03-03 14:00:01  ITERATION | iteration=1    | elapsed=0h 0m  | error_controls=12   | unique_policy_types=8
2026-03-03 14:07:30  BATCH     | iteration=1    | elapsed=0h 7m  | batch_drained=5    | batch_stalled=0    | cumulative_drained=5    | cumulative_stalled=0
2026-03-03 14:14:00  BATCH     | iteration=1    | elapsed=0h 14m | batch_drained=3    | batch_stalled=0    | cumulative_drained=8    | cumulative_stalled=0
2026-03-03 14:14:30  ITERATION | iteration=2    | elapsed=0h 14m | error_controls=0    | unique_policy_types=0
2026-03-03 14:14:30  COMPLETE  | iteration=2    | elapsed=0h 14m | total_drained=8    | total_stalled=0    | errors_remaining=0
```
