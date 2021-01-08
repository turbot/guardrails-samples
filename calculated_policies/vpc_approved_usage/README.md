# AWS VPC - Allow only the usage through Transit Gateway.

## Use case

The business owner wants to use the VPC to connect only through Transit Gateway and restrict the VPC which doesn't have the Transit Gateway attached to it.

## Implementation details

This Terraform template creates a smart folder and applies calculated policies on the policies:

- `AWS > VPC > VPC > Approved`
- `AWS > VPC > VPC > Approved > Usage`

This policy checks if a VPC is attached to a transit gateway.
If its attached to a transit gateway VPC is `Approved` otherwise `Not approved`.
Depending on the value set in `AWS > VPC > VPC > Approved > Usage`, a customer may choose to raise an alarm or
disapprove the VPC.

### Template input (GraphQL)

The template input to a calculated policy is a GraphQL query.

In this query it fetches the VPC Ids and checks its descendant, to check for if it has a transit gateway attachment as  its descendant.

```graphql
    {
      resource {
        VpcId: get(path: "VpcId")
                    descendants(filter: "resourceTypeId:tmod:@turbot/aws-vpc-connect#/resource/types/transitGatewayAttachment level:self,descendant") {
          items {
            VpcId: get(path: "VpcId")
          }
        }
      }
    }
```

### Template (Nunjucks)

Approval logic for VPCs. If the VPC has transit gateway attachments as its descendant then it will return Approved, else it will return Not Approved.


```nunjucks
  {%- if $.resource.descendants.items | length == 0 %}
  'Not approved'
  {% else -%}
  'Approved'
  {%- endif %}
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

- cross_resource_tag_key
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
