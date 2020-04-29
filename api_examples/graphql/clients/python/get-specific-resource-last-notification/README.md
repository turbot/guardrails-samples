# Get notifications for a specific resource

This script provides an example of how to look up a resource id using a Turbot aka.
From there the script will return the last notification for the found resource if it exists.

In this example, the script is configured to return the last notification only.
For more information on how to [limit results](https://turbot.com/v5/docs/reference/filter#limiting-results).

In this example, the script will sort the notifications displaying most recent first.
For more information on how to use [sorting](https://turbot.com/v5/docs/reference/filter#sorting).

## Prerequisites

To run the scripts, you must have:

- [Python](https://www.python.org/) version 3 or above
- [Pip](https://pip.pypa.io/)

## Example

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

Credentials and end point details need to be configure before being able to connect to a Turbot installation
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

### Running the example

And run the example:

```shell
python3 get-specific-resource-last-notification.py

python3 get-specific-resource-last-notification.py --help

python3 get-specific-resource-last-notification.py --limit 1

python3 get-specific-resource-last-notification.py --aka "tmod:@turbot/turbot#/"

python3 get-specific-resource-last-notification.py --limit 1 --aka "tmod:@turbot/turbot#/"
```

### Virtual environments deactivation

When you are done, deactivate the virtualenv:

```shell
deactivate
```
