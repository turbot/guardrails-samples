# Multi-Cloud Storage / Set less expensive storage options for development environments.

## User Story
The business owner of the AWS and Azure cloud platforms wants to save cost by ensuring that the configuration of storage resources are optimized for cost savings in development accounts. The cloud team sets a label {Environment:=Dev} on cloud resources that are under governance of this business rule.

## Implementation Details
This Terraform template creates a smart folder and applies a calculated policies on the `Azure> Storage> Storage Account> Access Tier` and `AWS > S3 > Bucket > Versioning` policies.  The Calculated policy sets the storage tier to "Cool" when an Azure label matching {Environment:=Dev} is present on a storage account resource and disables S3 versioning when an AWS tag matching {Environment:=Dev} is present on an S3 bucket resource.

### Template Input (GraphQL)
The template input to a calculated policy is a GraphQL query.  In this case the query selects all tags from the storage account:
```graphql
{ 
  resource {
    tags
  }
}
```
### Template (Nunjucks)
The template itself is a [Nunjucks formatted template](https://mozilla.github.io/nunjucks/templating.html) with custom logic:  
Azure
```nunjucks
  {%- if $.storageAccount.turbot.tags.Environment == "Dev"%}
    "Enforce: Cool"
  {%- else -%}
    "Enforce: Hot"
  {%- endif -%}
```
AWS
```nunjucks
  {% if $.resource.tags.Environment == "Dev" %}
    "Enforce: Disabled"
  {% else %}
    "Enforce: Enabled"
  {% endif %}
```

## Pre-requisites

To create the smart folder, you must have:
- [Terraform](https://www.terraform.io) Version 12
- [Turbot Terraform Provider](https://github.com/turbotio/terraform-provider-turbot)
- Credentials Configured to connect to your Turbot workspace

## Running the Example

To run the Template:
- Navigate to the directory on the command line `cd azure_storage_account_tier`
- Run `terraform plan -var-file="default.tfvars"` and review the changes to be applied
- Run `terraform apply -var-file="default.tfvars"` to execute and apply the policy settings

> The template will run with the default values set in `default.tfvars`; however, you could create and set your own defaults using a `.tfvars` file that will override the existing files.