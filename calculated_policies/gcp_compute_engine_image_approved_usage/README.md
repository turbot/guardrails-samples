# GCP Compute Engine - approve the image usage based on the approved image and project list

## Use case

The business owner of the GCP project will allow only the images that are in the approved image which are from approved project to be used.

## Implementation details

This Terraform template creates a smart folder and applies calculated policies on the policies:

- `AWS > VPC > Elastic IP > Approved`
- `AWS > VPC > Elastic IP > Approved > Usage`

If an elastic ip is associated with resource then the approved usage policy will be set to `Approved` otherwise
it will be set to `Not Approved`.

### Template input (GraphQL)

The template input to a calculated policy is a GraphQL query.

GraphQL query that will check if a function policy has cross-account access.
If the query returns an array of zero items, then there are no function with cross-account access.

```graphql
{
      item: resource {
        name: get(path: "name")
        imageId: get(path: "sourceImage")
      }
}
```

### Template (Nunjucks)

Approval logic for Lambda Function cross-account access.
If no external account is found in Principal.AWS, Condition.'AWS:SourceAccount' or Condition.'AWS:SourceArn'
then there are no cross-account access

```nunjucks
{% if $.item.imageId == null %} 
  "Not approved"
{% else %}
{% set imageName = $.item.name %}
{% set imageProject = $.item.imageId.split("projects/")[1].split("/") | first %}
{% set approvedImageProjectList = [
  'project1',
  'project2'
  ] %}
{% set approvedImageList  = [
  'image1',
  'image2'
  ] %}

{% if imageProject in approvedImageProjectList and imageName in approvedImageList%}
  "Approved"
{% else %}
  "Not approved"  
{% endif %}
{% endif %}
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