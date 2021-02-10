# Multi-Cloud Resource Scheduling - automating resource runtime schedules

## Use case

Ensure instances are stopped before they overrun your cloud budget. For non 24/7 required workloads, scheduling resources start/stops can save over 70% of your cloud usage. We are all guilty of this; spun up a few instances for testing, left it running until you noticed it in your cloud bill, vowing to never make that costly mistake again. But, you keep moving on with bigger and better ideas than to waste time cobbling up scripts for scheduling automation.

## Implementation details

This Terraform template creates a smart folder and applies the following policy settings:

- `AWS > EC2 > Instance > Schedule`
- `AWS > RDS > DB Cluster > Schedule`
- `AWS > RDS > DB Instance > Schedule`
- `AWS > Redshift > Cluster > Schedule`
- `AWS > WorkSpaces > WorkSpace > Schedule`
- `Azure > Compute > Virtual Machine > Schedule`
- `GCP > Compute Engine > Instance > Schedule`

**NOTE:** Custom schedules are possible through the Schedule Tag policy as well.  e.g. `AWS > EC2 > Instance > Schedule Tag` can be set to `Enforce: Schedule per turbot_custom_schedule tag`. [More information on Custom Schedules](https://turbot.com/v5/docs/concepts/guardrails/scheduling#scheduling-with-a-tag)

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
