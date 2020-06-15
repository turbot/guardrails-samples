# AWS Lambda - Alarm if function policy has cross-account access

## Use case

The business owner of the AWS platform wants to use Lambda within the environment but would like to get alarms if a
function policy has cross-account access.

## Implementation Details

This Terraform template creates a smart folder and applies calculated policies on the policies:

- `AWS > Lambda > Function > Approved`
- `AWS > Lambda > Function > Approved > Usage`

If a function policy has cross-account access then the approved usage policy will be set to `Not approved` otherwise
it will be set to `Approved`.

### Template Input (GraphQL)

The template input to a calculated policy is a GraphQL query.

GraphQL query that will check if a function policy has cross-account access.
If the query returns an array of zero items, then there are no function with cross-account access.

```graphql
{
  resource {
    iamPolicies: get(path: "IamPolicy.Policy.Statement")
    turbot {
      custom
    }
  }
}
```

### Template (Nunjucks)

Approval logic for Lambda Function cross-account access.
If no external account is found in Principal.AWS, Condition.'AWS:SourceAccount' or Condition.'AWS:SourceArn'
then there are no cross-account access

```nunjucks
{% set has_cross_account = false -%}
{% for iamPolicy in $.resource.iamPolicies -%}
{%   if iamPolicy.Principal.AWS and iamPolicy.Principal.AWS.split(':')[4] != $.resource.turbot.custom.aws.accountId -%}
{%     set has_cross_account = true -%}
{%   endif -%}
{%   if iamPolicy.Condition.StringEquals['AWS:SourceAccount'] and iamPolicy.Condition.StringEquals['AWS:SourceAccount'] != $.resource.turbot.custom.aws.accountId -%}
{%     set has_cross_account = true -%}
{%   endif -%}
{%   if iamPolicy.Condition.ArnLike['AWS:SourceArn'] and iamPolicy.Condition.ArnLike['AWS:SourceArn'].split(':')[4] != $.resource.turbot.custom.aws.accountId -%}
{%     set has_cross_account = true -%}
{%   endif -%}
{% endfor -%}
{% if has_cross_account -%}
    "Not approved"
{%- else -%}
    "Approved"
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
