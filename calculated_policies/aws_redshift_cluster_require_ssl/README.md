# AWS EC2 / Set maximum age of specially tagged EC2 instances.

## User Story
The business owner of the AWS Lab environment wants to ensure that all EC2 Lab instances (instances tagged Environment:=Lab) are not being used for extended periods of time. The business rule designed states that lab instances must be less than 30 days old.

## Implementation Details
This script provides a Terraform configuration for creating a smart folder and applying a calculated policy on the `AWS > EC2 > Instance > Active > Age` policy.  The Calculated policy sets the active age threshold to 30 days when a tag is present on the instance matching {Environment:=Lab} and to skip if it is not present or set to an alternate value. 

### Template Input (GraphQL)
The template input to a calculated policy is a GraphQL query.  In this case the query selects all tags from the instance:
```graphql
{
  instance {
    turbot {
      tags
    }
  }
}
```
### Template (Nunjucks)
The template itself is a [Nunjucks formatted template](https://mozilla.github.io/nunjucks/templating.html) with custom logic:
```js
{% if $.instance.turbot.tags.Environment == "Lab" %}
  "Force inactive if age > 30 days"
{% else %}
  "Skip"
{% endif %}
```

## Pre-requisites

To create the smart folder, you must have:
- [Terraform](https://www.terraform.io) Version 12
- [Turbot Terraform Provider](https://github.com/turbotio/terraform-provider-turbot)
- Credentials Configured to connect to your Turbot workspace

## Running the Example

To run the Template:
- Navigate to the directory on the command line `cd aws_ec2_instance_age`
- Run `terraform plan -var-file="default.tfvars"` and review the changes to be applied
- Run `terraform apply -var-file="default.tfvars"` to execute and apply the policy settings

> The template will run with the default values set in `default.tfvars`; however, you could create and set your own defaults using a `.tfvars` file that will override the existing files.