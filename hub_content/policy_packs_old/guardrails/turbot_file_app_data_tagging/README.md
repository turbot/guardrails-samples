# Turbot File - Application Metadata Tagging

## Use case
Organizations often want to add custom data or metadata to the Configuration Management Database (CMDB) for use in Turbot policies, as well as referencing arbitrary metadata across a wide range of resource types. To facilitate this, Turbot introduced a resource type called a Turbot File. This control objective provides an example of how to deploy a Turbot File with Terraform structured with Application Metadata often found in a Service Catalog.  With the Turbot File in the CMDB, we can use this as context to bring into Turbot Policies.  We take a simple example of relating the data in the Turbot File into a tagging template for S3 Buckets.


## Implementation details

This Terraform template creates a Turbot File:

- `Turbot > File`

This Terraform template creates a smart folder and applies the following policy settings:

- `AWS > S3 > Bucket > Tags`
- `AWS > S3 > Bucket > Tags > Template`

## Prerequisites

To run this example, you must install:

- [Terraform](https://www.terraform.io) Version 13+
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
