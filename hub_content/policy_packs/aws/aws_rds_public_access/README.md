# RDS Public Access Check

Provides a Terraform configuration for creating a smart folder and applying example turbot policy settings for an RDS instance. This example creates a policy that tells Turbot to check a RDS instance for public access, and alarm if the instance is found to be publicly accessible. 


## Pre-requisites

To create the smart folder, you must have:
- [Terraform](https://www.terraform.io) Version 12
- [Turbot Terraform Provider](https://turbot.com/v5/docs/reference/terraform)
- [Credentials configured](https://turbot.com/v5/docs/reference/cli/installation#setup-your-turbot-credentials) to connect to your Turbot workspace

## Running the Example

To run the RDS Public Access Check example:
- Navigate to the directory on the command line `cd aws_rds_public_access`
- Run `terraform plan -var-file="default.tfvars"` and review the changes to be applied
- Run `terraform apply -var-file="default.tfvars"` to execute and apply the policy settings
