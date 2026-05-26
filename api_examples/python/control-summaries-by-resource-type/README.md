# Control Summaries by Resource Type

Queries control summaries grouped by resource type and exports the results to a CSV file. Useful for compliance reporting and dashboards that need a breakdown of control states (ok, alarm, error, etc.) per resource type.

## Prerequisites

- [Python 3.\*.\*](https://www.python.org/downloads/)
- [Pip](https://pip.pypa.io/en/stable/installing/)

## Setup

### Virtual environment

```shell
python3 -m venv .venv
source .venv/bin/activate
pip install -r requirements.txt
```

### Turbot configuration

Setup environment variables for your Turbot installation:

```shell
export TURBOT_GRAPHQL_ENDPOINT="https://demo-acme.cloud.turbot.com/api/latest/graphql"
export TURBOT_ACCESS_KEY_ID=12345678-1a2b-3c4b-5e6f-111222333444
export TURBOT_SECRET_ACCESS_KEY=12345678-1a2b-3c4b-5e6f-111222333444
```

## Running the example

```shell
python3 control_summaries_by_resource_type.py
```

### Options

| Option | Description |
| ------ | ----------- |
| `-c`, `--config-file` | Path to an optional yaml config file. |
| `-p`, `--profile` | Profile to use from the config file. Default: `default`. |
| `--csp` | Cloud service provider: `aws`, `azure`, or `gcp`. Default: `aws`. |
| `--state` | Control states to include, comma-delimited. Default: `active`. e.g. `alarm,error,invalid`. |
| `-s`, `--sort` | Sort order for results. Default: `-total` (descending by total). |
| `-l`, `--limit` | Maximum number of resource types to return. Default: `100`. |
| `-o`, `--output` | Output CSV file path. Default: `control_summaries.csv`. |

### Examples

#### Default: Top 5 AWS resource types by total controls

```shell
python3 control_summaries_by_resource_type.py
```

#### Azure resource types

```shell
python3 control_summaries_by_resource_type.py --csp azure
```

#### Only resource types with alarm or error controls

```shell
python3 control_summaries_by_resource_type.py --csp aws --state alarm,error
```

#### GCP resource types sorted by alarm count, output to custom file

```shell
python3 control_summaries_by_resource_type.py \
  --csp gcp \
  --sort "-alarm" \
  --limit 20 \
  --output gcp_alarm_report.csv
```

#### Use a specific profile

```shell
python3 control_summaries_by_resource_type.py \
  --csp aws \
  --profile prod \
  --config-file /path/to/config.yml
```

## CSV Output

The output CSV file contains the following columns:

| Column | Description |
| ------ | ----------- |
| `resource_type_title` | Display name of the resource type. |
| `resource_type_uri` | The Guardrails resource type URI. |
| `resource_type_id` | The Guardrails resource type ID. |
| `trunk` | The resource type hierarchy path. |
| `total` | Total number of controls. |
| `ok` | Controls in OK state. |
| `alarm` | Controls in Alarm state. |
| `error` | Controls in Error state. |
| `invalid` | Controls in Invalid state. |
| `tbd` | Controls in TBD state. |
| `skipped` | Controls in Skipped state. |
