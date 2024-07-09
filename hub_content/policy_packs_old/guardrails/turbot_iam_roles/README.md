# Turbot AWS IAM Roles

Provides a Terraform configuration for creating a smart folder and sets a policy to enable Turbot creating AWS IAM roles. Two policies are also created to check for AWS boundary policies.


## Pre-requisites

To create the smart folder, you must have:
- [Terraform](https://www.terraform.io) Version 12
- [Turbot Terraform Provider](https://github.com/turbotio/terraform-provider-turbot)
- Credentials Configured to connect to your Turbot workspace

## Running the Example

To run the Turbot AWS IAM Roles:
- Navigate to the directory on the command line `turbot_iam_roles`
- Run `terraform plan -var-file="default.tfvars"` and review the changes to be applied
- Run `terraform apply -var-file="default.tfvars"` to execute and apply the policy settings