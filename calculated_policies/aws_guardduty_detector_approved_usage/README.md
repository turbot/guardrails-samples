# AWS GuardDuty Detector Approved Usage / Alarm if GuardDuty Detector policy violates org restrictions

## Use case
The business owner of the AWS platform wants to use GuardDuty within the environment but would like to get alarms if a 
Detector is a member account of a master account rather than the one specified beforehand.

## Implementation Details
Provides a Terraform configuration for creating a smart folder and applying a calculated policy on the 
`AWS > GuardDuty > Detector > Approved > Usage`.  The Calculated policy creates a template that will alarm if a 
Detector is a member account of a master account rather than the one specified beforehand.

### Template Input (GraphQL)
The template input to a calculated policy is a GraphQL query.  In this case the query selects policy metadata on 
an GuardDuty Detector:

```graphql
{
  resource {
    masterAccount: get(path: "Master.AccountId")
  }
}
```

### Template (Nunjucks)
The template itself is a [Nunjucks formatted template](https://mozilla.github.io/nunjucks/templating.html) with 
custom logic:

```
  {% if $.resource.masterAccount %}
  {%   if $.resource.masterAccount == "${var.detector_master_account}" %}
          "Approved"
  {%   else %}
          "Not approved"
  {%   endif %}
  {% else %}
    "Approved"
  {% endif %}
```

## Pre-requisites

To create the smart folder, you must have:
- [Terraform](https://www.terraform.io) Version 12
- [Turbot Terraform Provider](https://github.com/turbotio/terraform-provider-turbot)
- Credentials Configured to connect to your Turbot workspace

## Running the Example

To run the Template:
- Navigate to the directory on the command line `cd aws_guardduty_detector_approved_usage`
- Run `terraform plan -var-file="default.tfvars"` and review the changes to be applied
- Run `terraform apply -var-file="default.tfvars"` to execute and apply the policy settings

> The template will run with the default values set in `default.tfvars`; however, you could create and set your own 
> defaults using a `.tfvars` file that will override the existing files.
