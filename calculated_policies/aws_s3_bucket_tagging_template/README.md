# AWS S3 - Set default tags on buckets with dynamic metadata

## Use case

The business owner of the AWS platform wants to consistently tag all resources with business metadata to meet company
standards and ensure supportability and cost transparency.

## Implementation Details

This Terraform template creates a smart folder and applies the calculated policy on the policy:

- `AWS > Region > Bucket > Tags > Template`

The Calculated policy creates a tag template.
The template shows creating static and dynamic values.
It also shows how to control the values of tags on a bucket.

### Template Input (GraphQL)

The template input to a calculated policy is a GraphQL query.

In this case the query selects various metadata about the bucket.

```graphql
{
  account {
    Id
  }
  folder {
    turbot {
      tags
    }
  }
  bucket {
    Name
    turbot {
      tags
    }
    creator: history(filter: "sort:version_id limit:1") {
      items {
        actor {
          identity {
            turbot {
              title
            }
          }
        }
        turbot {
          createTimestamp
        }
      }
    }
  }
}
```

### Template (Nunjucks)

```nunjucks
{# Use tags from folder level #}
"Cost Center": "{{ $.folder.turbot.tags.Cost_Center }}"

{# Static Name Example #}
"Company": "Acme Inc."

{# Use AWS environment metadata / attributes #}
"Billing Account Detail": "AF-{{ $.account.Id }}"
"Bucket Name": "{{ $.bucket.Name }}"

{# Allow any value except null, set to "Non-Compliant" if out of bounds #}
"Description": "{% if $.bucket.turbot.tags['Description'] %}{{ $.bucket.turbot.tags['Description'] }}{% else %}Non-Compliant Tag{% endif %}"

{# Enforce selection of values, set to "Non-Compliant" if out of bounds #}
"Environment": "{% if $.bucket.turbot.tags['Environment'] in ['Dev', 'QA', 'Prod', 'Temp'] %}{{ $.bucket.turbot.tags['Environment'] }}{% else %}Non-Compliant Tag{% endif %}"

{# Actor who created the bucket #}
"CreatedByActor": "{{ $.bucket.creator.items[0].actor.identity.turbot.title }}"

{# Creation Timestamp #}
"CreatedByTime": "{{ $.bucket.creator.items[0].turbot.createTimestamp }}"
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
