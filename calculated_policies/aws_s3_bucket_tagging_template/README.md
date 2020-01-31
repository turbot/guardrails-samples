# AWS S3 / Set default tags on buckets with dynamic metadata.

## User Story
The business owner of the AWS platform wants to consistently tag all resources with business metadata to meet company standards and ensure supportability and cost transparency. 

## Implementation Details
Provides a Terraform configuration for creating a smart folder and applying a calculated policy on the `AWS> S3> Bucket> Tags> Template`.  The Calculated policy creates a tag template.  The template shows creating static and dynamic values.  It also shows how to control the values of tags on a bucket.

### Template Input (GraphQL)
The template input to a calculated policy is a GraphQL query.  In this case the query selects various metadata about the bucket:
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
The template itself is a [Nunjucks formatted template](https://mozilla.github.io/nunjucks/templating.html) with custom logic:
```
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

## Pre-requisites

To create the smart folder, you must have:
- [Terraform](https://www.terraform.io) Version 12
- [Turbot Terraform Provider](https://github.com/turbotio/terraform-provider-turbot)
- Credentials Configured to connect to your Turbot workspace

## Running the Example

To run the Template:
- Navigate to the directory on the command line `cd aws_s3_bucket_tagging_template`
- Run `terraform plan -var-file="default.tfvars"` and review the changes to be applied
- Run `terraform apply -var-file="default.tfvars"` to execute and apply the policy settings

> The template will run with the default values set in `default.tfvars`; however, you could create and set your own defaults using a `.tfvars` file that will override the existing files.