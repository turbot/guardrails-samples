# Local Directory Baseline

The Turbot local directory baseline provides a terraform configuration that allows creation of a local directory and grant Turbot/Owner and Turbot/Admin to users based on the required configurations.

## Pre-requisites

To run the local directory baseline, you must have:

- [Terraform](https://www.terraform.io) Version 12
- [Turbot Terraform Provider](https://github.com/turbotio/terraform-provider-turbot)
- [Credentials](https://turbot.com/v5/docs/reference/cli/installation#setup-your-turbot-credentials) configured to connect to your Turbot workspace

## Running the Baseline

To execute the baseline you must run terraform and specify the local directory name you wish to create and list of users you want to grant Turbot/Owner and Turbot/Admin role.

To run the mod install baseline:

- Go to the AWS permissions directory with `cd local_directory`
- Update `default.tfvars` with appropriate values
- Run `terraform plan -var-file=default.tfvars` to review the plan for aws permissions
- Run `terraform apply -var-file=default.tfvars` to apply the changes
