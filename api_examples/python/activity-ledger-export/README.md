# Activity Ledger Export

Exports Turbot notifications to a CSV file. Bypasses the 30-day / 5,000-row limits of the Guardrails UI by paginating the GraphQL API with parallel workers, chunked date windows, streaming writes (no memory accumulation), and checkpoint/resume support.

Two modes:

- **Action notifications only** (default) — the Activity Ledger: enforcement actions taken by Turbot. Typically hundreds to low thousands per day. Parallelized by CSP root type.
- **All notification types** (`--all-notifications`) — resource discoveries, control evaluations, policy changes, and enforcement actions combined. Typically hundreds of thousands per day. Parallelized by calendar day.

## Prerequisites

- [Python 3.*.*](https://www.python.org/downloads/)
- [Pip](https://pip.pypa.io/en/stable/installing/)

## Setup

### Virtual environment

```shell
python3 -m venv .venv
source .venv/bin/activate
pip install -r requirements.txt
```

### Turbot configuration

Set environment variables for your Turbot workspace:

```shell
export TURBOT_GRAPHQL_ENDPOINT="https://demo-acme.cloud.turbot.com/api/latest/graphql"
export TURBOT_ACCESS_KEY_ID=12345678-1a2b-3c4b-5e6f-111222333444
export TURBOT_SECRET_ACCESS_KEY=12345678-1a2b-3c4b-5e6f-111222333444
```

Or use a credentials profile from `~/.config/turbot/credentials.yml`.

## Running the example

```shell
python3 activity_ledger_export.py --days 90
```

### Options

| Option | Description |
| ------ | ----------- |
| `-c`, `--config-file` | Path to an optional yaml config file. |
| `-p`, `--profile` | Profile to use from the config file. Default: `default`. |
| `--days` | Fetch activity from the last N days. When N exceeds `--chunk-days`, automatically uses chunked streaming mode. Mutually exclusive with `--hours` and `--from-date`. |
| `--hours` | Fetch activity from the last N hours (action_notify only). Mutually exclusive with `--days`. |
| `--from-date` | Start date `YYYY-MM-DD`. Mutually exclusive with `--days`/`--hours`. |
| `--to-date` | End date `YYYY-MM-DD`. Used with `--from-date`. Defaults to today. |
| `--chunk-days` | Process N days per chunk. Default: `7`. Large `--days` values are auto-split using this. |
| `--resume` | Resume an interrupted run using the checkpoint file. |
| `--actor-id` | Filter by a specific actor identity ID. Defaults to the Turbot Identity for the workspace (action_notify mode only). |
| `--all-actors` | Include activity from all actors, not just Turbot Identity. |
| `--all-notifications` | Export all notification types (resource, control, policy, action). Default: action_notify only. Uses date-based parallel workers; `--csp`/`--resource-type` are ignored. |
| `--csp` | Limit to a specific platform: `aws`, `azure`, `azure-ad`, `gcp`, `kubernetes`, `servicenow`, `github`. Ignored with `--all-notifications`. |
| `--resource-type` | Filter by resource type IDs, comma-separated. Overrides `--csp`. Ignored with `--all-notifications`. |
| `--workers` | Parallel workers. For action_notify: one per CSP type (default 7). For `--all-notifications`: one per day per chunk (default 7). |
| `--page-size` | Number of notifications per API request. Default: `500`. |
| `--timeout` | Per-request HTTP timeout in seconds. Default: `120`. |
| `--retries` | Max retries per request on transient errors (429/502/503/504/timeout). Default: `5`. |
| `-o`, `--output` | Output CSV file path. Default: `activity_ledger.csv`. |

### Examples

#### Last 90 days of Turbot Identity activity (default)

```shell
python3 activity_ledger_export.py --days 90
```

Auto-splits into 7-day chunks and streams rows directly to the CSV file. The Turbot Identity actor ID is resolved automatically from the workspace.

#### Last 90 days, AWS resources only

```shell
python3 activity_ledger_export.py --days 90 --csp aws
```

#### Last 90 days, all actors (Turbot + human users)

```shell
python3 activity_ledger_export.py --days 90 --all-actors
```

#### Resume an interrupted run

```shell
python3 activity_ledger_export.py --days 90 --resume
```

A checkpoint file (`activity_ledger.csv.checkpoint.json`) is written after each chunk. `--resume` skips completed chunks and appends only the remaining data.

#### Last 24 hours with a custom output file

```shell
python3 activity_ledger_export.py --hours 24 --output last_24h_activity.csv
```

#### All notification types for 90 days (~60M rows)

```shell
python3 activity_ledger_export.py \
  --all-notifications --days 90 \
  --workers 7 --chunk-days 7 \
  --all-actors \
  --output all_notifications_90d.csv
```

Uses date-based parallelization (one worker per calendar day within each 7-day chunk). Each day typically contains 600K–800K notifications in a large workspace. Estimated run time: ~11 hours for 90 days. Add `--resume` to restart safely after interruption.

#### Specific date range with chunking

```shell
python3 activity_ledger_export.py \
  --from-date 2026-01-01 --to-date 2026-03-31 \
  --chunk-days 7 --workers 7 \
  -o q1_activity.csv
```

## CSV Output

| Column | Description |
| ------ | ----------- |
| `notification_id` | Guardrails notification ID (formatted for Excel compatibility). |
| `notification_type` | Notification type: `action_notify`, `control_notify`, `resource_notify`, `policy_notify`. |
| `timestamp` | When the notification was created. |
| `actor` | Identity that performed the action (e.g. `Turbot` or a user name). |
| `message` | Description of the action taken. |
| `resource_aka` | Primary AKA (ARN or equivalent) of the affected resource. |
| `resource_title` | Display name of the affected resource. |
| `resource_type` | Resource type hierarchy (e.g. `AWS > S3 > Bucket`). |
| `resource_trunk` | Full resource hierarchy path (e.g. `Turbot > Org > Account > Region > Bucket`). |
| `detail_link` | Direct link to the notification in the Guardrails UI. |

## Performance notes

- **action_notify**: ~250–2,000 notifications per day in a large workspace. A 90-day run typically completes in 10–30 minutes.
- **All notifications**: ~600K–800K per day in a large workspace. A 90-day run takes ~11 hours at 7 parallel workers. Each day is ~250 MB uncompressed CSV.
- The API has a ~90-day retrieval window. Queries for older data will return 0 rows even if the count metadata shows records.
