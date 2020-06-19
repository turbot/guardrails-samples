# AWS EC2 - Set maximum age of specially tagged EC2 instances

## Use case

The business owner of the AWS Lab environment wants to ensure that all EC2 Lab instances 
(instances tagged Environment:=Lab) are not being used for extended periods of time. 
The business rule designed states that lab instances must be less than 30 days old.

## Implementation Details

This Terraform template creates a smart folder and applies calculated policies on the policies:

- `AWS > EC2 > Instance > Active`
- `AWS > EC2 > Instance > Active > Age`

The Calculated policy sets the active age threshold to 30 days when a tag is present on the instance matching 
{Environment:=Lab} and to skip if it is not present or set to an alternate value.

### Template Input (GraphQL)

The template input to a calculated policy is a GraphQL query.

In this case the query selects all tags from the instance.

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

Approval logic for EC2 Instance trusted AWS accounts AMIs.
If Instance Image ownerId is not in `approvedAccounts` list, then it will return `Not approved`.

```nunjucks
{% if $.instance.turbot.tags.Environment == "Lab" %}
  "Force inactive if age > 30 days"
{% else %}
  "Skip"
{% endif %}
```

The template itself is a [Nunjucks formatted template](https://mozilla.github.io/nunjucks/templating.html).

## Prerequisites

To run Turbot Calculated Policies, you must install:

- [Terraform](https://www.terraform.io) Version 12
- [Turbot Terraform Provider](https://turbot.com/v5/docs/reference/terraform/provider)
- Configured credentials to connect to your Turbot workspace

### Configuring Credentials

You must set your `config.tf` or environment variables to connect to your Turbot workspace.
Further information can be found in the Turbot Terraform Provider [Installation Instructions](https://turbot.com/v5/docs/reference/terraform/provider).

## Running the Example

Scripts can be run in the folder that contains the script.

### Configure the script

Update [default.tfvars](default.tfvars) or create a new Terraform configuration file.

Variables that are exposed by this script are:

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
