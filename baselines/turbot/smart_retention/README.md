# Smart Retention Baseline

Stale data from processes and deleted resources can accumulate over time.  Turbot Enterprise 5.23.0 introduced Smart Retention  that will clean up this unwanted data.  Please refer to [Turbot > Workspace > Retention](https://turbot.com/v5/mods/turbot/turbot/inspect#/policy/types/retention) for more information. 

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
