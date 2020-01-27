# AWS S3 / Enable versioning on production buckets.

Provides a Terraform configuration for creating a smart folder and applying a calculated policy on the AWS > S3 > Bucket > Versioning policy.  The Calculated policy enables versioning when a tag is present on the bucket resource matching {Environment:=Prod} and disables versioning if it is not present or set to an alternate value.

## Template Input (GraphQL)
The template input to a calculated policy is a GraphQL query.  In this case the query selects all tags from the resource:
```graphql
    { 
        resource {
            tags
        }
    }
```
## Template (Nunjucks)
The template itself is a [Nunjucks formatted template](https://mozilla.github.io/nunjucks/templating.html) with custom logic:
```js
{% if $.resource.tags.data-classification == "temp" %}
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

To run the S3 Example:
- Navigate to the directory on the command line `cd aws_s3_bucket_versioning`
- Run `terraform plan -var-file="default.tfvars"` and review the changes to be applied
- Run `terraform apply -var-file="default.tfvars"` to execute and apply the policy settings

> The template will run with the default values set in `default.tfvars`; however, you could create and set your own defaults using a `.tfvars` file that will override the existing files.