# Run Controls In Batches

Finds all controls matching the provided filter, then re-runs them in batches if `--execute` is set.
After each batch the script will then enter cool down mode which will wait a number of seconds before running the 
next batch of controls.

## Prerequisites

To run the scripts, you must have:

- [Python](https://www.python.org/) version 3 or above
- [Pip](https://pip.pypa.io/)

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
python3 run_controls_batches.py [options]
```

### Options

#### Details

-c, --config-file

> [String] Pass an optional yaml config file.

-p, --profile

> [String] Profile to be used from config file.

-f, --filter

> [String] Filter to run.

-b, --batch

> [Int] The number of controls to run before cooldown per cycle

-s, --start-index

> [Int] Sets the starting point in the returned control collection. All controls starting at the starting point will be run.

-d, --cooldown

> [Int] Number of seconds to pause before the next batch of controls are run. Setting this value to `0` will disable cooldown.

-m, --max-batch

> [Int] The maximum number of batches to run. The value `-1` will run all the return controls from the starting point.

-e, --execute

> Will re-run controls when found.

--help

> Lists all the options and their usages.

#### Example usage

##### Example 1

The return the number of controls found that will be run by the script without re-running the control.

```shell
python3 run_controls_batches.py 
```

##### Example 2

Re-runs all the controls found.

```shell
python3 run_controls_batches.py --execute
```

##### Example 3

Re-run controls in TBD state - default behavior.

```shell
python3 run_controls_batches.py -f "state:tbd"
```

##### Example 4

Re-run controls in error state.

```shell
python3 run_controls_batches.py -f "state:error"
```

##### Example 5

Re-run controls in multiple states.

```shell
python3 run_controls_batches.py -f "state:tbd,error,alarm"
```

##### Example 6

Re-run installed controls.

```shell
python3 run_controls_batches.py -f "state:tbd,error controlType:'tmod:@turbot/turbot#/control/types/controlInstalled'"
```

##### Example 7

Re-run AWS Event Handler controls.

```shell
python3 run_controls_batches.py -f "controlType:'tmod:@turbot/aws#/control/types/eventHandlers'"
```

##### Example 8

Re-run Discovery controls

```shell
python3 run_controls_batches.py -f "Discovery controlCategory:'tmod:@turbot/turbot#/control/categories/cmdb'"
```

##### Example 9

Re-run Discovery controls in batches of 200

```shell
python3 run_controls_batches.py -b 200
```

##### Example 10

Re-run Discovery controls with no cooldown

```shell
python3 run_controls_batches.py -d 0
```

## Virtual environments deactivation

Once the script has been run, it is advised to deactivate the virtual environment if a virtual environment was used
to install the script dependencies.

This is accomplished by running the command:

```shell
deactivate
```