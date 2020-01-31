# Mod Install Baseline

The Turbot mod install baseline provides a terraform configuration that allows installation of the [published mods](https://turbot.com/v5/mods) based on the required configurations.

  - Dependencies of a mod should be defined within the `depends_on` argument.
  - All mod dependencies should be included in the list, however this baseline would ensure that they install in order.
  - The list of all published mods is provided in  `full_mod_list.txt`

> NOTE: On a new workspace you would need to install `turbot` and `turbot-iam` before proceeding

## Pre-requisites

To run the mod install baseline, you must have:

  - [Terraform](https://www.terraform.io) Version 12
  - [Turbot Terraform Provider](https://github.com/turbotio/terraform-provider-turbot)
  - [Credentials](https://turbot.com/v5/docs/reference/cli/installation#setup-your-turbot-credentials) Configured to connect to your Turbot workspace and AWS account
  - `turbot` and `turbot-iam` mods installed and available

## Running the Baseline

To execute the baseline you must run terraform and specify the mods you wish to install and terraform will install the specified mods in the order of dependency.

To run the mod install baseline:

  - Go to the mod install baseline directory in the repository with `cd mod_install`
  - Run `terraform plan -var-file="all_mods.tfvars"` and review the mods to be installed
  - Run `terraform apply -var-file="all_mods.tfvars"` to begin the installation of all mods

You may also choose to install your own set of mods or refer to the list of `.tfvars ` files below containing mods with commonly used configurations.

| .tfvars File | Description |
|-|-|
| all_mods.tfvars | Includes the list of all mods published|
| aws_all.tfvars | Set of all AWS mods available for installation|
| aws_cis.tfvars | Set of dependent and required mods for AWS CIS recommendations|
| aws_common.tfvars | Set of common mods required for an aws account|
| azure_all.tfvars | Set of all Azure mods available for installation|
| azure_common.tfvars  | Set of common mods required for an Azure account|
| gcp_all.tfvars | Set of all GCP mods available for installations|
| gcp_cis.tfvars | Set of dependent and required mods for GCP CIS recommendations|
| gcp_common.tfvars | Set of common mods required for a GCP account|

## Mod Import

While installing mods on your environment, there might be mods that are be pre-installed. These mods can be imported using `terraform import` which will import it into the state file to be managed by terraform.

To import a mod you will require the `uri` or `resourceId`

  - To execute importing run `terraform import turbot_mod.aws tmod:@turbot/aws`

    - where `turbot_mod` is the resource type
    - `aws` is the name
    - `tmod:@turbot/aws` is the uri
