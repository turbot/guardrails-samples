# AWS VPC Restrict NAT Usage

Provides a Terraform configuration for creating a smart folder and applying example turbot policy settings to restrict NAT Gateway usage. 


## Pre-requisites

To create the smart folder, you must have:
- [Terraform](https://www.terraform.io) Version 12
- [Turbot Terraform Provider](https://github.com/turbotio/terraform-provider-turbot)
- Credentials configured to connect to your Turbot workspace

## Running the Example

To run the AWS VPC Restrict NAT Usage example:
- Navigate to the directory on the command line `cd aws_vpc_restrict_nat`
- Run `terraform plan -var-file="default.tfvars"` and review the changes to be applied
- Run `terraform apply -var-file="default.tfvars"` to execute and apply the policy settings