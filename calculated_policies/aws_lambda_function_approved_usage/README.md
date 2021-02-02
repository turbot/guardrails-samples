# AWS Lambda - Approve a Lambda function with an existense of tag

## Use case

The business owner of the AWS environment wants to approve only the Lambda functions that are with tag associated to it.

## Implementation details

This Terraform template creates a smart folder and applies calculated policies on the policies:

- `AWS > Lambda > Function > Approved`
- `AWS > Lambda > Function > Approved > Usage`

The Calculated policy checks the Lambda metadata for existence of ApplicationID tag and if the tag doesn't exist and it is older than five minutes it will return "Not approve" other wise it will approve. This gives users five minutes to tag their resources or have them deleted.

### Template input (GraphQL)

The template input to a calculated policy is a GraphQL query.

In this case the query finds the Lambda function's attribute in the Lambda metadata.

```graphql
{
  resource {
    data
    metadata
    trunk {
      title
    }
    turbot {
      akas
      id
      tags
    }
  }
}
```

### Template (Nunjucks)

```nunjucks
{%- set result = "Approved" -%}
{%- set current_time = now | date("constructor") | date("getTime") -%}
{%- set lastmodified_time = $.resource.data.Configuration.LastModified | date("getTime") -%}
{%- if "ApplicationID" not in $.resource.turbot.tags and duration > 300000 -%}
  {%- set result = "Not approved" -%}
{%- endif -%}
{{ result }}
```

The template itself is a [Nunjucks formatted template](https://mozilla.github.io/nunjucks/templating.html).

## Prerequisites

To run Turbot Calculated Policies, you must install:

- [Terraform](https://www.terraform.io) Version 13
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
