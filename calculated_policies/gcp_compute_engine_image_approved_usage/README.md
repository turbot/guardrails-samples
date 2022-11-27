# GCP Compute Engine - approve the instance based on approved image(s).

## Use case

The business owner of the GCP project will allow only the instances that are launched using the approved image(s).

## Implementation details

This Terraform template creates a smart folder and applies calculated policies on the policies:

- `GCP > Compute Engine > Instance > Approved`
- `GCP > Compute Engine > Instance > Approved > Custom`

If an Image Id of the Compute Instance is in the list of Approved list of Images then the the Custom policy will be set to `Approved` otherwise
it will be set to `Not Approved`.

### Template input (GraphQL)

The template input to a calculated policy is a GraphQL query.
We make use of a multi-query for this. The first part of the query captures the Root Disk details of the Compute Instance, and search for the `sourceImageId` from the Images list.

```graphql
- |
  {
    resource {
      rootDiskName: get(path: "disks[0].deviceName")
    }
  }
- |
  {
    disks: resources(filter: "resourceTypeId:'tmod:@turbot/gcp-computeengine#/resource/types/disk' $.name:{{ $.resource.rootDiskName }} resourceTypeLevel:self"){
      items {
        sourceImage: get(path: "sourceImage")
        sourceImageId: get(path: "sourceImageId")
      }
    }
  }
```
NOTE: The `Calculated Policy Builder` does not support multi-query, but works when deployed via Terraform. 
### Template (Nunjucks)

Approval logic for Google Compute Instance for Image.
If the instance Image Id is part of the approved sourceImages list then the instance is marked approved. 

```nunjucks
{% if $.disks.items | length == 0 %}
- title: Image
  result: Not approved
  message: Unable to find the source Image details.
{%- elif $.disks.items[0].sourceImageId in ['4644004327634874935', '4801817364715522935']  %}
- title: Image
  result: Approved
  message: Image {{ $.disks.items[0].sourceImage.split('/').pop() }} is approved for usage.
{% else %}
- title: Image
  result: Not approved
  message: Image {{ $.disks.items[0].sourceImage.split('/').pop() }} is not approved for usage.
{%- endif -%}
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