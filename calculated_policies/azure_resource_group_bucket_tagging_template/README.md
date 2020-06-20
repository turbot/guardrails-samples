# Azure Resource Group - Set default tags on resource group

## Use case

This policy is intended to make sure a tag exist and set a default value when the tag value is empty

## Implementation Details

This Terraform template creates a smart folder and applies the calculated policy on the policy:

- `Azure > Resource Group > Tags > Template`

It looks at current resource tags to check if the tag key defined at [variables.ft](variables.ft) exists.
If it does not, then it creates the tag with default value, also defined at [variables.ft](variables.ft)
If the tag already exist, then enforce the default value in case it's currently empty

### Template Input (GraphQL)

The template input to a calculated policy is a GraphQL query.

Query current resource tags

```graphql
{
  resource {
    tags
  }
}
```

### Template (Nunjucks)

If current tag does not exist or have an empty value, then set the default value to the tag

```nunjucks
"${var.tag_key}": "{% if $.resource.tags['${var.tag_key}'] %}{{ $.resource.tags['${var.tag_key}'] }}{% else %}${var.tag_default_value}{% endif %}"
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

- tag_key
- tag_default_value
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
