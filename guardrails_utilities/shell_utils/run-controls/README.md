# Run controls

Finds all controls matching the provided filter, then re-runs them in batches if `--dry-run` is set to `false`.

For further reference see [filtering controls](https://turbot.com/v5/docs/reference/filter/controls#filtering-controls).

## Prerequisites

To run the scripts, you must have:

- [Turbot CLI](https://turbot.com/v5/developers/)
- [jq](https://stedolan.github.io/jq/download/)

## Setup

This sections details how to set up an environment in order to run the script.

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

To run the script:

1. Ensure that you have execute priviliges

### Synopsis

```shell
./run_controls.sh [options]
```

### Options

#### Details

--filter (Required)

> [String] Control query filter that will return a subset of controls to re-run.

--profile (Optional)

> [String] Turbot profile to be used from config file.
> If omitted, Turbot CLI will try use either the default profile or the environment variables that we set.

--sleep-time (Optional)

> [Integer] Time to back off during batches given in seconds.
> Defaults to 10 seconds.

--batch-size

> [Integer] The maximum size of the batch to run next.
> Defaults to 20 items.

--dry-run

> [Integer] Controls whether the batch run should actually run the controls when set to `false` or to simply display which controls will be run when set to `true`.
> Defaults to false

--help

> Lists all the options and their usages.

#### Example usage

##### Example 1:

List all controls that will be run in state of error.

```shell
./run_controls.sh --filter 'state:error'
```

##### Example 2:

Re-runs all the controls that will are in state of error.

```shell
./run_controls.sh --filter 'state:error' --dry-run false
```
**Note:** *If you do not provide `--dry-run false`, it will default to `--dry-run true` resulting listing of controls as mentioned in Example 1.*

##### Example 3:

Changing the batch size to 10.

In this example, it will `list` the controls in the batch size of 10.

```shell
./run_controls.sh --filter 'state:error' --batch-size 10
```

##### Example 4:

Listing specific control with batch size of 25

```shell
/run-controls.sh --filter 'state:error controlTypeId:tmod:@turbot/aws-ec2#/control/types/snapshotActive' --dry-run true --batch-size 25
```
Re-run specific control with batch size of 25

```shell
/run-controls.sh --filter 'state:error controlTypeId:tmod:@turbot/aws-ec2#/control/types/snapshotActive' --dry-run true --batch-size 25
```

##### Example 5:

Changing the back off time to 20 seconds.

```shell
./run_controls.sh --filter 'state:error' --sleep-time 20
```
