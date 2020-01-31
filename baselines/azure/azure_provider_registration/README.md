# Azure Provider Registration Baseline

Turbot Azure Provider Registration baseline provides a [terraform](https://www.terraform.io) configuration to enable or disable provider registration for Azure services.

  - Service names must match the `policy_map`.

> It is advised not to modify the `policy_map` list.

## Prerequisites

To run the Azure Provider Registration baseline, you must have:

  - [Terraform](https://www.terraform.io) Version 12
  - [Turbot Terraform Provider](https://github.com/turbotio/terraform-provider-turbot)
  - [Credentials](https://turbot.com/v5/docs/reference/cli/installation#setup-your-turbot-credentials) Configured to connect to your Turbot workspace and AWS account

## Running the Baseline

To execute the Azure Provider Registration baseline:

  - Go to the Azure provider registration directory with `cd azure_provider_registration`
  - Run `terraform plan -var-file=default.tfvars` to review the changes to be applied
  - Run `terraform apply -var-file=default.tfvars` to apply the changes