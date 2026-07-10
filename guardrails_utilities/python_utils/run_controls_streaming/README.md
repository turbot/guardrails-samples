# Run controls streaming

Streams controls matching the provided filter and re-runs them page by page if `--execute` is set,
without enumerating the full result set first.

This is a streaming alternative to [run_controls_batches](../run_controls_batches). The batches
script pages through every matching control collecting IDs into memory before it triggers the
first re-run. On workspaces with hundreds of thousands of matching controls that means a long
enumeration phase before any work starts, and the collected ID list is stale by the time the
script reaches the end of it. This script instead fetches one page of controls at a time and
re-runs each page as it arrives, so:

- Controls start re-running within seconds, regardless of how many match the filter.
- Memory usage is limited to the set of already-triggered control IDs.
- The total matching count is fetched up front with a single cheap stats query, purely for
  progress reporting.

## How it converges

Re-running a control is asynchronous, so a just-triggered control can still match a state filter
(for example `state:error`) for a while afterwards. The script tracks which control IDs it has
already triggered and never triggers the same control twice in one run.

Because the result set shifts underneath the paging cursor as controls change state, a single
pass can miss some controls. When a pass completes, the script starts another pass from the
beginning of the filter to pick up anything that was missed, skipping everything already
triggered. It stops when a pass finds no new controls (the filter is drained) or when
`--max-controls` / `--max-passes` limits are reached.

Controls that remain in the filtered state after being re-run (for example, controls that error
again) are not re-triggered; re-run the script to give them another attempt.

For further reference see [filtering controls](https://turbot.com/v5/docs/reference/filter/controls#filtering-controls).

## Prerequisites

To run the scripts, you must have:

- [Python 3.\*.\*](https://www.python.org/downloads/)
- [Pip](https://pip.pypa.io/en/stable/installing/)

## Setup

This section details how to set up an environment in order to run the script.

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

Credentials and endpoint details need to be configured before being able to connect to a Turbot installation.
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

1. Install and configure the [pre-requisites](#prerequisites)
1. Using the command line, navigate to the directory for the Python script
1. Create and activate the Python virtual environment
1. Install dependencies
1. Run the Python script using the command line
1. Deactivate the Python virtual environment

### Synopsis

```shell
python3 run_controls_streaming.py [options]
```

### Options

#### Details

-c, --config-file

> [String] Pass an optional yaml config file.

-p, --profile

> [String] Profile to be used from config file.

-f, --filter

> [String] Used to filter out matching controls.

-b, --batch

> [Int] Page size, and the number of controls to run before cooldown per cycle.

-d, --cooldown

> [Int] Number of seconds to pause between batches. Setting this value to `0` will disable cooldown.

-m, --max-controls

> [Int] Maximum number of controls to run before stopping. The value `-1` runs until the filter is drained.

--max-passes

> [Int] Maximum number of passes over the filter. The value `-1` keeps passing until a pass finds no new controls.

-e, --execute

> Will re-run controls when found.

-i, --insecure

> Disable SSL certificate verification.

--help

> Lists all the options and their usages.

#### Example usage

##### Example 1

Report the number of matching controls without re-running anything. This is a single stats
query, so it is fast even with hundreds of thousands of matches.

```shell
python3 run_controls_streaming.py
```

##### Example 2

Re-run all the controls found.

```shell
python3 run_controls_streaming.py --execute
```

##### Example 3

Re-run controls in error state.

```shell
python3 run_controls_streaming.py -f "state:error" --execute
```

##### Example 4

Re-run controls in multiple states.

```shell
python3 run_controls_streaming.py -f "state:tbd,error,alarm" --execute
```

##### Example 5

Re-run installed controls.

```shell
python3 run_controls_streaming.py -f "state:tbd,error controlType:'tmod:@turbot/turbot#/control/types/controlInstalled'" --execute
```

##### Example 6

Re-run controls in batches of 200 with no cool down.

```shell
python3 run_controls_streaming.py -b 200 -d 0 --execute
```

##### Example 7

Smoke test on a large workspace: trigger at most 500 controls, then stop.

```shell
python3 run_controls_streaming.py -m 500 --execute
```

##### Example 8

Make a single pass over the filter without re-checking for controls missed while the result
set shifted.

```shell
python3 run_controls_streaming.py --max-passes 1 --execute
```

##### Example 9

Run the script using credentials given in a credential file `credentials.yml` with the profile `env`.

```shell
python3 run_controls_streaming.py -c .config/turbot/credentials.yml -p env
```

## Virtual environments deactivation

Once the script has been run, it is advised to deactivate the virtual environment if a virtual environment was used
to install the script dependencies.

This is accomplished by running the command:

```shell
deactivate
```
