# S3 Limit Public Access

Provides a Terraform configuration for creating a smart folder and applying example turbot policy settings for an S3 bucket. One set of policies apply checks for public access settings on the bucket itself, while the other set checks for public access settings at the account level in AWS.


## Pre-requisites

To create the smart folder, you must have:
- [Terraform](https://www.terraform.io) Version 12
- [Turbot Terraform Provider](https://github.com/turbotio/terraform-provider-turbot)
- Credentials Configured to connect to your Turbot workspace

## Running the Example

To run the S3 Limit Public Access example:
- Navigate to the directory on the command line `cd aws_s3_limit_public_access`
- Run `terraform plan -var-file="default.tfvars"` and review the changes to be applied
- Run `terraform apply -var-file="default.tfvars"` to execute and apply the policy settings