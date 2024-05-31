# AWS EC2 Instance Metadata Service Controls - enabling IMDSv2 best practices

## Use case

Ensure your cloud instances limit the authentication and network hops required to retrieve valuable instance metadata.  Simple configurations can mitigate costly data breaches, in just a few clicks. With millions of permutations of EC2 configurations, it's easy to miss how securing your instance metadata should be top of mind.  AWS does tout this requirement as a foundational security control to consider, but with any customer responsible action, often these become deprioritized in the ever expanding “we’ll get to it later” queue.  Remediation becomes much more complex overtime as your environment grows, a simple configuration upfront quickly becomes a large security remediation project to correct 1000s of instances later on.

## Implementation details

This Terraform template creates a smart folder and applies the following policy settings:

- `AWS > EC2 > Instance > Metadata Service`
- `AWS > EC2 > Instance > Metadata Service > HTTP Token Hop Limit`

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
