# GCP Project Import Baseline

The GCP project import baseline terraform configuration lets you import GCP Project into turbot with the necessary roles and permissions.

  - It is recommended that you import accounts into Turbot Folders, as it provides greater flexibility and ease of management.
  - Give the role a purposeful name such as `turbot-readonly` (read only) or `turbot-superuser` (for full access).
  - By default, Turbot is installed with administrator access to enable full functionality. However, You may change this if required.


## Prerequisites

To run the account import baseline, you must have:

  - [Terraform](https://www.terraform.io) Version 12
  - [Turbot Terraform Provider](https://github.com/turbotio/terraform-provider-turbot)
  -  Terraform [Google Cloud Platform Provider](https://www.terraform.io/docs/providers/google/index.html)
  - [Credentials](https://turbot.com/v5/docs/reference/cli/installation#setup-your-turbot-credentials) Configured to connect to your Turbot workspace and GCP project.
  - CloudTrail set up in every region of your account.



## Running the Baseline

To run the gcp project import baseline:

  - Go to the gcp project import baseline directory in the repository with `cd gcp_project_import`
  - Update `default.tfvars` with appropriate values
  - Run `terraform plan -var-file=default.tfvars` and review the plan for import
  - Run `terraform apply -var-file=default.tfvars` to import the account