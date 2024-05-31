# AWS IAM Account Password Settings Smart Folder Example

Provides a Terraform configuration for creating a smart folder and applying Turbot policies that will configure an AWS account's user password settings, such as password length and character requirements. 

## Pre-requisites

To create the smart folder, you must have:
- [Terraform](https://www.terraform.io) Version 12
- [Turbot Terraform Provider](https://turbot.com/v5/docs/reference/terraform)
- [Credentials configured](https://turbot.com/v5/docs/reference/cli/installation#setup-your-turbot-credentials) to connect to your Turbot workspace

## Running the Example

To run the AWS IAM Account Password Settings example:
- Navigate to the directory on the command line `cd aws_iam_password_settings`
- Run `terraform plan -var-file="default.tfvars"` and review the changes to be applied
- Run `terraform apply -var-file="default.tfvars"` to execute and apply the policy settings
