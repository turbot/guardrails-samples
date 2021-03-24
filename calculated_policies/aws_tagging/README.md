# AWS Resources - Use a Default Tagging Template That Applies to All Turbot Managed AWS Resources

## Use case

Organizations have minimal, default tagging requirements for all cloud resources. In this particular example, all resources under Turbot management must have the following tags:

* owner:       Must exist and be a valid email address
* costcenter:  Must exist
* environment: Must exist and be one of ['dev', 'test', 'prod']

## Implementation details

This Terraform template creates a smart folder and calculated policy for `AWS > Account > Tags Template [Default]`, in addition to creating the policy `AWS > {Service} > {Resource} > Tags > Template` for each service. The services that will have the policy applied can be customized in the `default.tfvars` file.

### Template input (GraphQL)

The template input to a calculated policy is a GraphQL query.

In this case the query selects all tags from the instance.

```graphql
{
    resource {
        tags
    }
    folder {
        turbot {
            tags
        }
    }
}
```

### Template (Nunjucks)

Logic for determining if existing tags are acceptable. The template will overwrite tags that are not correct, as well as create tags that must exist but do not. Note that the tag `owner` must be an email. Regex is used to verify the tag value.

```nunjucks
{#- Set default value for non-existant and incorrect tags -#}
{#- #################################################### -#} 
{%- set missingTag = "__MissingTag__" -%}
{#- Set regex for valid email -#} 
{#- ######################### -#} 
{%- set regExp = r/(^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$)/ %}
{#- Check for required tags -#} 
{#- ####################### -#} 
{#- Check that owner tag exists and is valid -#} 
{#- ######################################## -#} 
{%- if $.resource.tags['owner'] -%}
  {%- if regExp.test($.resource.tags['owner']) -%}
    - owner: {{$.resource.tags['owner']}}
  {%- else -%}
    - owner: InvalidTagValue __{{$.resource.tags['owner']}}__
  {%- endif %}
{% else -%}
  {%- if $.folder.turbot.tags['owner'] -%}
    - owner: {{$.folder.turbot.tags['owner']}}
  {% else -%}
    - owner: {{missingTag}}
  {%- endif %}
{% endif -%}
{#- Check that environment tag exists and is valid -#} 
{#- ######################################## -#} 
{%- set acceptableValues = ['dev', 'test', 'prod'] -%}
{%- if $.resource.tags['environment'] -%}
  {%- if $.resource.tags['environment'] in acceptableValues -%}
    - environment: {{$.resource.tags['environment']}}
  {%- else -%}
    - environment: InvalidTagValue __{{$.resource.tags['environment']}}__
  {%- endif %}
{% else -%}
  {%- if $.folder.turbot.tags['environment'] -%}
    - environment: {{$.folder.turbot.tags['environment']}}
  {% else -%}
    - environment: {{missingTag}}
  {%- endif %}
{% endif -%}
{#- Check that costcenter tag exists -#} 
{#- ######################################## -#} 
{%- if $.resource.tags['costcenter'] -%}
    - costcenter: {{$.resource.tags['costcenter']}}
{% else -%}
  {%- if $.folder.turbot.tags['costcenter'] -%}
    - costcenter: {{$.folder.turbot.tags['costcenter']}}
  {% else -%}
    - costcenter: {{missingTag}}
  {%- endif %}
{% endif -%}
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