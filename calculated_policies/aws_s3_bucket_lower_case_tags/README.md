# AWS S3 / Set default tags on buckets with dynamic metadata.

## User Story
An organization will often run automation based off specific tags on a resource, such as an S3 bucket. However, this operation can be case sensitive and requires all tags keys and associated values to be all lower case.

## Implementation Details
Provides a Terraform configuration for creating a smart folder and applying a calculated policy on the `AWS > S3 > Bucket > Tags > Template`.  The Calculated policy will injest all tags across any bucket that has this policy applied. 
Each tag will be checked for case, and if there is an upper case character, it will be converted to lower case.

### Template Input (GraphQL)
The template input to a calculated policy is a GraphQL query.  In this case the query selects various metadata about the bucket:
```graphql
{
  bucket{
    turbot {
      tags
    }
  }
}
```
### Template (Nunjucks)
The template itself is a [Nunjucks formatted template](https://mozilla.github.io/nunjucks/templating.html) with custom logic:
```
{%- set keys = [] %}
{%- for k,v in $.bucket.turbot.tags %}
  {%- set ignore = keys.push(k) %}
{%- endfor %}
{%- set ignore = keys.sort() %}
{%- set set_keys = [] %}
{%- for k in keys %}
  {%- set lower_k = k | lower %}
  {%- set lower_v = $.bucket.turbot.tags[k] | lower %}
  {%- if k == lower_k %}
    {%- if lower_v != $.bucket.turbot.tags[k] %}
      "{{lower_k}}": "{{lower_v}}"
      {%- set ignore = set_keys.push(lower_k) %}
    {%- endif %}
  {%- else %}
    "{{k}}": null
    {%- if not set_keys.includes(lower_k) %}
      "{{lower_k}}": "{{lower_v}}"
    {%- endif %}
    {%- set ignore = set_keys.push(lower_k) %}
  {%- endif %}
{%- endfor %}
{%- if not set_keys | length %}
  {}
{%- endif %}
```

## Pre-requisites

To create the smart folder, you must have:
- [Terraform](https://www.terraform.io) Version 12
- [Turbot Terraform Provider](https://github.com/turbotio/terraform-provider-turbot)
- Credentials Configured to connect to your Turbot workspace

## Running the Example

To run the Template:
- Navigate to the directory on the command line `cd aws_s3_bucket_lower_case_tags`
- Run `terraform plan -var-file="default.tfvars"` and review the changes to be applied
- Run `terraform apply -var-file="default.tfvars"` to execute and apply the policy settings

> The template will run with the default values set in `default.tfvars`; however, you could create and set your own defaults using a `.tfvars` file that will override the existing files.