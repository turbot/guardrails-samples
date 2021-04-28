# AWS EC2 - Tag AMI if they are older than 14 days
## Use case

Some organizations tag resources to authorize deletions. This set of policies tags an AMI with `termination: true` if the AMI is older than 14 days.

## Implementation details

This Terraform template creates a smart folder and creates the following policies:

- `AWS > EC2 > AMI  > Active`
- `AWS > EC2 > AMI > Active > Age`
- `AWS > EC2 > AMI > Tags`
- `AWS > EC2 > AMI > Tags > Template`


Four different policies will be set. `Active` tells Turbot to check the age of the AMI, while `Active > Age` defines that an AMI is no longer deemed active after 14 days.

### Template input (GraphQL)

The template input to a calculated policy is a GraphQL query.

```graphql
- |
  {
    ami {
      turbot {
        id
      }
    }
  }
- |
  {
    controls(filter: "controlType:tmod:@turbot/aws-ec2#/control/types/amiActive resourceId:{{$.ami.turbot.id}}") {
      items {
        state
      }
    }
  }
```

### Template (Nunjucks)

AWS > EC2 > AMI > Tags > Template

```nunjucks
{%- if $.controls.items[0].state == "alarm" %}
- termination: "true"
{%- else -%}
[]
{%- endif -%}
```

The template itself is a [Nunjucks formatted template](https://mozilla.github.io/nunjucks/templating.html).

## Prerequisites

To run Turbot Calculated Policies, you must install:

- [Terraform](https://www.terraform.io) Version 12, minimum.
- [Turbot Terraform Provider](https://turbot.com/v5/docs/reference/terraform/provider)
- Configured credentials to connect to your Turbot workspace

### Configuring credentials

You must set your `config.tf` or environment variables to connect to your Turbot workspace.
Further information can be found in the Turbot Terraform Provider [Installation Instructions](https://turbot.com/v5/docs/reference/terraform/provider).

## Running the example

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
