# AWS Disable CMDB Baseline

Turbot AWS Disable CMDB baseline provides a Terraform configuration to enable or disable resource discovery and CMDB updates for AWS services in Turbot.

## Prerequisites

To run the AWS Disable CMDB baseline, you must have:

  - [Terraform](https://www.terraform.io) Version 13
  - [Turbot Terraform Provider](https://github.com/turbotio/terraform-provider-turbot)
  - [Credentials](https://turbot.com/v5/docs/reference/cli/installation#setup-your-turbot-credentials) Configured to connect to your Turbot workspace and AWS account

## Running the Baseline

To execute the AWS Disable CMDB baseline, run terraform and specify the AWS services you wish to enable or disable.

To run the AWS Disable CMDB baseline:

  - Uncomment the Resource Type and related policy mappings in `terraform.tfvars` for the services you would like to disable resource discovery/CMDB updates for
  - Run `terraform plan` to review the changes to be applied
  - Run `terraform apply` to apply the changes

* When prompted for a `var.turbot_profile` value, use the name of your profile specified in your Turbot credentials file.