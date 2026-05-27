# Control Detail by State Export

Lists controls filtered by state and exports detailed information to a CSV file. Includes control type hierarchy, resource AKA, resource hierarchy path, and state change timestamp for each control.

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

Setup environment variables for your Turbot installation:

```shell
export TURBOT_GRAPHQL_ENDPOINT="https://demo-acme.cloud.turbot.com/api/latest/graphql"
export TURBOT_ACCESS_KEY_ID=12345678-1a2b-3c4b-5e6f-111222333444
export TURBOT_SECRET_ACCESS_KEY=12345678-1a2b-3c4b-5e6f-111222333444
```

## Running the example

```shell
python3 control_detail_by_state_export.py
```

### Options

| Option | Description |
| ------ | ----------- |
| `-c`, `--config-file` | Path to an optional yaml config file. |
| `-p`, `--profile` | Profile to use from the config file. Default: `default`. |
| `--state` | Control states to filter, comma-delimited. Default: `alarm`. e.g. `alarm,invalid`. |
| `--control-type` | Control type ID to filter. e.g. `tmod:@turbot/aws-events#/resource/types/target`. |
| `-l`, `--limit` | Maximum number of controls to return. Default: `5000`. |
| `--page-size` | Number of controls per API request. Default: `200`. |
| `-o`, `--output` | Output CSV file path. Default: `control_detail_by_state.csv`. |

### Examples

#### Default: All alarm controls

```shell
python3 control_detail_by_state_export.py
```

#### Include alarm and invalid controls

```shell
python3 control_detail_by_state_export.py --state alarm,invalid
```

#### Filter by a specific control type

```shell
python3 control_detail_by_state_export.py --control-type "tmod:@turbot/aws-events#/resource/types/target"
```

#### Combine filters with custom output

```shell
python3 control_detail_by_state_export.py \
  --state alarm,invalid \
  --control-type "tmod:@turbot/aws-events#/resource/types/target" \
  --limit 100 \
  --output aws_events_alarm.csv
```

#### Use a specific profile

```shell
python3 control_detail_by_state_export.py \
  --profile prod \
  --config-file /path/to/config.yml
```

## CSV Output

The output CSV file contains the following columns:

| Column | Description |
| ------ | ----------- |
| `control_id` | The Guardrails control ID (formatted for Excel compatibility). |
| `control_state` | Current control state (alarm, invalid, etc.). |
| `control_type_trunk` | The control type hierarchy path (e.g. `AWS > HIPAA > IAM > ...`). |
| `resource_aka` | The primary AKA (also-known-as) identifier for the resource. |
| `resource_trunk` | The resource hierarchy path (e.g. `Turbot > Org > Folder > Account > Resource`). |
| `state_change_timestamp` | When the control last changed state. |
