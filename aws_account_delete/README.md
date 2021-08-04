# Run policies

Finds all resources matching the provided filter, and deletes them in batches if `--execute` is set.

## Prerequisites

To run the scripts, you must have:

- [Python > 3.5.0](https://www.python.org/downloads/)
- [Terraform > 0.13](https://www.terraform.io/downloads.html)
- [Turbot CLI](https://turbot.com/v5/docs/reference/cli/installation)

## Setup

This sections details how to set up an environment in order to run the script.

### 1) check you have the correct version of all software:

```shell
> python3 --version
Python 3.8.2

> terraform --version
Terraform v1.0.3
on darwin_amd64

> turbot --version
1.28.3
```

### Test Connectivity to the Workspace

```shell
> turbot graphql resources --filter "resourceId:'arn:aws:::337619943512' level:self" --profile demo

resources:
  items:
    - type:
        uri: 'tmod:@turbot/aws#/resource/types/account'
      turbot:
        id: '165045082120479'
        parentId: '165043267908283'
        title: demo-account
```

If you have a connectivity error, please check you are using the correct profile, the default profile is named `default` instructions for creating your profile are located in the [v5 documentation](https://turbot.com/v5/docs/reference/cli/installation).

### Run the Terraform Template:

Update the main.tf file with the Turbot profile and account AKA you would like to delete:

```terraform
provider "turbot" {
  ## Update with the name of the local Turbot Profile 
  ## that is configured to connect to your workspace.
  profile  = "demo"
}

data "turbot_resource" "deleteThisAwsAccount" {
  ## Update with aka of the account to delete
  id = "arn:aws:::111222333444"
}
```

```shell
> terraform init
...

> terraform plan
...

> terraform apply
...
```

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
This configuration can be setup using the Turbot CLI.  

Please see https://turbot.com/v5/docs/reference/cli/installation for instructions on how to setup
turbot credentials and test them.

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
python3 delete_resources.py [options]
```

### Options

View options:
```shell
python3 delete_resources.py --help
```

#### Details

-c, --config-file

> [String] Pass an optional yaml config file.

-p, --profile

> [String] Turbot Profile to be used for connectivity

-a, --account-aka

> [String] Used to filter out matching policies.

--disable

> [Flag] If set will disable all cmdb policies for the aws account.

--delete

> [Flag] If set will delete resources from Turbot workspace.

--help

> Lists all the options and their usages.


#### Usage

##### Step 0 - Follow instructions above to test connectivity

##### Step 1 - Apply terraform template to remove event handlers

```shell
> terraform init
...

> terraform plan
...

> terraform apply
...
```

##### Step 2 - Run delete script in CHECK MODE: 

Return the number of cmdb policies found and resources found without deleting or setting them.

```shell
python3 delete_resources.py -p demo -a "arn:aws:::111222333444" 
```

Validate you are connected to the correct account and the number of resources is reasonable

##### Step 3 - Disable CMDB:

Disable's all CMDB controls in the account, which will result in resources being removed from Turbot.

```shell
python3 delete_resources.py -p demo -a "arn:aws:::111222333444" --disable
```

#### Step 4 - Wait one hour for the CMDB controls to clear resources

##### Step 5 - Delete remaining resources and account using the script

Delete remaining resources in the account: 

```shell
python3 delete_resources.py -p demo -a "arn:aws:::111222333444" --delete
```

##### Step 6 - Delete account account using the script

Delete the account from Turbot: 

```shell
python3 delete_resources.py -p demo -a "arn:aws:::111222333444" --delete-acct
```

## Virtual environments deactivation

Once the script has been run, it is advised to deactivate the virtual environment if a virtual environment was used
to install the script dependencies.

This is accomplished by running the command:

```shell
deactivate
```
