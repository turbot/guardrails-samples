# AWS v3 to v5 Migration Policies

Provide all the policies and sane defaults required to enable event handling for an account in v3 and v5 at the same time.  The defaults assume that the user needs Turbot provisioned buckets, CloudTrail and Event Handlers.

- Individual parameters to control:
    - Turbot Service Roles
    - Turbot CloudTrails
    - Turbot regional logging buckets
    - Turbot event handlers.

## Alert
- These policies should be deployed and attached before an account is imported into v5.
- For customers sensitive to IAM controls, the Service Roles policy will deploy additional IAM roles and groups into the account.

## Prerequisites

To run these policies, you must have:

- [Terraform](https://www.terraform.io) Version 12
- [Credentials](https://turbot.com/v5/docs/reference/cli/installation#setup-your-turbot-credentials) Configured to connect to your Turbot workspace and AWS account

## Running the Baseline

To run the baseline policies:

- Go to the migration baselines folder with `cd baselines/aws_v3_v5_migration`
- Run `terraform init` to get started.
- Update `default.tfvars` with appropriate values.
- Run `terraform plan -var-file=default.tfvars` and review the plan for import.
- Run `terraform apply -var-file=default.tfvars` to import the account.
- The "Event Handlers v3 v5 Migration" smart folder will need to be attached after creation.
