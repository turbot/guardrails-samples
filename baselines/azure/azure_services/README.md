# Azure Services Baseline

Turbot Azure Services baseline provides a terraform configuration to enable or disable Azure services in Turbot.

## Prerequisites

To run the Azure Services baseline, you must have:

  - [Terraform](https://www.terraform.io) Version 12

  - [Turbot Terraform Provider](https://github.com/turbotio/terraform-provider-turbot)

  - [Credentials](https://turbot-dev.com/v5/docs/api/credentials) configured to connect to your Turbot workspace and Azure account

## Running the Baseline

To run the Azure services baseline:

- Go to the Azure services baseline directory in the repository with `cd azure_services`
- Run `terraform plan -var-file=default.tfvars` to review the changes to be applied
- Run `terraform apply -var-file=default.tfvars` to apply the changes