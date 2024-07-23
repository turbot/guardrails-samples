# AWS VPC Security Group Rules check

Provides a Terraform configuration for creating a smart folder and policies that check security group rules. If rules violate what is set in the policy, Turbot controls will go into the alarm state.


## Pre-requisites

To create the smart folder, you must have:
- [Terraform](https://www.terraform.io) Version 12
- [Turbot Terraform Provider](https://turbot.com/v5/docs/reference/terraform)
- [Credentials configured](https://turbot.com/v5/docs/reference/cli/installation#setup-your-turbot-credentials) to connect to your Turbot workspace

## Running the Example

To run the AWS VPC Security Group Rules check example:
- Navigate to the directory on the command line `cd aws_vpc_security_group_rules`
- Run `terraform plan -var-file="default.tfvars"` and review the changes to be applied
- Run `terraform apply -var-file="default.tfvars"` to execute and apply the policy settings

Keep in mind that the security group rule policies are examples only! They must be modified to match organizational requirements.