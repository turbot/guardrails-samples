# AWS EC2 - EC2 Instances approved based on image tags
## Use case

Use this policy if you would like to restrict the usage of EC2 instances based on image tags.

## Implementation details

This Terraform template creates a smart folder and applies calculated policies on the policies:

- `AWS > EC2 > Instance > Approved`
- `AWS > EC2 > Instance > Approved > Usage`


The Usage policy checks the underlying image for the existence of the key: value pair `approved`:`yes`. Any other condition results in the EC2 instance being marked `Not approved`. This includes instances using public images.

### Template input (GraphQL)

The template input to a calculated policy is a GraphQL query.

```graphql
-   | 
    {
        resource {
            image: get (path:"Image.ImageId")
        }
    }

-   |
    {
        resources(filter: "resourceType:'tmod:@turbot/aws-ec2#/resource/types/Ami' $.ImageId:'{{$.resource.image}}'") {
            items {
                tags
                public:get (path: "Public")
            }
        }
    } 
```

### Template (Nunjucks)

Approval logic for EC2 Instances.

```nunjucks
{%- set approved = "Approved" -%}

{%- if $.resources.items[0].public == true -%}
{%- set approved = "Not approved" -%}
{%- elif not $.resources.items[0].tags -%}
{%- set approved = "Not approved" -%}
{%- elif not $.resources.items[0].tags['approved'] -%}
{%- set approved = "Not approved" -%}
{%- elif not $.resources.items[0].tags['approved'] == "yes" -%}
{%- set approved = "Not approved" -%}
{%- endif -%}

{{ approved }}
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
