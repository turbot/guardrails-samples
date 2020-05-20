# Approve a Lambda function only if it is within a particular VPC

## User Story
The business owner of the AWS environement wants to ensure that a Lambda is only ran from within a VPC, not within the AWS network

## Implementation Details
This script provides a Terraform configuration for creating a smart folder and applying a calculated policy on the `AWS > Lambda > Function > Approved > Usage` policy.  The Calculated policy checks the Lambda metadata for existence of the attribute VpcConfig, and can be expanded to check for a specific VPC Id or Subnet Ids.

### Template Input (GraphQL)
The template input to a calculated policy is a GraphQL query.  In this case the query finds the VpcConfig attribute in the Lambda metadata:
```graphql
{
  resource {
    vpc: get(path: "Configuration.VpcConfig")
  }
}
```
### Template (Nunjucks)
The template itself is a [Nunjucks formatted template](https://mozilla.github.io/nunjucks/templating.html) with custom logic:
```js
{% if $.resource.vpc.VpcId %}
"Approved"
{% else %}
"Not Approved"
{% endif %}
```

## Pre-requisites

To create the smart folder, you must have:
- [Terraform](https://www.terraform.io) Version 12
- [Turbot Terraform Provider](https://turbot.com/v5/docs/reference/terraform)
- Credentials Configured to connect to your Turbot workspace

## Running the Example

To run the Template:
- Navigate to the directory on the command line `cd aws_lambda_in_vpc`
- Run `terraform plan -var-file="default.tfvars"` and review the changes to be applied
- Run `terraform apply -var-file="default.tfvars"` to execute and apply the policy settings

> The template will run with the default values set in `default.tfvars`; however, you could create and set your own defaults using a `.tfvars` file that will override the existing files.