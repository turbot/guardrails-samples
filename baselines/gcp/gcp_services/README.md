# GCP Services Baseline

Turbot GCP Services baseline provides a Terraform configuration to enable or disable GCP services in Turbot.

- Service names must match the services listed under the `policy_map`.

## Prerequisites

To run the GCP Services baseline, you must have:

  - [Terraform](https://www.terraform.io) Version 12
  - [Turbot Terraform Provider](https://github.com/turbotio/terraform-provider-turbot)
  - [Credentials](https://turbot-dev.com/v5/docs/api/credentials) configured to connect to your Turbot workspace and GCP account

## Running the Baseline

To run the GCP Services baseline:

- Go to the GCP services baseline directory in the repository with `cd gcp_services`
- Run `terraform plan -var-file=default.tfvars` to review the changes to be applied
- Run `terraform apply -var-file=default.tfvars` to apply the changes
