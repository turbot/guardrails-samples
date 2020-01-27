# AWS Setup Baseline

The AWS setup baseline terraform implements common configurations on your Turbot environment required to import an AWS account.

- Before importing, you should determine a folder structure that is suitable for your environment.
- If you wish to enable cloudTrail, Set the default value to `true` for variable `setup_cloudtrail`

> NOTE: The baseline does not create a logging bucket or Trail. It just enables the necessary policy settings for them.


## Prerequisites

To run the aws setup baseline, you must have:
- [Terraform](https://www.terraform.io) Version 12
- [Turbot Terraform Provider](https://github.com/turbotio/terraform-provider-turbot)
- [Credentials](https://turbot-dev.com/v5/docs/api/credentials) Configured to connect to your Turbot workspace and AWS account
- `turbot`, `turbot-iam`, `aws-cloudtrail`, `aws-s3` and `aws-cisv1` mods


## Running the Baseline

To run the aws setup baseline:
- Go to the aws setup baseline directory in the repository with `cd aws_setup`
- Run `terraform plan -var-file=default.tfvars` and review the plan to be applied.
- Run `terraform apply -var-file=default.tfvars` to apply the plan.