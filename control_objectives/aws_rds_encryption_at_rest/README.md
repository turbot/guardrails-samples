# AWS RDS Encryption at rest

Provides a Terraform configuration for creating a smart folder and creating a policy to set an RDS instances as not approved if the encrpytion at rest does not meet minimum requirements.


## Pre-requisites

To create the smart folder, you must have:
- [Terraform](https://www.terraform.io) Version 12
- [Turbot Terraform Provider](https://github.com/turbotio/terraform-provider-turbot)
- Credentials Configured to connect to your Turbot workspace

## Running the Example

To run the S3 Example:
- Navigate to the directory on the command line `cd aws_rds_encryption_at_rest`
- Run `terraform plan -var-file="default.tfvars"` and review the changes to be applied
- Run `terraform apply -var-file="default.tfvars"` to execute and apply the policy settings

> The terraform plan sets the policy to check for AWS managed key or higher. Alternate values include: `None`, `None or higher`, `AWS managed key`, `Customer managed key`, and `Encryption at Rest > Customer Managed Key`