# VPC Default VPC Check

Provides a Terraform configuration for creating a smart folder and creating a policy to check if the default VPC exists.


## Pre-requisites

To create the smart folder, you must have:
- [Terraform](https://www.terraform.io) Version 12
- [Turbot Terraform Provider](https://github.com/turbotio/terraform-provider-turbot)
- Credentials Configured to connect to your Turbot workspace

## Running the Example

To run the example:
- Navigate to the directory on the command line `cd aws_vpc_delete_default`
- Run `terraform plan -var-file="default.tfvars"` and review the changes to be applied
- Run `terraform apply -var-file="default.tfvars"` to execute and apply the policy settings

> The policy created will check for the default VPC and alarm if it exists. Adjust the policy value in main.tf to enable force deletion.