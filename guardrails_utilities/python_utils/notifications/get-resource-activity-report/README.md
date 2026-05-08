# Get Resource Activity Report

Export resource deletion activity from Guardrails workspaces to CSV. Two scripts are provided:

| Script | Backend | Best for |
|--------|---------|----------|
| `fetch_resource_deletions.py` | **Turbot CLI** (`turbot graphql`) | Reliable paginated fetches with calendar-day boundaries, bypasses the console 5K export limit |
| `resource_activity_report.py` | Python `requests` (direct HTTP) | Multi-workspace batch runs, auto-detects Turbot Identity ID |

Both produce CSV output matching the console Resource Activities export format.

## Prerequisites

- [Python 3.8+](https://www.python.org/downloads/)
- [Turbot CLI](https://turbot.com/guardrails/docs/reference/cli/installation) installed and configured
- Turbot CLI credentials at `~/.config/turbot/credentials.yml`

## Setup

```bash
cd guardrails_utilities/python_utils/notifications/get-resource-activity-report
pip install -r requirements.txt
```

Verify turbot CLI connectivity:

```bash
turbot graphql --profile my-workspace --query='{ resource(id:"tmod:@turbot/turbot#/") { turbot { title } } }'
```

---

## fetch_resource_deletions.py (Recommended)

Uses the turbot CLI for authentication and GraphQL transport. Paginates automatically and writes CSV incrementally (partial data is preserved if interrupted).

### Key features

- **Calendar-day boundaries** — `--date 2026-05-07` fetches midnight-to-midnight UTC, no overlap between consecutive days
- **All resource types by default** — captures snapshots, instances, volumes, Lambda functions, etc. in a single run
- **Bypasses the 5K console export limit** — paginated GraphQL fetches with no cap
- **Resource type aliases** — use `--resource-type snapshot` instead of the full `tmod:` URI
- **Safety guard** — blocks unbounded queries (all types + no time filter) to prevent fetching millions of rows

### Examples

#### All resource types deleted by Turbot on a single day

```bash
python fetch_resource_deletions.py --profile my-workspace --date 2026-05-07
# Output: my-workspace-resource-deleted-all-types-2026-05-07.csv
```

#### Only EC2 snapshots on a single day

```bash
python fetch_resource_deletions.py --profile my-workspace --date 2026-05-07 --resource-type snapshot
# Output: my-workspace-resource-deleted-snapshot-2026-05-07.csv
```

#### Only EC2 instances on a single day

```bash
python fetch_resource_deletions.py --profile my-workspace --date 2026-05-07 --resource-type instance
# Output: my-workspace-resource-deleted-instance-2026-05-07.csv
```

#### Date range — all types from May 1 to May 8

```bash
python fetch_resource_deletions.py --profile my-workspace --since 2026-05-01 --until 2026-05-08
# Output: my-workspace-resource-deleted-all-types-2026-05-01.csv
```

#### Date range — snapshots only from May 1 to May 8

```bash
python fetch_resource_deletions.py --profile my-workspace --since 2026-05-01 --until 2026-05-08 --resource-type snapshot
# Output: my-workspace-resource-deleted-snapshot-2026-05-01.csv
```

#### Rolling window — last 3 days, instances only

```bash
python fetch_resource_deletions.py --profile my-workspace --days 3 --resource-type instance
# Output: my-workspace-resource-deleted-instance-20260508.csv
```

#### Rolling window — last 7 days, all types

```bash
python fetch_resource_deletions.py --profile my-workspace --days 7
# Output: my-workspace-resource-deleted-all-types-20260508.csv
```

#### Custom output file

```bash
python fetch_resource_deletions.py --profile my-workspace --date 2026-05-07 --output may7-report.csv
```

#### Auto-detect Turbot Identity and fetch snapshots

```bash
python fetch_resource_deletions.py --profile my-workspace --date 2026-05-07 \
    --resource-type snapshot --auto-detect-actor
# Auto-detects the Turbot Identity ID and workspace URL from credentials.yml
# No need for --actor-id or --workspace-url
```

#### Explicit actor ID (if auto-detect is not desired)

```bash
python fetch_resource_deletions.py --profile another-workspace --date 2026-05-07 \
    --actor-id 123456789012345 \
    --workspace-url "https://another-workspace.cloud.turbot.com"
```

#### Specific resource type by full URI

```bash
python fetch_resource_deletions.py --profile my-workspace --date 2026-05-07 \
    --resource-type "tmod:@turbot/aws-lambda#/resource/types/functionVersion"
```

#### Open-ended since (no end date)

```bash
python fetch_resource_deletions.py --profile my-workspace --since 2026-05-01 --resource-type volume
# Fetches from May 1 to now
# Output: my-workspace-resource-deleted-volume-2026-05-01.csv
```

#### Day-by-day tracking for a week

```bash
for d in 01 02 03 04 05 06 07; do
    python fetch_resource_deletions.py --profile my-workspace --date 2026-05-$d
done
# Produces: my-workspace-resource-deleted-all-types-2026-05-01.csv through -07.csv
# No overlap between files — each covers midnight-to-midnight UTC
```

#### Compare two workspaces for the same day

```bash
python fetch_resource_deletions.py --profile workspace-a --date 2026-05-07
python fetch_resource_deletions.py --profile workspace-b --date 2026-05-07 \
    --actor-id 123456789012345 \
    --workspace-url "https://workspace-b.cloud.turbot.com"
```

### Resource type aliases

Short names you can use with `--resource-type` instead of full URIs:

| Alias | Resource type URI |
|-------|-------------------|
| `snapshot` | `tmod:@turbot/aws-ec2#/resource/types/snapshot` |
| `instance` | `tmod:@turbot/aws-ec2#/resource/types/instance` |
| `volume` | `tmod:@turbot/aws-ec2#/resource/types/volume` |
| `ami` | `tmod:@turbot/aws-ec2#/resource/types/image` |
| `launch-template` | `tmod:@turbot/aws-ec2#/resource/types/launchTemplate` |
| `bucket` | `tmod:@turbot/aws-s3#/resource/types/bucket` |
| `lambda` | `tmod:@turbot/aws-lambda#/resource/types/function` |
| `function-version` | `tmod:@turbot/aws-lambda#/resource/types/functionVersion` |
| `role` | `tmod:@turbot/aws-iam#/resource/types/role` |
| `vpc` | `tmod:@turbot/aws-vpc-core#/resource/types/vpc` |
| `security-group` | `tmod:@turbot/aws-vpc-security#/resource/types/securityGroup` |
| `subscription` | `tmod:@turbot/aws-sns#/resource/types/subscription` |
| `ecs-service` | `tmod:@turbot/aws-ecs#/resource/types/service` |

You can also pass any `tmod:@turbot/...` URI directly. To find the URI for a resource type not listed above, navigate to the resource type in the Guardrails console and copy the URI from the resource type details, or run:

```bash
turbot graphql --profile my-workspace --query='{ resourceTypes(filter: "snapshot") { items { uri turbot { title } } } }' --format yaml
```

### Command-line reference

```
usage: fetch_resource_deletions.py [-h] --profile PROFILE
                                   [--date DATE] [--since SINCE] [--until UNTIL] [--days DAYS]
                                   [--actor-id ACTOR_ID] [--auto-detect-actor]
                                   [--resource-type RESOURCE_TYPE]
                                   [--output OUTPUT] [--workspace-url WORKSPACE_URL]

options:
  --profile PROFILE       Turbot CLI profile name (required)

time range (pick one):
  --date DATE             Single calendar day, midnight-to-midnight UTC (YYYY-MM-DD)
  --since SINCE           Start date inclusive (YYYY-MM-DD)
  --until UNTIL           End date exclusive (YYYY-MM-DD), use with --since
  --days DAYS             Rolling window in days (default: 1)

  --actor-id ACTOR_ID     Turbot actor identity ID (pass explicitly, or use --auto-detect-actor)
  --auto-detect-actor     Auto-detect Turbot Identity ID from the workspace via GraphQL query
  --resource-type TYPE    Resource type alias or full tmod URI (default: all types)
  --output OUTPUT         Output CSV file path (default: auto-generated)
  --workspace-url URL     Workspace base URL (auto-read from credentials.yml if omitted)
```

### Time range behavior

| Option | Boundary | Example |
|--------|----------|---------|
| `--date 2026-05-07` | `timestamp:>2026-05-07 timestamp:<2026-05-08` | Midnight-to-midnight UTC, no overlap |
| `--since 2026-05-01 --until 2026-05-08` | `timestamp:>2026-05-01 timestamp:<2026-05-08` | Arbitrary range |
| `--since 2026-05-01` | `timestamp:>2026-05-01` | From May 1 to now |
| `--days 3` | `timestamp:>2026-05-05` | Rolling 3 days from today |

### Safety guard

To prevent accidental fetches of millions of rows, the script blocks queries that combine **all resource types** (no `--resource-type`) with **no absolute time boundary** (no `--date` or `--since`). Either add a time boundary or specify a resource type.

---

## Output format

### Columns

| Column | Description |
|--------|-------------|
| Timestamp | Activity timestamp (DD-Mon-YYYY HH:MM:SS UTC) |
| NotificationType | RESOURCE DELETED |
| Type / Message | Resource type category (e.g., Object > Snapshot) |
| Resource | Resource title (e.g., snap-0abcdef1234567890) |
| Actor | Actor identity name (e.g., Turbot Identity) |
| ResourceId | Guardrails resource ID |
| TrunkPath | Resource hierarchy path, or (deleted) |
| Detail URL | Link to the resource activity page in the console |

### Example output

```csv
Timestamp,NotificationType,Type / Message,Resource,Actor,ResourceId,TrunkPath,Detail URL
07-May-2026 13:42:32,RESOURCE DELETED,Object > Snapshot,snap-0abcdef1234567890,Turbot Identity,123456789012345,(deleted),https://my-workspace.cloud.turbot.com/apollo/resources/123456789012345/activity
07-May-2026 11:32:25,RESOURCE DELETED,Object > Instance,i-0abcdef1234567890,Turbot Identity,123456789012346,(deleted),https://my-workspace.cloud.turbot.com/apollo/resources/123456789012346/activity
```

---

## Credentials

Both scripts use `~/.config/turbot/credentials.yml` (same as Turbot CLI):

```yaml
my-workspace:
  workspace: "https://my-workspace.cloud.turbot.com"
  accessKey: "your-access-key"
  secretKey: "your-secret-key"

another-workspace:
  workspace: "https://another-workspace.cloud.turbot.com"
  accessKey: "your-access-key"
  secretKey: "your-secret-key"
```

List configured profiles:

```bash
turbot workspace list
```

---

## Case study: Investigating snapshot deletions by Turbot

A customer reported that EC2 snapshots were being deleted in their workspace. The console Resource Activities report timed out due to the workspace having millions of notifications. Here is the workflow used to investigate and produce a daily report.

### Step 1 — Fetch snapshot deletions by Turbot for a specific day

The simplest command — `--auto-detect-actor` queries the workspace to find the Turbot Identity ID automatically, and the workspace URL is read from `credentials.yml`:

```bash
python fetch_resource_deletions.py \
    --profile my-workspace \
    --date 2026-05-07 \
    --resource-type snapshot \
    --auto-detect-actor
# Auto-detected Turbot Identity: 123456789012345
# Output: my-workspace-resource-deleted-snapshot-2026-05-07.csv
```

This fetches all snapshot deletions by the Turbot automation identity on May 7, midnight-to-midnight UTC.

### Step 2 — Broaden the scope to all resource types

To check what else Turbot deleted on the same day, omit `--resource-type`:

```bash
python fetch_resource_deletions.py \
    --profile my-workspace \
    --date 2026-05-07 \
    --auto-detect-actor
# Output: my-workspace-resource-deleted-all-types-2026-05-07.csv
```

A typical breakdown might look like:

```
  127  Object > Snapshot
   72  Object > Instance
    7  Object > Function Version
    5  Object > Subscription
    3  Object > Launch Template
    2  Object > Volume
    1  Object > Service
  217  TOTAL
```

### Step 3 — Generate a multi-day report

```bash
for d in 01 02 03 04 05 06 07; do
    python fetch_resource_deletions.py \
        --profile my-workspace \
        --date 2026-05-$d \
        --resource-type snapshot \
        --auto-detect-actor
done
```

Each file covers exactly midnight-to-midnight UTC with no overlap, making day-over-day comparison reliable.

### Step 4 — Fetch a date range in a single CSV

```bash
python fetch_resource_deletions.py \
    --profile my-workspace \
    --since 2026-05-01 --until 2026-05-08 \
    --resource-type snapshot \
    --auto-detect-actor
# Output: my-workspace-resource-deleted-snapshot-2026-05-01.csv
```

### Step 5 — Fetch deletions by all actors (not just Turbot)

Omit `--auto-detect-actor` and `--actor-id` to see deletions by all actors. This helps determine if resources were deleted by Turbot automation, by users, or by external processes:

```bash
python fetch_resource_deletions.py \
    --profile my-workspace \
    --date 2026-05-07 \
    --resource-type snapshot
```

The Actor column in the CSV will show who performed each deletion.

### Step 6 — Use an explicit actor ID (alternative to auto-detect)

If you already know the Turbot Identity ID (found via console > Permissions > Turbot Identity), you can pass it directly:

```bash
python fetch_resource_deletions.py \
    --profile my-workspace \
    --date 2026-05-07 \
    --resource-type snapshot \
    --actor-id 123456789012345
```

### Key findings from this investigation

- The console Export CSV is capped at **5,000 rows** — this script has no such limit
- The console report times out on workspaces with millions of notifications — this script paginates reliably
- `--auto-detect-actor` queries the workspace for the Turbot Identity ID automatically — no need to look it up manually, and the workspace URL is auto-read from `credentials.yml`
- The Turbot Identity ID is **different per workspace** — do not reuse an ID from one workspace on another
- The `metadata.stats.total` in the GraphQL response is **approximate** and does not reflect timestamp filters — use the actual row count
- Without `--actor-id` or `--auto-detect-actor`, deletions by all actors are returned, including "Unidentified Identity" (typically AWS-side deletions not initiated by Guardrails)
- Without `--resource-type`, all resource types are fetched — useful for a full picture but requires a time boundary (`--date` or `--since`) to avoid fetching millions of rows

---

## Notes

- **metadata.stats.total is approximate** — the total count in the GraphQL response does not apply all filter conditions (particularly timestamp boundaries). The actual item count from pagination is the accurate number.
- **Turbot Identity ID** — the actor identity ID for the Turbot automation identity varies per workspace. Use `--auto-detect-actor` to query it automatically, or find it via the console under Permissions > Turbot Identity and pass `--actor-id` explicitly. Omit both to fetch deletions by all actors.
- **Workspace URL auto-detection** — the workspace URL is automatically read from `~/.config/turbot/credentials.yml` when `--workspace-url` is not provided. This populates the Detail URL column in the CSV.
- **Timestamps are UTC** — all `--date`, `--since`, and `--until` values are interpreted as UTC midnight boundaries.
