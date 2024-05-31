# AWS S3 Access Logging

## Use case
Server access logging provides detailed records for the request that are made to an Amazon S3 bucket.  With logging is enabled, the access log record contains the request type, the resources that are specified in the request, and the time and date that the request was processed.  Access logging allows for security and access audits to learn how users are interacting with your S3 buckets. This control objective provides a Terraform configuration for creating a smart folder and creating policies that enforce S3 Access Logging. The logging destination is defined as the access_logging_bucket variable in the tfvars file, and the logging key prefix is defined as the log_prefix variable.

## Implementation details

This Terraform template creates a smart folder and applies the following policy settings:

- `AWS > S3 > Bucket > Access Logging`

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
