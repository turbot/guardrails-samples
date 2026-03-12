# Delete Resources in batches from Guardrails

This script first disables discovery-related policies for targeted resources that are planned for removal from Guardrails. This prevents discovery controls from re-running and re-adding the resources to the Guardrails [CMDB](https://turbot.com/guardrails/docs/reference/glossary#cmdb).

When executed with the `--disable` flag, the script disables discovery policies for the specified resources and then deletes them **`along with their descendants`**.

Deletion is performed in batches, with an optional `cooldown` period between batches to prevent system overload.

**Features:**
- **Dry-run mode**: Run without `--execute` flag to see how many resources would be deleted without making changes
- **Graceful error handling**: Automatically skips resources that are already deleted or not found, allowing the script to complete successfully
- **Summary report**: Provides a detailed summary showing successfully deleted, skipped, and failed resources
- **Batch processing**: Processes deletions in configurable batches with cooldown periods to prevent system overload

For more details, refer to [Filtering Resources](https://turbot.com/guardrails/docs/reference/filter/resources).

## Prerequisites

To run the scripts, you must have:

- [Python 3.\*.\*](https://www.python.org/downloads/)
- [Pip](https://pip.pypa.io/en/stable/installing/)

## Setup

This sections details how to set up an environment in order to run the script.

### Virtual Environments Activation

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

### Turbot Configuration

Credentials and end point details need to be configure before being able to connect to a Turbot installation.
This configuration can be entered either using environment variables or a configuration file.

#### Environment Variables

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

#### Configuration File

Example configuration file:

```yaml
default:
  accessKey: dc61d2e4-730c-4b54-8c3c-6ef180150814
  secretKey: 6ef18015-7d0c-2b51-4d2c-dc61d2e63a22
  workspace: "https://demo-acme.cloud.turbot.com/"
```

This script will automatically search for a `credentials.yml` file in `~/.config/turbot/` or you can save the yaml configuration file anywhere and provide the `--config /path/to/config.yml --profile default` as a command line option.

## Executing the Script

To run a the Python script:

1. Install and configure the [pre-requisites](#Prerequisites)
1. Using the command line, navigate to the directory for the Python script
1. Create and activate the Python virtual environment
1. Install dependencies
1. Run the Python script using the command line
1. Deactivate the Python virtual environment

### Synopsis

```shell
python3 delete_resources_batches.py [options]
```

### Options

#### Details

-c, --config-file

> [String] Pass an optional yaml config file.

-p, --profile

> [String] Profile to be used from config file.

-r, –resource-id

> [String] ID of the resource to delete along with its descendants.

-b, --batch

> [Int] The number of resources to delete before cooldown per cycle. Default: 100

-d, --cooldown

> [Int] Number of seconds to pause before the next batch of resources are deleted. Setting this value to `0` will disable cooldown. Default: 30

-e, --execute

> **Required flag** to actually perform the deletion. Without this flag, the script will run in dry-run mode and only show how many resources would be deleted.

–disable

> Disable discovery-related policies by setting them to Skip before deletion.

--help

> Lists all the options and their usages.

#### Example Usage

##### Example 1: Dry-Run (Simulate Deletion)

Simulates the deletion process without making any changes. Shows how many resources would be deleted.

```shell
python3 delete_resources_batches.py --resource-id <resource_id>
```

**Output example:**
```
Fetching descendants for deletion...
Found 150 resources (including parent) to delete.

--execute flag not set. Exiting without deletion.
```

##### Example 2: Delete Resources and Disable Policies

Disables discovery-related policies for the specified resource and deletes the resource along with its descendants.

```shell
python3 delete_resources_batches.py --resource-id <resource_id> --disable --execute
```

##### Example 3: Delete Resources in Batches of 50 with a Cooldown

Deletes resources in batches of 50, pausing for 60 seconds between batches.

```shell
python3 delete_resources_batches.py --resource-id <resource_id> -b 50 -d 60 --execute
```

##### Example 4: Use a Configuration File for Credentials

Runs the script using credentials specified in a configuration file.

```shell
python3 delete_resources_batches.py --config ~/.config/turbot/credentials.yml --profile default --resource-id <resource_id> --execute
```

##### Example 5: Dry-Run with Configuration File

Run a dry-run using a specific profile from your credentials file.

```shell
python3 delete_resources_batches.py --config ~/.config/turbot/credentials.yml --profile shaktiman --resource-id <resource_id>
```

## Output and Error Handling

The script provides detailed output during execution:

- **Progress**: Shows each resource being deleted
- **Warnings**: Displays warnings for resources that are already deleted (skipped)
- **Errors**: Shows errors for resources that fail to delete (non-blocking)
- **Summary**: Provides a final summary report with counts

**Example Summary Output:**
```
============================================================
Deletion Summary:
  ✅ Successfully deleted: 145 resources
  ⚠️  Skipped (not found): 5 resources
  ❌ Failed: 0 resources
  📊 Total processed: 150 / 150 resources
============================================================
```

**Note:** The script gracefully handles "Not Found" errors, which can occur when:
- A resource was already deleted manually
- A parent resource deletion cascades to children
- Resources are deleted between fetching the list and deletion

The script will continue processing all resources even if some are not found, ensuring maximum cleanup.

## Virtual Environments Deactivation

Once the script has been run, it is advised to deactivate the virtual environment if a virtual environment was used
to install the script dependencies.

This is accomplished by running the command:

```shell
deactivate
```
