# Control Summaries by Control Type

Queries control summaries grouped by control type and exports the results to a CSV file. For each top-level service (e.g. Events, IAM, VPC), it also fetches and displays the child control types indented beneath it. Useful for compliance reporting and dashboards that need a breakdown of control states (ok, alarm, error, etc.) per control type.

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
python3 control_summaries_by_control_type.py
```

### Options

| Option | Description |
| ------ | ----------- |
| `-c`, `--config-file` | Path to an optional yaml config file. |
| `-p`, `--profile` | Profile to use from the config file. Default: `default`. |
| `--csp` | Cloud service provider: `aws`, `azure`, or `gcp`. Default: `aws`. |
| `--state` | Control states to include, comma-delimited. Default: `active`. e.g. `alarm,error,invalid`. |
| `-s`, `--sort` | Sort order for results. Default: `-total` (descending by total). |
| `-l`, `--limit` | Maximum number of parent control types to return. Default: `100`. |
| `-o`, `--output` | Output CSV file path. Default: `control_summaries.csv`. |

### Examples

#### Default: Top 100 AWS control types by total controls

```shell
python3 control_summaries_by_control_type.py
```

#### Top 10 AWS control types

```shell
python3 control_summaries_by_control_type.py -l 10
```

#### Azure control types

```shell
python3 control_summaries_by_control_type.py --csp azure
```

#### Only control types with alarm or error controls

```shell
python3 control_summaries_by_control_type.py --csp aws --state alarm,error
```

#### GCP control types sorted by alarm count, output to custom file

```shell
python3 control_summaries_by_control_type.py \
  --csp gcp \
  --sort "-alarm" \
  --limit 20 \
  --output gcp_alarm_report.csv
```

#### Use a specific profile

```shell
python3 control_summaries_by_control_type.py \
  --csp aws \
  --profile prod \
  --config-file /path/to/config.yml
```

## CSV Output

The output CSV file contains the following columns:

| Column | Description |
| ------ | ----------- |
| `level` | `parent` for top-level service groupings, `child` for individual control types. |
| `parent_control_type` | Title of the parent control type (populated for child rows). |
| `control_type_title` | Display name of the control type. |
| `control_type_uri` | The Guardrails control type URI. |
| `control_type_id` | The Guardrails control type ID. |
| `trunk` | The control type hierarchy path. |
| `total` | Total number of controls. |
| `ok` | Controls in OK state. |
| `alarm` | Controls in Alarm state. |
| `error` | Controls in Error state. |
| `invalid` | Controls in Invalid state. |
| `tbd` | Controls in TBD state. |
| `skipped` | Controls in Skipped state. |
