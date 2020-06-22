# Get notifications by notification class

This script will return a filtered collection of notifications the notification class to filter results.

The example has returns more data than is necessary as different fields are populated in GraphQL when using differing
notification class values.

| Notification class type  | Fields returned         |
|--------------------------|-------------------------|
| resource                 | resource                |
| policyValue              | resource, policyValue   |
| policySetting            | resource, policySetting |
| control                  | resource, control       |
| grant                    | resource, grant         |
| activeGrant              | resource                |

By default the script will return all notifications that were returned over the last 10 days.
For more information on how to use [datetime filters](https://turbot.com/v5/docs/reference/filter#datetime-filters).

By default the script will sort the notifications displaying most recent first.
For more information on how to use [sorting](https://turbot.com/v5/docs/reference/filter#sorting).

For more information on [filtering notifications](https://turbot.com/v5/docs/reference/filter/notifications#filtering-notifications).

## Prerequisites

To run the scripts, you must have:

- [Python 3.\*.*](https://www.python.org/downloads/)
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

Then install python library dependencies:

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

### Synopsis

```shell
python3 get-notifications-by-class.py [options]
```

### Options

#### Details

-c, --config-file

> [String] Pass an optional yaml config file.

-p, --profile

> [String] Profile to be used from config file.

--notification_class

> [String] Set the notification class, for more information see https://turbot.com/v5/docs/reference/filter/notifications#filtering-notifications.

--datetime_filter

> [String] Configures the date range to filter the result, for more information see https://turbot.com/v5/docs/reference/filter#datetime-filters.

--sort

> [String] The field to use for sorting the results, for more information see https://turbot.com/v5/docs/reference/filter#sorting.

--help

> Lists all the options and their usages.

#### Example usage

##### Example 1

Returns all `resource` notifications for the last 10 days returning latest first.

```shell
python3 get-notifications-by-class.py 
```

##### Example 2

Using a different notification class.

```shell
python3 get-notifications-by-class.py -n "policyValue"
```

##### Example 3

Run returning oldest entries first.

```shell
python3 get-notifications-by-class.py -s "timestamp"
```

##### Example 4

Return entries older than 5 days.

```shell
python3 get-notifications-by-class.py -d >T-5d
```

##### Example 5

Return entries withing the last two hours.

```shell
python3 get-notifications-by-class.py -d <>T-2h
```

## Virtual environments deactivation

Once the script has been run, it is advised to deactivate the virtual environment if a virtual environment was used
to install the script dependencies.

This is accomplished by running the command:

```shell
deactivate
```