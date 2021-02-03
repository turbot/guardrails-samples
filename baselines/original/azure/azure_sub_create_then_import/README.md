# Azure Subscription Import Baseline

The Azure subscription import baseline terraform configuration lets you import an Azure subscription into your turbot environment, with the necessary roles and permissions.

- It is recommended that you import accounts into Turbot Folders, as it provides greater flexibility and ease of management.
- Give the role a purposeful name such as `turbot-readonly` (read only) or `turbot-superuser` (for full access).
- By default, Turbot is installed with administrator access to enable full functionality. However, You may change this if required.

## Prerequisites

To run the Azure subscription import baseline, you must have:

- [Terraform](https://www.terraform.io) Version 12
- Terraform [Azure Provider](https://www.terraform.io/docs/providers/azurerm/index.html)
- [Turbot Terraform Provider](https://github.com/turbotio/terraform-provider-turbot)
- [Credentials](https://turbot.com/v5/docs/reference/cli/installation#setup-your-turbot-credentials) Configured to connect to your Turbot workspace and AWS account

## Running the Baseline

Scripts can be run in the folder that contains the script.

### Configure the script

Update default.tfvars or create a new Terraform configuration file.

Variables that are exposed by this script are:

- azure_app_password_expiration
- azure_app_name
- azure_app_password
- azure_environment_type
- azure_subscription_id
- parent_resource

Open the file `variables.tf` for further details.

### Initialize Terraform

If not previously run then initialize Terraform to get all necessary providers.

Command: `terraform init`

### Apply using default configuration

If seeking to apply the configuration using the configuration file `defaults.tfvars`.

Command: `terraform apply -var-file="default.tfvars"` 

### Apply using custom configuration

If seeking to apply the configuration using a custom configuration file `<custom_filename>.tfvars`.

Command: `terraform apply -var-file=<custom_filename>.tfvars`

### Destroy using default configuration

If seeking to apply the configuration using the configuration file `defaults.tfvars`.

Command: `terraform destroy -var-file=default.tfvars`

### Destroy using custom configuration

If seeking to apply the configuration using a custom configuration file `<custom_filename>.tfvars`.

Command: `terraform destroy -var-file=<custom_filename>.tfvars`
