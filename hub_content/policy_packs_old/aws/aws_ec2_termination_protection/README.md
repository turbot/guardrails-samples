# EC2 Instance Termination Protection

## Use case
Amazon EC2 instances are easy to manage through the AWS console, CLI, or API; simple commands with powerful capabilities to create new instances, change attributes as they are running, stop the instance, etc. With the ease of making a change to an instance, you can just as easily terminate the EC2 instance. To prevent your instance from being accidentally terminated, you can enable termination protection for the instance. Termination protection is related to the DisableApiTermination attribute control which dictates whether the instance can be terminated using the console, CLI, or API. By default, termination protection is disabled for all instances. You can set the value of this attribute when you launch the instance, while the instance is running, or while the instance is stopped (for Amazon EBS-backed instances).  When enabled, termination protection will require an additional step to ensure you are intended to delete the instance.  While backups are the best method of data loss protection, configuring this setting can be an additional layer of protection from accidental deletions. Turbot can help ensure termination protection is enabled across all of your instances in your AWS Accounts.

## Implementation details

This Terraform template creates a smart folder and applies the following policy settings:

- `AWS > EC2 > Instance > Termination Protection`

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
