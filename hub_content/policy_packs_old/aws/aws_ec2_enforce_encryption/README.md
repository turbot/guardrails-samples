# AWS EC2 enforce encryption on snapshots and volumes

Provides a Terraform configuration for creating a smart folder and creating policies to check volumes and snapshots for encryption, as well as enabling the EC2 > Volume > Approved and EC2 > Snapshot > Approved policies. The approved policies will generate alarms if volumes or snapshots violate the encryption requirement.


## Pre-requisites

To create the smart folder, you must have:
- [Terraform](https://www.terraform.io) Version 12
- [Turbot Terraform Provider](https://github.com/turbotio/terraform-provider-turbot)
- Credentials configured to connect to your Turbot workspace

## Running the Example

To run the EC2 encryption enforcement example:
- Navigate to the directory on the command line `cd aws_rds_encryption_at_rest`
- Run `terraform plan -var-file="default.tfvars"` and review the changes to be applied
- Run `terraform apply -var-file="default.tfvars"` to execute and apply the policy settings

> The terraform plan sets the policy to check for AWS managed key or higher. Alternate values include: `None`, `None or higher`, `AWS managed key`, `AWS managed key or higher`, `Customer managed key`, and `Encryption at Rest > Customer Managed Key`.
