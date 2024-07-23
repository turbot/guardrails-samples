# AWS IAM Turbot Service Role configuration check

Provides a Terraform configuration for creating a smart folder and creating one policy to check the existence of Turbot service roles in an AWS account, and three subsequent policies that define which roles to check.


## Pre-requisites

To create the smart folder, you must have:
- [Terraform](https://www.terraform.io) Version 12
- [Turbot Terraform Provider](https://github.com/turbotio/terraform-provider-turbot)
- Credentials Configured to connect to your Turbot workspace

## Running the Example

To run the AWS IAM Turbot Service Role Configuration Check:
- Navigate to the directory on the command line `aws_iam_turbot_service_roles`
- Run `terraform plan -var-file="default.tfvars"` and review the changes to be applied
- Run `terraform apply -var-file="default.tfvars"` to execute and apply the policy settings