# Multi-Cloud Unattached Volumes - automating cleanup of unused volumes

## Use case

Ensure unused volumes are automatically backed up and removed before they overrun your cloud budget. Even if an Amazon EBS Volume, Azure Compute Disk, or GCP Compute Engine Disk are unattached, you are still billed for their provisioned storage.  Surprisingly this adds up fast; but with Turbot Active guardrails we can flag whether a resource is in active use, and if not, cleanup the resource.

## Implementation details

This Terraform template creates a smart folder and applies the following policy settings:

- `AWS > EC2 > Volume > Active`
- `AWS > EC2 > Volume > Active > Attached`
- `Azure > Compute > Disk > Active`
- `Azure > Compute > Disk > Active > Attached`
- `GCP > Compute Engine > Disk > Active`
- `GCP > Compute Engine > Disk > Active > Attached`

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
