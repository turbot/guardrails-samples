# AWS EC2 - Restrict Instance Images to trusted AMI

## Use case

Use this policy if you would like to restrict the usage of EC2 Instance Images to a list of trusted AMIs.

## Implementation Details

This Terraform template creates a smart folder and applies calculated policies on the policies:

- `AWS > EC2 > Instance > Approved`
- `AWS > EC2 > Instance > Approved > Usage`

If a EC2 Instance Image is not in the trusted AMI list, then the approved usage
policy will be set to `Not approved` otherwise it will be set to `Approved`.

### Template Input (GraphQL)

The template input to a calculated policy is a GraphQL query.

GraphQL query that will get the Instance Image.

```graphql
{
  resource {
    imageId: get(path: "ImageId")
  }
}
```

### Template (Nunjucks)

Approval logic for EC2 Instance trusted AMI.
If Instance Image is not in `approvedImageIds` list, then it will return `Not approved`.

```nunjucks
{% set approvedImageIds = [
    "${join("\",\n      \"", var.trusted_ami_list)}"
  ]
%}
{% if $.resource.imageId in approvedImageIds %}
  "Approved"
{% else %}
  "Not approved"
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

- target_resource
- trusted_ami_list
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
