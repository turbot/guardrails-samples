# AWS Enumerated CIS Policies

The AWS Enumerated CIS policies terraform lets you set individual CIS policies instead of turning all of them. 

- It is recommended that identify individual CIS policies relevant to your organization.  Turn off all irrelevant policies.

## Prerequisites

To run the AWS Enumerated CIS policies, you must have:

- [Terraform](https://www.terraform.io) Version 12
- [Turbot Terraform Provider](https://github.com/turbotio/terraform-provider-turbot)
- [Credentials](https://turbot.com/v5/docs/reference/cli/installation#setup-your-turbot-credentials) Configured to connect to your Turbot workspace and AWS account

## Running the Baseline

To run the AWS CIS enumerated CIS policies:

- Go to the AWS CIS directory/folder in the repository with `cd baselines/aws_cis`
- Update `default.tfvars` with appropriate values
- Run `terraform plan -var-file=default.tfvars` and review the plan for import
- Run `terraform apply -var-file=default.tfvars` to import the account
