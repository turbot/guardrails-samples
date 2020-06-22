# Get notifications by notification type

This script will return a filtered collection of notifications the notification class to filter results.

The example has returns more data than is necessary as different fields are populated in GraphQL when using differing
notification class values.

| Notification type  | Fields returned         |
|--------------------|-------------------------|
| resource_*         | resource                |
| policy_value_*     | resource, policyValue   |
| policy_setting_*   | resource, policySetting |
| control_*          | resource, control       |
| grant-*            | resource, grant         |
| active_grants_*    | resource                |

By default the script will return all notifications that were returned over the last 10 days.
For more information on how to use [datetime filters](https://turbot.com/v5/docs/reference/filter#datetime-filters).

By default the script will sort the notifications displaying most recent first.
For more information on how to use [sorting](https://turbot.com/v5/docs/reference/filter#sorting).

This script will return a filtered collection of notifications using the notification type to filter results.
For more information on [notifications types](https://turbot.com/v5/docs/concepts/notifications#notification-types).

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
python3 get-notifications-by-type.py [options]
```

### Options

#### Details

-c, --config-file

> Pass an optional yaml config file.

-p, --profile

> Profile to be used from config file.

-t, --notification_type

> Set the notification type, for more information see https://turbot.com/v5/docs/concepts/notifications#notification-types

-d, --datetime_filter

> Configures the date range to filter the result, for more information see https://turbot.com/v5/docs/reference/filter#datetime-filters

-s, --sort

> The field to use for sorting the results, for more information see https://turbot.com/v5/docs/reference/filter#sorting

--help

> Lists all the options and their usages.

#### Example usage

##### Example 1

Returns all `resource` notifications for the last 10 days returning latest first.

```shell
python3 get-notifications-by-type.py 
```

##### Example 2

Using a different notification type.

```shell
python3 get-notifications-by-type.py -t "policy_setting_created,policy_setting_updated,policy_setting_deleted"
```

##### Example 3

Run returning oldest entries first.

```shell
python3 get-notifications-by-type.py -s "timestamp"
```

##### Example 4

Return entries older than 5 days.

```shell
python3 get-notifications-by-type.py -d >T-5d
```

##### Example 5

Return entries withing the last two hours.

```shell
python3 get-notifications-by-type.py -d <>T-2h
```

##### Example 6

Run the script using credentials given in a credential file `credentials.yml`.

```shell
python3 get-notifications-by-type.py -c .config/turbot/credentials.yml
```

##### Example 7

Run the script using a credentials file and using the credential details using the profile `env`.

```shell
python3 get-notifications-by-type.py -c .config/turbot/credentials.yml -p env --notification_class resource
```

## Virtual environments deactivation

Once the script has been run, it is advised to deactivate the virtual environment if a virtual environment was used
to install the script dependencies.

This is accomplished by running the command:

```shell
deactivate
```
