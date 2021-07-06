# AWS S3 - Check tags on a bucket, ignoring casing

## Use case

The business owner of the AWS platform wants to consistently tag all resources with business metadata to meet company
standards and ensure supportability and cost transparency. However, the admin wants to not get false positives, which can happen if casing in the key or value is not identical. 

## Implementation details

This Terraform template creates a smart folder and applies the calculated policy on the policy:

- `AWS > S3 > Bucket > Tags > Template`

The Calculated policy creates a tag template, while accounting for the possibility that keys and values might have alternate casing. Without RegEx, alternate casing will create false positives. 

Additionally, we create the policy `AWS > S3 > Bucket > Tags` and set it to `Check: Tags are correct`.

### Template input (GraphQL)

The template input to a calculated policy is a GraphQL query.

In this case the query selects various metadata about the bucket.

```graphql
{
  resource {
    turbot {
      tags
    }
  }
}
```

### Template (Nunjucks)

```nunjucks
{%- set approved = 'no' -%}

{%- for key,value in $.resource.turbot.tags -%}
  {%- if r/owners/.test(key | lower) -%}
    {%- if r/john doe/.test(value | lower) %}
      {%- set approved = 'yes' -%}
        {%- endif %}
  {%- endif -%}
{%- endfor -%}

{%- if approved == 'no' -%}
- owner: 'Missing_tag'
{%- else -%}
[]
{%- endif -%}
```

The template itself is a [Nunjucks formatted template](https://mozilla.github.io/nunjucks/templating.html).

## Prerequisites

To run Turbot Calculated Policies, you must install:

- [Terraform](https://www.terraform.io) Version 12 at minimum
- [Turbot Terraform Provider](https://turbot.com/v5/docs/reference/terraform/provider)
- Configured credentials to connect to your Turbot workspace

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
