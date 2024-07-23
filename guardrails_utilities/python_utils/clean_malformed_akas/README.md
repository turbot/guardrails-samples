# Clean Malformed AKAs

Finds and remediates AWS resources with a malformed AKA.

Sometimes, an AWS resource will be created in Turbot with a malformed AKA where the partition is missing from the AKA.  Discovery of this problem usually happens through a bunch of controls in an `invalid` state with complaints about malformed AKAs.  This problem does not affect the underlying AWS resource, just Turbot's record of the resource.

**Example**
Incorrect AKA: `arn::ec2:us-east-2:501300119281:accountattributes`
Correct AKA: `arn:aws:ec2:us-east-2:501300119281:accountattributes`

**Resolution Sequence**:
1. Search for all resources with malformed AKAs.
2. Delete the resource out of Turbot.  The resource is unaffected in AWS.
3. Rediscover the resource by running the appropriate Discovery control.

Setting the `--execute` flag will execute steps 2 and 3.

Follow the both steps in the [Usage](#Usage) section.  


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

Credentials and end point details need to be configured beforehand.  This configuration can be entered either using environment variables or a configuration file.

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
2. Using the command line, navigate to the directory for the Python script
3. Create and activate the Python virtual environment
4. Install dependencies
5. Run the Python script using the command line
6. Deactivate the Python virtual environment

### Synopsis

```shell
python3 clean_malformed_akas.py [options]
```

### Options

#### Details

-c, --config-file

> [String] Pass an optional yaml config file.

-p, --profile

> [String] Profile to be used from config file.

-e, --execute

> Will re-run controls when found.

--help

> Lists all the options and their usages.

### Usage

##### Step 1: Dump list of resources

Prints out a list of resources with malformed AKAs.  It's a great idea to dump the output to a file for future reference.

```shell
python3 clean_malformed_akas.py > malformed_akas.txt
```

#### Step 2: Execute destruction and rediscovery

1. Destroys resources with malformed AKAs 
2. For each account/region and each affected resource type, run the Discovery controls.

```shell
python3 clean_malformed_akas.py --execute
```

## Virtual environments deactivation

Once the script has been run, it is advised to deactivate the virtual environment if a virtual environment was used
to install the script dependencies.

This is accomplished by running the command:

```shell
deactivate
```
