# Azure Setup Baseline

The Azure setup baseline terraform implements common configurations on your Turbot environment required to import an Azure subscription.

- Before importing, you should determine a folder structure that is suitable for your environment.
- You must have event handler and event poller enabled

## Prerequisites

To run the Azure setup baseline, you must have:

- [Terraform](https://www.terraform.io) Version 12
- [Turbot Terraform Provider](https://github.com/turbotio/terraform-provider-turbot)
- [Credentials](https://turbot.com/v5/docs/reference/cli/installation#setup-your-turbot-credentials) Configured to connect to your Turbot workspace and AWS account
- `turbot`, `turbot-iam`, `azure` and `azure-monitor` mods with their dependencies.

## Running the Baseline

To run the azure setup baseline:

- Go to the Azure setup baseline directory in the repository with `cd azure_setup`
- Update `smart_folder_title` in `default.tfvars`
- Run `terraform plan -var-file=default.tfvars` and review the plan to be applied
- Run `terraform apply -var-file=default.tfvars` to apply the plan
