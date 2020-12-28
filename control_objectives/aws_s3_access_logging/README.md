# AWS S3 Access Logging

Provides a Terraform configuration for creating a smart folder and creating policies that enforce S3 Access Logging. The logging destination is defined as the access_logging_bucket variable in the tfvars file, and the logging key prefix is defined
as the log_prefix variable


## Pre-requisites

To create the smart folder, you must have:
- [Terraform](https://www.terraform.io) Version 12
- [Turbot Terraform Provider](https://github.com/turbotio/terraform-provider-turbot)
- Credentials Configured to connect to your Turbot workspace

## Running the Example

To run the S3 Access Logging example:
- Navigate to the directory on the command line `cd aws_s3_access_logging`.
- Run `terraform plan -var-file="default.tfvars"` and review the changes to be applied.
- Run `terraform apply -var-file="default.tfvars"` to execute and apply the policy settings.
