# AWS s3 bucket over rides EC2 instance tag.

## User Story
The requirement is to copy tags from an ec2 instance and set in a s3 bucket.

## Implementation Details
This script provides a Terraform configuration for creating a smart folder and applying a calculated policy on the `AWS > S3 > Bucket > Tag > TagTemplate` policy.  The Calculated policy sets the tags from ec2 instance on s3 bucket. If there are no tags in ec2 instance then the s3 bucket tags template will be blank. 

### Template Input (GraphQL)
The template input to a calculated policy is a GraphQL query.  In this case the query selects all tags from a perticular instance:
```graphql
{
  resource(id: 190397275456727) {
    tags
  }
}
```
### Template (Nunjucks)
The template itself is a [Nunjucks formatted template](https://mozilla.github.io/nunjucks/templating.html) with custom logic:
```js
{%- if $.resource.tags | length == 0 %}
[] 
{%- elif $.resource.tags != undefined %}
{{ $.resource.tags | dump | safe }}
{%- else %}
{% for item in $.resource.tags %}
- {{ item }}
{% endfor %}
{% endif %}
```

## Pre-requisites

To create the smart folder, you must have:
- [Terraform](https://www.terraform.io) Version 12
- [Turbot Terraform Provider](https://github.com/turbotio/terraform-provider-turbot)
- Credentials Configured to connect to your Turbot workspace

## Running the Example

To run the Template:
- Navigate to the directory on the command line `cd aws_copy_tags_ec2_instance_to_s3_bucket`
- Run `terraform plan -var-file="default.tfvars"` and review the changes to be applied
- Run `terraform apply -var-file="default.tfvars"` to execute and apply the policy settings

> The template will run with the default values set in `default.tfvars`; however, you could create and set your own defaults using a `.tfvars` file that will override the existing files.