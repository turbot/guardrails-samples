# AWS Account Import Baseline

The AWS account import baseline terraform configuration lets you import an AWS Account into turbot with the necessary roles and permissions.

- It is recommended that you import accounts into Turbot Folders, as it provides greater flexibility and ease of management.
- Give the role a purposeful name such as `turbot-readonly` (read only) or `turbot-superuser` (for full access).
- By default, Turbot is installed with administrator access to enable full functionality. However, You may change this if required.


## Prerequisites

To run the account import baseline, you must have:
- [Terraform](https://www.terraform.io) Version 12
- [Turbot Terraform Provider](https://github.com/turbotio/terraform-provider-turbot)
-  Terraform [AWS Provider](https://www.terraform.io/docs/providers/aws/index.html)
- [Credentials](https://turbot-dev.com/v5/docs/api/credentials) Configured to connect to your Turbot workspace and AWS account
- CloudTrail set up in every region of your account.



## Running the Baseline

To run the aws account import baseline:

- Go to the aws account import baseline directory in the repository with `cd aws_account_import`
- Run `terraform plan -var-file=default.tfvars` and review the plan for import.
- Run `terraform apply -var-file=default.tfvars` to import the account.