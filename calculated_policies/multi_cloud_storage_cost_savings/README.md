# Multi-Cloud Storage - Set least expensive storage options for development environments

## Use case

The business owner of the AWS and Azure cloud platforms who wants to save cost by ensuring that the configuration of 
storage resources are optimized for cost savings in development accounts. 

By setting the tag or label as {Environment:=Dev} on storage resources will allow Turbot to the manage the resource 
under the governance of this business rule.

## Implementation Details

This Terraform template creates a smart folder and applies calculated policies on the policies:

- `Azure > Storage > Storage Account > Access Tier`
- `AWS > S3 > Bucket > Versioning`

For Azure, the calculated policy sets the storage tier to "Cool" when an Azure label matching {Environment:=Dev} is 
present on a storage account resource

For AWS, the calculated policy disables S3 versioning when an AWS tag matching {Environment:=Dev} is present on an 
S3 bucket resource.

**NOTE:** Rule currently manages Azure and AWS resources only.

### Template Input (GraphQL)

The template input to a calculated policy is a GraphQL query.

In this case the query selects all tags from the storage account which will be used to determine if the resource
should be managed by this business rule.

```graphql
{ 
  resource {
    tags
  }
}
```

### Template (Nunjucks)

First Nunjucks snippet determines if the storage account resource is deployed in a development environment. 
If it is then it will set the Storage Access Tier to `Enforce: Cool` otherwise it will remain `Enforce: Hot`.

Second Nunjucks snippet determines if the S3 Bucket account resource is deployed in a development environment.
If it is then it will set Versioning to `Enforce: Disabled` otherwise it will remain `Enforce: Enabled`.

```nunjucks
{%- if $.storageAccount.turbot.tags.Environment == "Dev"%}
  "Enforce: Cool"
{%- else -%}
  "Enforce: Hot"
{%- endif -%}
```

```nunjucks
{% if $.resource.tags.Environment == "Dev" %}
  "Enforce: Disabled"
{% else %}
  "Enforce: Enabled"
{% endif %}
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
