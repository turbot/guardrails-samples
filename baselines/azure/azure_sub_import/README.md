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
  - [Credentials](/docs/api/credentials) configured to connect to your Turbot workspace and Azure subscription


## Running the Baseline

To run the azure subscription import baseline:

- Go to the azure subscription import baseline directory in the repository with cd `azure_sub_import`
- Run `terraform plan -var-file="default.tfvars"` and review the changes to be applied
- Run `terraform apply -var-file="default.tfvars"` to execute and import the Azure subscription