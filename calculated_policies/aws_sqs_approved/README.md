# AWS SQS Queue Approved Usage / Alarm if SQS policy violates org restrictions

## Use case

The business owner of the AWS platform wants to use SQS within the environment and would like to get alarms if a queue
policy contains "Action: SQS:*"

## Implementation Details

Provides a Terraform configuration for creating a smart folder and applying a calculated policy on the 
`AWS > SQS > Queue > Approved > Usage` policy.
The Calculated policy creates a template that will alarm if a queue policy contains "Action: SQS:*".

### Template Input (GraphQL)

The GraphQL query selects policy metadata on an SQS queue.

```graphql
{
  resource {
    pol: get(path: "Policy")
  }
}
```

### Template (Nunjucks)

```nunjucks
{%- set regExp = r/"SQS:*/g -%}
{%- if regExp.test($.resource.pol) -%}
  Not approved
{%- else -%}
  Approved
{%- endif -%}
```

The template itself is a [Nunjucks formatted template](https://mozilla.github.io/nunjucks/templating.html).

## Prerequisites

To create the smart folder, you must have:

- [Terraform](https://www.terraform.io) Version 12
- [Turbot Terraform Provider](https://github.com/turbotio/terraform-provider-turbot)
- Credentials Configured to connect to your Turbot workspace

## Running the Example

Scripts can be run in the folder that contains the script.

### Configure the script

Update [default.tfvars](default.tfvars) or create a new Terraform configuration file.

Variables that are exposed by this script are:

- smart_folder_title (Optional)

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
