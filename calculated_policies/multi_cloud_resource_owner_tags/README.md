# Multi-Cloud Resource Owner Tags - Set default tags on who created a resource and when it was created

## Use case

Resource tagging can be used to track and manage assets, security, and compliance. Quick and transparent visibility to who created a resource and when it was created can save precious minutes during an incident, but compliance to this is notoriously difficult to enforce. This leaves the cloud team in the unenviable position of nagging application teams to complete tagging of their resources. In Turbot, the information on who created a resource is stored in the notifications table in the “actor” object, while the “turbot” object includes timestamp information. Therefore we can create a calculated policy to bring in the Actor / Creator information along with the timestamp as input into a calculated policy.

## Implementation details

This Terraform template creates a smart folder and applies calculated policies on the policies:

- `AWS > Account > Tags Template [Default]`
- `Azure > Subscription > Tags Template [Default]`
- `GCP > Project > Labels Template [Default]`

These examples assumes global tag templates, however could be set globally per Service, e.g. `AWS > S3 > Tags Template [Default]` or per resource type, e.g. `AWS > S3 > Bucket > Tags > Template`

**NOTE:** To enable the template, per service enable the tag action, e.g. `AWS > S3 > Bucket > Tags`. [More information on Tagging](https://turbot.com/v5/docs/concepts/guardrails/tagging).

### Template input (GraphQL)

The template input to a calculated policy is a GraphQL query.

In this case the query searches for the 1st notification on the resource that will be used as the creator information.

```graphql
{
  resource {
    creator: notifications(filter: "sort:version_id limit:1") {
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

Using `items[0]` we select the first activity notification from the CMDB about this resource, this allows us to identify the original creator of the resource. This example works well for any taggable resource in AWS, Azure and GCP with the same query and template.


First Nunjucks snippet determines if the storage account resource is deployed in a development environment. 
If it is then it will set the Storage Access Tier to `Enforce: Cool` otherwise it will remain `Enforce: Hot`.

Second Nunjucks snippet determines if the S3 Bucket account resource is deployed in a development environment.
If it is then it will set Versioning to `Enforce: Disabled` otherwise it will remain `Enforce: Enabled`.

```nunjucks
# Actor who created the resource 
created_by: "{{ $.resource.creator.items[0].actor.identity.turbot.title }}"

# Creation Timestamp
created_time: "{{ $.resource.creator.items[0].turbot.createTimestamp }}"
```

If you are using this template for GCP Labels, you may need to convert your variables to be GCP Label friendly -- GCP has pesky label requirements.

```nunjucks
# Actor who created the resource
{%- set owner = $.resource.creator.items[0].actor.identity.turbot.title -%}
created_by: "{{ owner | lower | replace(" ", "_") }}"

# Creation Timestamp
{%- set create_time = $.resource.creator.items[0].turbot.createTimestamp -%}
created_time: "{{ create_time | lower | replace(".", "_") | replace(":", "-") }}"
```

The template itself is a [Nunjucks formatted template](https://mozilla.github.io/nunjucks/templating.html).

## Prerequisites

To run Turbot Calculated Policies, you must install:

- [Terraform](https://www.terraform.io) Version 12
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
