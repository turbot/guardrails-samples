# Turbot Logging Bucket Configuration

Provides a Terraform configuration for creating a smart folder and setting policies to check for Turbot logging bucket existence as well as enforcing versioning, encryption, and regional approval policies.


## Pre-requisites

To create the smart folder, you must have:
- [Terraform](https://www.terraform.io) Version 12
- [Turbot Terraform Provider](https://github.com/turbotio/terraform-provider-turbot)
- Credentials Configured to connect to your Turbot workspace

## Running the Example

To run the Turbot Logging Bucket Configuration:
- Navigate to the directory on the command line `turbot_logging_buckets`
- Run `terraform plan -var-file="default.tfvars"` and review the changes to be applied
- Run `terraform apply -var-file="default.tfvars"` to execute and apply the policy settings