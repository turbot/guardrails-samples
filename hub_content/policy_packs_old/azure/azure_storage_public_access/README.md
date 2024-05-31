# Azure Storage Public Access

## Use case
Azure Storage supports anonymous public read access for containers and blobs. When you configure a container's public access level setting to permit anonymous access, clients can read data in that container without authorizing the request. Public access can be enabled in two separate settings that affect public access on the storage account and the containers themselves. By default these public access features are disabled in Azure Storage.  However authorized users can accidentally allow for public access with a simple Azure configuration setting.  It becomes a challenge at scale (e.g. many storage accounts, containers and blobs in a multi-subscription model) to deploy and keep configurations consistent over time. When public access is not permitted, our recommendation is that customers disable public access on the storage account and enforce no public read access on all containers and blobs.


## Implementation details

This Terraform template creates a smart folder and applies the following policy settings:

- `Azure > Storage > Storage Account > Public Access`
- `Azure > Storage > Container > Public Access Level`

## Prerequisites

To run this example, you must install:

- [Terraform](https://www.terraform.io) Version 12+
- [Turbot Terraform Provider](https://turbot.com/v5/docs/reference/terraform/provider)
- Configured credentials to connect to your Turbot Workspace

### Configuring credentials

You must set your `config.tf` or environment variables to connect to your Turbot workspace.
Further information can be found in the Turbot Terraform Provider [Installation Instructions](https://turbot.com/v5/docs/reference/terraform/provider).

## Running the example

Scripts can be run in the folder that contains the script.

### Configure the script

Update [default.tfvars](default.tfvars) or create a new Terraform configuration file.

Variables that are exposed by this script are:

- smart_folder_title (Optional)
- smart_folder_description (Optional)
- smart_folder_parent_resource (Optional)

Open the file [variables.tf](variables.tf) for further details.

### Initialize Terraform

If not previously run then initialize Terraform to get all necessary providers.

Command: `terraform init`

### Apply using default configuration

If seeking to apply the configuration using the configuration file [defaults.tfvars](defaults.tfvars).

Command: `terraform apply -var-file=default.tfvars`

### Apply using custom configuration

If seeking to apply the configuration using a custom configuration file `<custom_filename>.tfvars`.

Command: `terraform apply -var-file=<custom_filename>.tfvars`

### Destroy using default configuration

If seeking to apply the configuration using the configuration file [defaults.tfvars](defaults.tfvars).

Command: `terraform destroy -var-file=default.tfvars`

### Destroy using custom configuration

If seeking to apply the configuration using a custom configuration file `<custom_filename>.tfvars`.

Command: `terraform destroy -var-file=<custom_filename>.tfvars`
