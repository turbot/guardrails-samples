# AWS Services Baseline

Turbot AWS Services baseline provides a Terraform configuration to enable or disable AWS services in Turbot.

- Service names must match the `policy_map`.

## Prerequisites

To run the AWS Services baseline, you must have:

- [Terraform](https://www.terraform.io) Version 12
- [Turbot Terraform Provider](https://github.com/turbotio/terraform-provider-turbot)
- Credentials configured to connect to your Turbot workspace and AWS account

## Running the Baseline

To execute the AWS Services baseline, run terraform and specify the AWS services you wish to enable or disable.

To run the AWS Services baseline:

- Go to the AWS services directory with  `cd aws_services`
- Run `terraform plan -var-file=default.tfvars` to review the changes to be applied
- Run `terraform apply -var-file=default.tfvars` to apply the changes

> You may also choose to enable or disable your own set of services from the `aws_service_list.txt` file.
