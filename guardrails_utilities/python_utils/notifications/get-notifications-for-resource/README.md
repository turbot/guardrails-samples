# Get notifications for resource

The script will return the last notification for the found resource if it exists and will return the
notifications with the latest notification as the initial entry.

The script allows the user to configure the number of notifications and allows for targeting specific resources.

By default the script is configured to return the last notification only for the resource `tmod:@turbot/turbot#/`.
For more information on how to [limit results](https://turbot.com/v5/docs/reference/filter#limiting-results).

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
python3 get-notifications-for-resource.py [options]
```

### Options

#### Details

-c, --config-file

> [String] Pass an optional yaml config file.

-p, --profile

> [String] Profile to be used from config file.

-l, --limit

> [Int] Set to returns the last n notifications, for more information see https://turbot.com/v5/docs/reference/filter#limiting-results.

-i, --id

> [String] Find the notification for a resource based on its AKA or ID.

--help

> Lists all the options and their usages.

#### Example usage

##### Example 1

Returns the last notification for the resource `tmod:@turbot/turbot#/`.

```shell
python3 get-notifications-for-resource.py 
```

##### Example 2

Returns the last notification for a different resource 
`tmod:@turbot/aws-iam#/control/types/roleInlinePolicyStatementsApproved`.

```shell
python3 get-notifications-for-resource.py -i "tmod:@turbot/aws-iam#/control/types/roleInlinePolicyStatementsApproved"
```

##### Example 3

Run returning the latest 10 notification

```shell
python3 get-notifications-for-resource.py -l 10
```

##### Example 4

Run the script using credentials given in a credential file `credentials.yml`.

```shell
python3 get-notifications-for-resource.py -c .config/turbot/credentials.yml
```

##### Example 5

Run the script using a credentials file and using the credential details using the profile `env`.

```shell
python3 get-notifications-for-resource.py -c .config/turbot/credentials.yml -p env --notification_class resource
```

## Virtual environments deactivation

Once the script has been run, it is advised to deactivate the virtual environment if a virtual environment was used
to install the script dependencies.

This is accomplished by running the command:

```shell
deactivate
```
