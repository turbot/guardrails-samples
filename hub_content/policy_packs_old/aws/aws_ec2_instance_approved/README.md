# AWS EC2 Instance Approval

Provides a Terraform configuration for creating a smart folder and creating policies to check if EC2 instances has a public IP assigned and ensuring only specific instance types are allowed. The [aws-ec2 mod page](https://turbot.com/v5/mods/turbot/aws-ec2/inspect) has list of additional policies that can be used to approve instance metadata.


## Pre-requisites

To create the smart folder, you must have:
- [Terraform](https://www.terraform.io) Version 12
- [Turbot Terraform Provider](https://github.com/turbotio/terraform-provider-turbot)
- Credentials configured to connect to your Turbot workspace

## Running the Example

To run the EC2 Instance Approval example:
- Navigate to the directory on the command line `cd aws_ec2_instance_approved`
- Run `terraform plan -var-file="default.tfvars"` and review the changes to be applied
- Run `terraform apply -var-file="default.tfvars"` to execute and apply the policy settings