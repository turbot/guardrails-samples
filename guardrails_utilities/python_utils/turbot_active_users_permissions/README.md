# Turbot Active Users Permissions Report

A script that generates a CSV report of user identities and their permissions in a Turbot environment. The report includes details such as profile information, last login timestamps, and permission levels for resources.

For further reference, see [Turbot's GraphQL API documentation](https://turbot.com/guardrails/docs/reference/graphql).

## Prerequisites

To run the script, you must have:

- [Python 3.\*.\*](https://www.python.org/downloads/)
- [Pip](https://pip.pypa.io/en/stable/installation/)

## Setup

This section details how to set up an environment in order to run the script.

### Virtual Environment Activation

We recommend the use of a [virtual environment](https://docs.python.org/3/library/venv.html).

To set up a virtual environment:

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

Credentials and end point details need to be configured before being able to connect to a Turbot installation.
This configuration can be entered either using environment variables or a configuration file.

#### Environment variables

Use either configuration for your Turbot installation:

```shell
export TURBOT_WORKSPACE="https://<environment-name>.cloud.turbot.com/"
export TURBOT_ACCESS_KEY_ID=ac61d2e4-730c-4b54-8c3c-6ef172390814
export TURBOT_SECRET_ACCESS_KEY=151b296b-0694-4a28-94c4-4b67fa82ab2c
```

or

```shell
export TURBOT_GRAPHQL_ENDPOINT="https://<environment-name>.cloud.turbot.com/api/latest/graphql"
export TURBOT_ACCESS_KEY_ID=ac61d2e4-730c-4b54-8c3c-6ef180150814
export TURBOT_SECRET_ACCESS_KEY=151b296b-0694-4a28-94c4-4767fa82bb2c
```

#### Configuration file

Example configuration file:

```yaml
default:
  accessKey: dc61d2e4-730c-4b54-8c3c-6ef180150814
  secretKey: 6ef18015-7d0c-2b51-4d2c-dc61d2e63a22
  workspace: "https://demo-acme.cloud.turbot.com/"
```

This script will automatically search for a `credentials.yml` file in `~/.config/turbot/` or you can save the yaml configuration file anywhere and provide the `--config /path/to/config.yml --profile default` as a command line option.

## Executing the script

To run the Python script:

1. Install and configure the [prerequisites](#prerequisites)
2. Using the command line, navigate to the directory for the Python script
3. Create and activate the Python virtual environment
4. Install dependencies
5. Run the Python script using the command line
6. Deactivate the Python virtual environment

### Synopsis

```shell
python3 turbot_active_users_permissions.py [options]
```

### Options

#### Details

-c, --config-file

> (Optional) [String] Path to a YAML configuration file. If not provided, the script will look for credentials in the default location (~/.config/turbot/credentials.yml).

-p, --profile

> (Optional) [String] Profile name to be used from the configuration file. Defaults to `default` if not specified.

-i, --insecure

> (Optional) [Flag] Disables SSL certificate verification. Use this only if connecting to environments with self-signed certificates.

-d, --days

> (Optional) [Integer] Number of days to look back for last login data. Defaults to 7 days if not specified.

-o, --output

> (Optional) [String] Custom output file name for the CSV report. If not provided, uses format: `{profile}_turbot_active_users_permissions_{date}.csv`.

--hyperlinks

> (Optional) [Flag] Includes clickable hyperlinks to profiles and resources in the CSV output. Default behavior is to include plain text only.

--help

> Displays all available options with descriptions and usage examples.

#### Example usage

##### Example 1

Run the script using default credentials to get identity permissions for the last 7 days

```shell
python3 turbot_active_users_permissions.py
```

##### Example 2

Run the script using a specific credentials file

```shell
python3 identity_permissions.py -c /path/to/credentials.yml -p profile1
```

##### Example 3

Run the script for a specific Turbot CLI profile

```shell
python3 identity_permissions.py -p demo-dev
```

##### Example 4

Run the script to look back 30 days instead of the default 7 days

```shell
python3 identity_permissions.py -p demo-dev -d 30
```

##### Example 5

Run the script with a custom output filename

```shell
python3 identity_permissions.py -p demo-dev -o custom_identity_report.csv
```

##### Example 6

Run the script with hyperlinks included in the CSV output

```shell
python3 identity_permissions.py -p demo-dev --hyperlinks
```

## Output

The script generates a CSV file with the following columns:

- **profile** - The full profile path of the identity
- **email** - The email address of the identity
- **First Name** - The given name of the identity
- **Last Name** - The family name of the identity
- **Last login** - The timestamp of the identity's last login
- **Permission Type** - The type of permission granted
- **Permission Level** - The level of access granted (e.g., Owner, Admin, ReadOnly)
- **Resource** - The resource to which the permission applies

When the `--hyperlinks` option is used, the Profile and Resource columns will contain clickable hyperlinks in Excel.

## Virtual environments deactivation

Once the script has been run, it is advised to deactivate the virtual environment if a virtual environment was used to install the script dependencies.

This is accomplished by running the command:

```shell
deactivate
```
