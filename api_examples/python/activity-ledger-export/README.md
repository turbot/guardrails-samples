# Activity Ledger Export

Exports Turbot action notifications (the "Activity Ledger") for a configurable time window to a CSV file. Bypasses the 30-day / 5,000-row limits of the Guardrails UI by paginating through all results via the GraphQL API.

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
| `--days` | Fetch activity from the last N days. Mutually exclusive with `--hours`. |
| `--hours` | Fetch activity from the last N hours. Mutually exclusive with `--days`. |
| `--actor-id` | Filter by a specific actor identity ID. Defaults to the Turbot Identity for the workspace. |
| `--all-actors` | Include activity from all actors, not just Turbot Identity. |
| `--csp` | Limit to a cloud provider's resources: `aws`, `azure`, or `gcp`. |
| `--resource-type` | Filter by resource type IDs, comma-separated. Overrides `--csp`. |
| `--page-size` | Number of notifications per API request. Default: `200`. |
| `-o`, `--output` | Output CSV file path. Default: `activity_ledger.csv`. |

### Examples

#### Last 90 days of Turbot Identity activity (default)

```shell
python3 activity_ledger_export.py --days 90
```

The Turbot Identity actor ID is resolved automatically from the workspace.

#### Last 90 days, AWS resources only

```shell
python3 activity_ledger_export.py --days 90 --csp aws
```

#### Last 90 days, all actors (Turbot + human users)

```shell
python3 activity_ledger_export.py --days 90 --all-actors
```

#### Last 90 days, AWS and Azure resources, Turbot actor only

```shell
python3 activity_ledger_export.py \
  --days 90 \
  --resource-type "tmod:@turbot/aws#/resource/types/aws,tmod:@turbot/azure#/resource/types/azure"
```

#### Last 24 hours with a custom output file

```shell
python3 activity_ledger_export.py --hours 24 --output last_24h_activity.csv
```

#### Use a specific credentials profile

```shell
python3 activity_ledger_export.py --days 90 --profile prod
```

## Finding the Turbot Actor ID

To find the actor identity ID for the Turbot system account (used to filter for automated Turbot actions only), run the following GraphQL query in the Guardrails API Explorer:

```graphql
query GetTurbotActorId {
  resources(filter: "resourceTypeId:tmod:@turbot/turbot#/resource/types/turbotDirectory limit:1") {
    items {
      turbot {
        id
        title
      }
    }
  }
}
```

Or use the query from the repository at `queries/notifications/get_turbot_actor_id.graphql`.

## CSV Output

| Column | Description |
| ------ | ----------- |
| `notification_id` | Guardrails notification ID (formatted for Excel compatibility). |
| `timestamp` | When the action occurred. |
| `actor` | Identity that performed the action (e.g. `Turbot` or a user name). |
| `message` | Description of the action taken. |
| `resource_aka` | Primary AKA (ARN or equivalent) of the affected resource. |
| `resource_title` | Display name of the affected resource. |
| `resource_type` | Resource type hierarchy (e.g. `AWS > S3 > Bucket`). |
| `resource_trunk` | Full resource hierarchy path (e.g. `Turbot > Org > Account > Region > Bucket`). |
| `detail_link` | Direct link to the notification in the Guardrails UI. |
