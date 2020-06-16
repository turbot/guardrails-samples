# Run Policies

Run this script to run all policies using the states of the policy as a filter to select the policies to run.

The command line argument `state` is used by the script to configure the policies to run that match the specified policy state(s).

The default `state` is `tbd`.

States for policies in Turbot can be:

- ok
- tbd
- error
- invalid

For further reference see [filtering policy values](https://turbot.com/v5/docs/reference/filter/policies#filtering-policy-values)

Multiple states can be added by separating each state using a comma.
For example when setting `state` to `tbd,error` the script will run all policies that are
in either the state of `tdb` or `error`.

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
pip install -r requirements.txt
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
python3 run_controls.py --help

python3 run_controls.py --filter "state:error"

python3 run_controls.py --filter "state:tbd" --execute
```

### Virtual environments deactivation

When you are done, deactivate the virtualenv:

```shell
deactivate
```
