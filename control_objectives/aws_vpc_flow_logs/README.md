# VPC Flow Log configuration

Provides a Terraform configuration for creating a smart folder and alarming if flow logs are not enabled in a VPC.


## Pre-requisites

To create the smart folder, you must have:
- [Terraform](https://www.terraform.io) Version 12
- [Turbot Terraform Provider](https://github.com/turbotio/terraform-provider-turbot)
- Credentials Configured to connect to your Turbot workspace

## Running the Example

To run the VPC Flow Log configuration example:
- Navigate to the directory on the command line `cd aws_vpc_flow_logs`
- Run `terraform plan -var-file="default.tfvars"` and review the changes to be applied
- Run `terraform apply -var-file="default.tfvars"` to execute and apply the policy settings

> The terraform plan will set the flow log policy to Check: Not configured. Alternate values can be found in the main.tf file