# AWS EC2 Volume Approved

Provides a Terraform configuration for creating a smart folder and creating policies to ensure volumes that exist in the child account are approved. In this example, approval of a volume is based on the type of the volume. Check the [aws-ec2 mod page](https://turbot.com/v5/mods/turbot/aws-ec2/inspect) for more information on EC2 volume approved policies and controls.


## Pre-requisites

To create the smart folder, you must have:
- [Terraform](https://www.terraform.io) Version 12
- [Turbot Terraform Provider](https://github.com/turbotio/terraform-provider-turbot)
- Credentials configured to connect to your Turbot workspace

## Running the Example

To run the EC2 Volume Approved example:
- Navigate to the directory on the command line `cd aws_ec2_volume_approved`
- Run `terraform plan -var-file="default.tfvars"` and review the changes to be applied
- Run `terraform apply -var-file="default.tfvars"` to execute and apply the policy settings