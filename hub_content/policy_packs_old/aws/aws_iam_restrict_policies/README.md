# IAM Restrict Policies Smart Folder Example 

Provides a Terraform configuration for creating a smart folder and Turbot policies that check IAM policies for `*` actions as well as restricting inline IAM policies.


## Pre-requisites

To create the smart folder, you must have:
- [Terraform](https://www.terraform.io) Version 12
- [Turbot Terraform Provider](https://github.com/turbotio/terraform-provider-turbot)
- [Credentials configured](https://turbot.com/v5/docs/reference/cli/installation#setup-your-turbot-credentials) to connect to your Turbot workspace

## Running the Example

To run the IAM Restrict Policies Example:
- Navigate to the directory on the command line `cd aws_iam_restrict_policies`
- Run `terraform plan -var-file="default.tfvars"` and review the changes to be applied
- Run `terraform apply -var-file="default.tfvars"` to execute and apply the policy settings
