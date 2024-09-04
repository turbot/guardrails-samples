# AWS Account Import

A fully functioning example in Python which is used for importing an existing AWS account into Turbot.

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

Credentials and end point details need to be configure before being able to connect to a Turbot installation.
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

To run a the Python script:

1. Install and configure the [pre-requisites](#pre-requisites)
1. Using the command line, navigate to the directory for the Python script
1. Create and activate the Python virtual environment
1. Install dependencies
1. Run the Python script using the command line
1. Deactivate the Python virtual environment

### Synopsis

```shell
python3 aws_import.py [options]
```

### Options

#### Required options

The following arguments are required in order to run the example: 

- --parent
- --account
- --role_arn
- --external_id

#### Details

-c, --config-file

> [String] Pass an optional yaml config file.

-p, --profile

> [String] Profile to be used from config file.

--parent

> [String] The resource id for the parent folder of this subscription.

--account

> [String] The AWS account ID.

--role_arn

> [String] IAM Role used by Turbot for access to the AWS account.

--external_id

> [String] External ID for secure access to the Turbot IAM Role.

--help

> Lists all the options and their usages.

#### Example usage

##### Example 1

General usage.

```shell
python3 aws_import.py --parent <parent_id> --account <aws_account_id> --role_arn <access_role_arn> --external_id <external_id>
```

##### Example 2

Import using profile `env` from the configuration file `.config/turbot/credentials.yml`.
The parent resource to install under is `100000000000000`.
Importing the account `900000000000`.
Using the role ARN `arn:aws:iam::900000000000:role/turbot_service_role`.
Using the external id to granting access to your AWS resources to a third party of `50000000`.

```shell
python3 aws_import.py -c .config/turbot/credentials.yml --profile env --parent 100000000000000 --account 900000000000 --role_arn arn:aws:iam::900000000000:role/turbot_service_role --external_id 50000000
```

## Virtual environments deactivation

Once the script has been run, it is advised to deactivate the virtual environment if a virtual environment was used
to install the script dependencies.

This is accomplished by running the command:

```shell
deactivate
```
