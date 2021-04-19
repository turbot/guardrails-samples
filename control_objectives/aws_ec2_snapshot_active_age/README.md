# EC2 Snapshot Automated Retention

## Use case
The ability to easily create backups from storage resources like Amazon EBS, Amazon RDS, etc. is one of the key benefits of working with IaaS, but it can also become a source of unchecked cost if not watched closely. While the AWS Backup service was released in 2019, which has the ability to automate backup scheduling and enforce retention policies, many customers have existing processes and tools that leave 1000s of aged snapshots unnecessarily retained causing a significant impact to their cloud budget.  While Turbot has governance controls to enforce AWS Backup Plans and automate resource assignments, Turbot also has additional governance controls to help manage aging resources (e.g. instance, access keys, storage, volumes, snapshots, etc.) in a consistent, repeatable framework across cloud providers and services. Turbot can be used to to simply enforce the clean up of snapshots on a retention policy.

## Implementation details

This Terraform template creates a smart folder and applies the following policy settings:

- `AWS > EC2 > Snapshot > Active`
- `AWS > EC2 > Snapshot > Active > Age`

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
