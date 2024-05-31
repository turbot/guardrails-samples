# AWS KMS Key Rotation

## Use case
Common best practice is to avoid extensive reuse of encryption keys. There are a number of ways to rotate your AWS Key Management Service (AWS KMS) customer master keys (CMKs); you can create new CMKs, and then change your applications or aliases to use the new CMKs. Or, you can enable automatic key rotation for an existing customer managed CMK. You can use the AWS KMS console or the AWS KMS API to enable and disable automatic key rotation, and view the rotation status of any customer managed CMK. When you enable automatic key rotation, AWS KMS rotates the CMK 365 days after the enable date and every 365 days thereafter  This feature can only be set after a key is created.  While it is simple to configure for a few keys, when there are 100s across many AWS accounts it becomes difficult to manage at scale.  Turbot can help you enable the automatic key rotation configuration across all of your AWS KMS CMKs in your AWS Accounts.


## Implementation details

This Terraform template creates a smart folder and applies the following policy settings:

- `AWS > KMS > Key > Rotation`

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
