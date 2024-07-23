# VPC Elastic IP Check

Provides a Terraform configuration for creating a smart folder and creating a policy that checks to see if an elastic IP exists, and if it does, the elastic IP approval control will go into the alarm state.

## Pre-requisites

To create the smart folder, you must have:
- [Terraform](https://www.terraform.io) Version 12
- [Turbot Terraform Provider](https://turbot.com/v5/docs/reference/terraform)
- [Credentials configured](https://turbot.com/v5/docs/reference/cli/installation#setup-your-turbot-credentials) to connect to your Turbot workspace

## Running the Example

To run the VPC Elastic IP Check example:
- Navigate to the directory on the command line `cd aws_vpc_elastic_ip_check`
- Run `terraform plan -var-file="default.tfvars"` and review the changes to be applied
- Run `terraform apply -var-file="default.tfvars"` to execute and apply the policy settings