# Azure Compute - Disk approved if encrypted with customer key

## Use case

There is an organizational requirement that in specific accounts, disks should be encrypted using customer key.

## Implementation Details

This Terraform template creates a smart folder and applies calculated policies on the policies:

- `Azure > Compute > Disk > Approved`
- `Azure > Compute > Disk > Approved > Usage`

Approval policy that restrict usage of disks if they are not customer key encrypted.

### Template Input (GraphQL)

The template input to a calculated policy is a GraphQL query.

The query selects `encryption` property from the disk which will be used to determine
if the resource should be `Approved` or `Not approved`.

```graphql
{
  resource {
    encryption: get(path: "encryption")
  }
}
```

### Template (Nunjucks)

If `encryption.type` property is `EncryptionAtRestWithCustomerKey` then the policy is set to `Approved`
otherwise `Not approved`.

```nunjucks
{%- if $.resource.encryption and $.resource.encryption.type == "EncryptionAtRestWithCustomerKey" -%}
  Approved
{%- else -%}
  Not approved
{%- endif -%}
```

The template itself is a [Nunjucks formatted template](https://mozilla.github.io/nunjucks/templating.html).

## Prerequisites

To run Turbot Calculated Policies, you must install:

- [Terraform](https://www.terraform.io) Version 12
- [Turbot Terraform Provider](https://turbot.com/v5/docs/reference/terraform/provider)
- Configured credentials to connect to your Turbot workspace

### Configuring Credentials

You must set your `config.tf` or environment variables to connect to your Turbot workspace.
Further information can be found in the Turbot Terraform Provider [Installation Instructions](https://turbot.com/v5/docs/reference/terraform/provider).

## Running the Example

Scripts can be run in the folder that contains the script.

### Configure the script

Update [default.tfvars](default.tfvars) or create a new Terraform configuration file.

Variables that are exposed by this script are:

- target_resource
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
