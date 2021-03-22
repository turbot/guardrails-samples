# AWS EC2 AMI and Snapshots

## Use case

Snapshots and AMI can be granted share permissions to any AWS account. Organizations want to restrict that sharing to only a select number of approved AWS accounts.

## Implementation details

This Terraform template creates a smart folder, a Turbot File, and four policies:

* Smart Folder with a title defaulting to `EC2 AMI and Snapshot Cross Account Access`
* Turbot File with the aka defaulting to `list_accounts`
* `AWS > EC2 > Snapshot > Approved` and `AWS > EC2 > AMI > Approved` policies both set to `Check: Approved`
* A calculated policy for both `AWS > EC2 > Snapshot > Approved > Usage` and `AWS > EC2 > AMI > Approved > Usage` 


### Turbot File
The Terraform apply will create a Turbot File which the calculated policies use as a reference for allowed account IDs. For this example, the File contains the following information:

```json
{
  "snapshot_trusted_accounts" : [
    "567890123456",
    "012345678901"
  ],
  "ami_trusted_accounts" : [
    "234567890123",
    "345678901234"
  ]
}
```

### Template input (GraphQL)

The template_input in a calculated policy is a GraphQL query against the Turbot CMDB.

`AWS > EC2 > Snapshot > Approved > Usage`
```graphql
{
  resource {
      permissions: get(path: "snapshotAttributes.CreateVolumePermissions")
  }
  list_trusted_accounts: resource(id:"list_accounts") {
    data
  }
}
```

`AWS > EC2 > AMI > Approved > Usage`
```graphql
{
    resource {
        permissions: get(path: "LaunchPermissions")
    }
  list_trusted_accounts: resource(id:"list_accounts") {
    data
  }
}
```

### Template (Nunjucks)

Logic to evaluate the metadata of an AMI or snapshot and subsequently set the approval policy to `Not approved` or `Approved`.

`AWS > EC2 > Snapshot > Approved > Usage`
```nunjucks
{%- set approved = true -%}
{%- for permission in $.resource.permissions -%}
  {%- if permission.UserId not in $.list_trusted_accounts.data.snapshot_trusted_accounts -%}
    {%- set approved = false -%}
  {%- endif -%}
{%- endfor -%}
{%- if approved  -%}
  "Approved"
{%- else -%}
  "Not approved"
{%- endif -%}
```

`AWS > EC2 > AMI > Approved > Usage`
```nunjucks
{%- set approved = true -%}
{%- for permission in $.resource.permissions -%}
    {%- if permission.UserId not in $.list_trusted_accounts.data.ami_trusted_accounts -%}
        {%- set approved = false -%}
    {%- endif -%}
{%- endfor -%}
{%- if approved  -%}
    "Approved"
{%- else -%}
    "Not approved"
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

- smart_folder_title (Optional)
- smart_folder_description (Optional)
- smart_folder_parent_resource (Optional)
- turbot_file_name (Optional)
- turbot_file_description (Optional)
- turbot_file_aka (Optional)

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
