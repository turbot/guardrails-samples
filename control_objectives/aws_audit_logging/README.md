# Turbot Audit Trail configuration

Provides a Terraform configuration for creating a smart folder and configuring Turbot to create a Global CloudTrail in the specified region for audit logging purposes.

## Pre-requisites

To create the smart folder, you must have:
- [Terraform](https://www.terraform.io) Version 12
- [Turbot Terraform Provider](https://github.com/turbotio/terraform-provider-turbot)
- Credentials Configured to connect to your Turbot workspace

## Running the Example

To run the Audit Trail Example:
- Navigate to the directory on the command line `cd aws_audit_logging`
- Run `terraform plan -var-file="default.tfvars"` and review the changes to be applied
- Run `terraform apply -var-file="default.tfvars"` to execute and apply the policy settings

> This terraform plan is configured by default to create a CloudTrail audit log in US East 1. Be sure to adjust this setting to the region where the global audit trail should be created.