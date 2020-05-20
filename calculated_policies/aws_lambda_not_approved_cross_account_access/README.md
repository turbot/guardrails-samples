# AWS Lambda Function Approved Usage / Alarm if Lambda function policy violates org restrictions

## Use case
The business owner of the AWS platform wants to use Lambda within the environment but would like to get alarms if a 
function policy has cross account access.

## Implementation Details
Provides a Terraform configuration for creating a smart folder and applying a calculated policy on the 
`AWS > Lambda > Function > Approved > Usage`.  The Calculated policy creates a template that will alarm if a 
function policy has cross account access.

### Template Input (GraphQL)
The template input to a calculated policy is a GraphQL query.  In this case the query selects policy metadata on 
an Lambda Function:

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
The template itself is a [Nunjucks formatted template](https://mozilla.github.io/nunjucks/templating.html) with 
custom logic:

```
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

## Pre-requisites

To create the smart folder, you must have:
- [Terraform](https://www.terraform.io) Version 12
- [Turbot Terraform Provider](https://github.com/turbotio/terraform-provider-turbot)
- Credentials Configured to connect to your Turbot workspace

## Running the Example

To run the Template:
- Navigate to the directory on the command line `cd aws_lambda_not_approved_cross_account_access`
- Run `terraform plan -var-file="default.tfvars"` and review the changes to be applied
- Run `terraform apply -var-file="default.tfvars"` to execute and apply the policy settings

> The template will run with the default values set in `default.tfvars`; however, you could create and set your own 
> defaults using a `.tfvars` file that will override the existing files.
