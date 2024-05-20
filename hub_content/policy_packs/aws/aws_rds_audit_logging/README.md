# AWS RDS Audit Logging DB Parameters

Provides a Terraform configuration for creating a smart folder and applying example Turbot policy settings checking for Audit Logging DB Parameters on RDS instances.


## Pre-requisites

To create the smart folder, you must have:
- [Terraform](https://www.terraform.io) Version 12
- [Turbot Terraform Provider](https://github.com/turbotio/terraform-provider-turbot)
- Credentials configured to connect to your Turbot workspace

## Running the Example

To run the AWS RDS Audit Logging DB Parameters example:
- Navigate to the directory on the command line `cd aws_rds_audit_logging`
- Run `terraform plan -var-file="default.tfvars"` and review the changes to be applied
- Run `terraform apply -var-file="default.tfvars"` to execute and apply the policy settings