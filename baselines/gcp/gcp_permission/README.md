# GCP Permission Baseline

GCP Permission baseline provides a Terraform configuration to assign GCP level permissions to a Turbot user.

> Make sure you have a [local directory user](https://turbot-dev.com/v5/docs/api/terraform/resources/turbot_local_directory_user) available.

## Prerequisites

To run the GCP Permission baseline, you must have:

  - [Terraform](https://www.terraform.io) Version 12
  - [Turbot Terraform Provider](https://github.com/turbotio/terraform-provider-turbot)
  - [Credentials](https://turbot-dev.com/v5/docs/api/credentials) configured to connect to your Turbot workspace and GCP account

## Running the Baseline

To execute the AWS Permission baseline:

- Go to the GCP permission directory with `cd gcp_permission`
- Run `terraform plan -var-file=default.tfvars` to review the changes to be applied
- Run `terraform apply -var-file=default.tfvars` to apply the changes