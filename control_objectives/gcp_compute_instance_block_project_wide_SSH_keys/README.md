# GCP Compute Instance Block Project Wide SSH Keys

## Use case
GCP offers an option on each Compute instance to block or allow project-wide public SSH keys.  By default this setting allows for project-wide SSH keys.  This is easy to manually enable on an instance; however, it becomes a challenge at scale (e.g. many instances in a multi-project model) to deploy and keep configurations consistent over time.  Our recommendation is that customers default to instance-level SSH keys unless projects or specific instances are given an approved exception to allow project-wide SSH keys. Following that model allows Turbot’s automation to block project-wide SSH keys on all instances, while allowing point in time exceptions to allow.  This control objective provides an example to help enforce blocking project-wide SSH keys across all of your instances in your GCP projects.

## Implementation details

This Terraform template creates a smart folder and applies the following policy settings:

- `GCP > Compute Engine > Instance > Block Project Wide SSH Keys`

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