# Control usage by resource type

Writes a CSV with one row per installed resource type, showing how many active controls ran against that resource type on a given day, split into CMDB and non-CMDB controls.

Use it to answer questions like:

- Which resource types run only CMDB and Discovery controls, with no guardrails (non-CMDB controls) applied?
- Which mods are installed but discover few or no resources, and could be uninstalled?
- What is the ratio of CMDB to non-CMDB controls for each resource type?

Active control counts come from the same workspace usage data as the [workspace_usage](../../workspace_usage) script, so the totals match the daily active control counts used for billing.

## Output

| Column | Description |
|--------|-------------|
| Date | The usage date. |
| Mod | The mod that defines the resource type, e.g. `@turbot/aws-ec2`. |
| Resource Type | The resource type path, e.g. `AWS > EC2 > Instance`. |
| Resource Type URI | The resource type URI, e.g. `tmod:@turbot/aws-ec2#/resource/types/instance`. |
| Active Controls | All active controls for the resource type. |
| Active CMDB Controls | Active controls in the CMDB category, including Discovery. |
| Active Discovery Controls | Active Discovery controls. These are also counted in Active CMDB Controls. |
| Active Non-CMDB Controls | Active controls in all other categories (guardrails such as tags, approved, active, encryption, etc.). |

Notes:

- Every installed resource type is listed, including resource types with no active controls.
- Controls are counted against the resource type they are defined under. For example, `AWS > EC2 > Instance > Discovery` controls run on regions, but are counted against `AWS > EC2 > Instance`.
- Controls from the `@turbot/turbot` mod are included in the output but are not billable.
- If a control type was uninstalled after the usage date, its controls are reported in a row named `(uninstalled or unknown)`.

## Prerequisites

To run the scripts, you must have:

- [Python 3.\*.\*](https://www.python.org/downloads/)
- [Pip](https://pip.pypa.io/en/stable/installing/)

## Setup

This sections details how to set up an environment in order to run the script.

### Virtual environments activation

We recommend the use of [virtual environment](https://docs.python.org/3/library/venv.html).

To setup a virtual environment:

```shell
python3 -m venv .venv
```

Once created, to activate the environment:

```shell
source .venv/bin/activate
```

### Dependencies

Then install Python library dependencies:

```shell
pip3 install -r requirements.txt
```

### Turbot configuration

Credentials and end point details need to be configured before being able to connect to a Turbot Guardrails workspace.
This configuration can be entered either using environment variables or a configuration file.

#### Environment variables

```shell
export TURBOT_WORKSPACE="https://<environment-name>.cloud.turbot.com/"
export TURBOT_ACCESS_KEY_ID=ac61d2e4-730c-4b54-8c3c-6ef172390814
export TURBOT_SECRET_ACCESS_KEY=151b296b-0694-4a28-94c4-4b67fa82ab2c
```

#### Configuration file

Example configuration file:

```yaml
default:
  accessKey: dc61d2e4-730c-4b54-8c3c-6ef180150814
  secretKey: 6ef18015-7d0c-2b51-4d2c-dc61d2e63a22
  workspace: "https://demo-acme.cloud.turbot.com/"
```

This script will automatically use the `credentials.yml` file in `~/.config/turbot/` (the same file used by the Turbot CLI), or you can save the yaml configuration file anywhere and provide the `--config-file /path/to/config.yml --profile default` command line options.

The credentials need at least `Turbot/Metadata` permissions on the resources you want counted. Use credentials with `Turbot/Metadata` or higher at the Turbot level to report on the whole workspace.

## Executing the script

### Synopsis

```shell
python3 control_usage_by_resource_type.py [options]
```

### Options

-c, --config-file

> [String] Pass an optional yaml config file.

-p, --profile

> [String] Profile to be used from config file. Defaults to `default`.

-d, --date

> [String] Usage date in `YYYYMMDD` format. Defaults to yesterday.

-o, --output

> [String] Output CSV file. Defaults to `control_usage_by_resource_type_<date>.csv`.

-i, --insecure

> Disable SSL certificate verification.

--help

> Lists all the options and their usages.

### Example usage

Report on yesterday's usage using the `default` profile:

```shell
python3 control_usage_by_resource_type.py
```

Report on a specific day using the `acme` profile:

```shell
python3 control_usage_by_resource_type.py -p acme -d 20261005
```
