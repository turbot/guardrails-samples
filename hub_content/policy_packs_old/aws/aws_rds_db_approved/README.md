# RDS Instance/ Engine approved

Provides a Terraform configuration for creating a smart folder and applying example turbot policy settings for an RDS instance. The policies will check if an instance is approved based on engine type and instance type.


## Pre-requisites

To create the smart folder, you must have:
- [Terraform](https://www.terraform.io) Version 12
- [Turbot Terraform Provider](https://github.com/turbotio/terraform-provider-turbot)
- Credentials Configured to connect to your Turbot workspace

## Running the Example

To run the RDS Example:
- Navigate to the directory on the command line `cd aws_rds_db_approved`
- Run `terraform plan -var-file="default.tfvars"` and review the changes to be applied
- Run `terraform apply -var-file="default.tfvars"` to execute and apply the policy settings

> The terraform plan runs with default values. Ensure the policy values are correct in main.tf before applying the plan.