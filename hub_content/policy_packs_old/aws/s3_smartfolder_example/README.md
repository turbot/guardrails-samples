# S3 Smart Folder Example

Provides a Terraform configuration for creating a smart folder and applying example turbot policy settings for an S3 bucket.


## Pre-requisites

To create the smart folder, you must have:
- [Terraform](https://www.terraform.io) Version 12
- [Turbot Terraform Provider](https://github.com/turbotio/terraform-provider-turbot)
- Credentials Configured to connect to your Turbot workspace

## Running the Example

To run the S3 Example:
- Navigate to the directory on the command line `cd s3_smartfolder_example`
- Run `terraform plan -var-file="default.tfvars"` and review the changes to be applied
- Run `terraform apply -var-file="default.tfvars"` to execute and apply the policy settings

> The baseline runs with the default values. However, you could create and set your own defaults using `.tfvars` file that will override the existing files.