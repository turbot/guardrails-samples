# Azure Services Baseline

Turbot Azure Services baseline provides a terraform configuration to enable or disable Azure services in Turbot.

## Prerequisites

To run the Azure Services baseline, you must have:

  - [Terraform](https://www.terraform.io) Version 12
  - [Turbot Terraform Provider](https://github.com/turbotio/terraform-provider-turbot)
  - [Credentials](https://turbot.com/v5/docs/reference/cli/installation#setup-your-turbot-credentials) Configured to connect to your Turbot workspace and AWS account

## Running the Baseline

To run the Azure services baseline:

  - Go to the Azure services baseline directory in the repository with `cd azure_services`
  - Update the `target_resource` in `default.tfvars`
  - Run `terraform plan -var-file=default.tfvars` to review the changes to be applied
  - Run `terraform apply -var-file=default.tfvars` to apply the changes