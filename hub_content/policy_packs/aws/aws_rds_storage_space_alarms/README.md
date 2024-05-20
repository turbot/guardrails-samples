# AWS RDS Storage space alarms

Provides a Terraform configuration for creating a smart folder and policy to trigger in Turbot if an RDS has storage space alarms active in AWS.


## Pre-requisites

To create the smart folder, you must have:
- [Terraform](https://www.terraform.io) Version 12
- [Turbot Terraform Provider](https://turbot.com/v5/docs/reference/terraform)
- [Credentials configured](https://turbot.com/v5/docs/reference/cli/installation#setup-your-turbot-credentials) to connect to your Turbot workspace

## Running the Example

To run the RDS Encryption at rest Example:
- Navigate to the directory on the command line `cd aws_rds_storage_Space_alarms`
- Run `terraform plan -var-file="default.tfvars"` and review the changes to be applied
- Run `terraform apply -var-file="default.tfvars"` to execute and apply the policy settings
