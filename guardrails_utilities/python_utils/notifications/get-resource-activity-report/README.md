# Get Resource Activity Report

Export resource create/delete/update activity from one or more Guardrails workspaces to CSV. Filters by actor identity (defaults to the Turbot automation identity) and resource type.

This script is useful when the console Resource Activities report times out on workspaces with large notification volumes. It fetches only resource-level CRUD notifications (not control/policy processing activity), keeping the dataset manageable.

## Features

- **Multi-workspace support** — run against multiple workspaces in a single invocation
- **Auto-detects Turbot Identity** — finds the automation actor ID automatically
- **Configurable resource type** — defaults to EC2 Snapshots, works with any resource type
- **Configurable time range** — `--days` parameter for lookback window
- **CSV output** — matches the console Resource Activities report format
- **Handles large datasets** — paginated queries with timeout retry logic

## Prerequisites

- [Python 3.8+](https://www.python.org/downloads/)
- [Turbot CLI credentials](https://turbot.com/guardrails/docs/reference/cli/installation#set-up-your-turbot-guardrails-credentials) configured at `~/.config/turbot/credentials.yml`

## Setup

```bash
cd get-resource-activity-report
pip install -r requirements.txt
```

### Credentials

The script uses the same credentials file as the Turbot CLI (`~/.config/turbot/credentials.yml`):

```yaml
my-workspace:
  workspace: "https://my-workspace.turbot.com"
  accessKey: "your-access-key"
  secretKey: "your-secret-key"

another-workspace:
  workspace: "https://another-workspace.turbot.com"
  accessKey: "your-access-key"
  secretKey: "your-secret-key"
```

## Usage

### Basic — EC2 Snapshots, last 30 days

```bash
python resource_activity_report.py --profile my-workspace
```

### Custom time range

```bash
# Last 90 days
python resource_activity_report.py --profile my-workspace --days 90

# Last 7 days
python resource_activity_report.py --profile my-workspace --days 7
```

### Multiple workspaces

```bash
python resource_activity_report.py \
  --profile workspace-a \
  --profile workspace-b \
  --profile workspace-c \
  --days 30
```

### Different resource type

```bash
# S3 Buckets
python resource_activity_report.py --profile my-workspace \
  --resource-type "tmod:@turbot/aws-s3#/resource/types/bucket"

# EC2 Instances
python resource_activity_report.py --profile my-workspace \
  --resource-type "tmod:@turbot/aws-ec2#/resource/types/instance"
```

### Specific actor identity

```bash
python resource_activity_report.py --profile my-workspace \
  --days 90 --actor-id 123456789012345
```

### Custom output directory

```bash
python resource_activity_report.py --profile my-workspace \
  --days 30 --output-dir ./reports
```

## Output

One CSV file per workspace: `{profile}-resource-activity-{days}d-{date}.csv`

### Columns

| Column | Description |
|--------|-------------|
| Timestamp | Activity timestamp (DD-Mon-YYYY HH:MM:SS) |
| NotificationType | RESOURCE CREATED, RESOURCE DELETED, or RESOURCE UPDATED |
| Type / Message | Resource type category and name |
| Resource | Resource title (e.g., snapshot ID, bucket name) |
| Actor | Actor identity name |
| ResourceId | Guardrails resource ID |
| TrunkPath | Full resource hierarchy path |
| Detail URL | Direct link to the notification in the console |

### Example output

```
Timestamp,NotificationType,Type / Message,Resource,Actor,ResourceId,TrunkPath,Detail URL
01-May-2026 04:47:35,RESOURCE DELETED,Object > Snapshot,snap-08170c6ca...,Turbot > Turbot Identity,384593893452312,(deleted),https://...
```

## How it works

1. Connects to each workspace using the credentials.yml profile
2. Auto-detects the Turbot Identity actor ID (resource type `turbotIdentity`)
3. Queries all resource CRUD notifications for the given resource type and actor via paginated GraphQL
4. Filters to the requested date range client-side
5. Writes one CSV per workspace

### Performance note

The script intentionally avoids combining `actorIdentityId` with `timestamp` filters in the GraphQL query. On workspaces with millions of notifications, this filter combination causes backend query timeouts. Instead, it fetches all resource CRUD notifications (typically hundreds to low thousands) and applies the date filter in Python. This approach completes reliably in under a minute.

## Command-line reference

```
usage: resource_activity_report.py [-h] --profile PROFILE [--days DAYS]
                                   [--resource-type RESOURCE_TYPE]
                                   [--actor-id ACTOR_ID]
                                   [--output-dir OUTPUT_DIR]

options:
  --profile PROFILE       Turbot CLI profile name (repeatable)
  --days DAYS             Days to look back (default: 30)
  --resource-type TYPE    Resource type URI (default: EC2 Snapshot)
  --actor-id ACTOR_ID     Actor identity ID (default: auto-detect)
  --output-dir OUTPUT_DIR Output directory (default: current)
```
