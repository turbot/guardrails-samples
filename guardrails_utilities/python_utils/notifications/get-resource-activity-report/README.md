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

#### Different workspace with explicit actor ID

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

You can also pass any `tmod:@turbot/...` URI directly.

### Command-line reference

```
usage: fetch_resource_deletions.py [-h] --profile PROFILE
                                   [--date DATE] [--since SINCE] [--until UNTIL] [--days DAYS]
                                   [--actor-id ACTOR_ID] [--resource-type RESOURCE_TYPE]
                                   [--output OUTPUT] [--workspace-url WORKSPACE_URL]

options:
  --profile PROFILE       Turbot CLI profile name (required)

time range (pick one):
  --date DATE             Single calendar day, midnight-to-midnight UTC (YYYY-MM-DD)
  --since SINCE           Start date inclusive (YYYY-MM-DD)
  --until UNTIL           End date exclusive (YYYY-MM-DD), use with --since
  --days DAYS             Rolling window in days (default: 1)

  --actor-id ACTOR_ID     Turbot actor identity ID (auto-detected for known workspaces)
  --resource-type TYPE    Resource type alias or full tmod URI (default: all types)
  --output OUTPUT         Output CSV file path (default: auto-generated)
  --workspace-url URL     Workspace base URL (auto-detected for known workspaces)
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

## Notes

- **metadata.stats.total is approximate** — the total count in the GraphQL response does not apply all filter conditions (particularly timestamp boundaries). The actual item count from pagination is the accurate number.
- **Turbot Identity ID** — the actor identity ID for the Turbot automation identity varies per workspace. Find it via the console under Permissions > Turbot Identity, or pass `--actor-id` explicitly. Omit it to fetch deletions by all actors.
- **Timestamps are UTC** — all `--date`, `--since`, and `--until` values are interpreted as UTC midnight boundaries.
