# AWS GuardDuty - Restrict detector membership to a given master account

## Use case

Use this policy if you would like to restrict GuardDuty Detector membership to a given master account.

## Implementation Details

This Terraform template creates a smart folder and applies calculated policies on the policies:

- `AWS > GuardDuty > Detector > Approved`
- `AWS > GuardDuty > Detector > Approved > Usage`

If a Detector is the master or member of a given master account then the approved usage policy will be set
to `Approved` otherwise it will be set to `Not approved`.

### Template Input (GraphQL)

The template input to a calculated policy is a GraphQL query.

GraphQL query that will check if the Detector membership.

```graphql
{
  resource {
    masterAccount: get(path: "Master.AccountId")
  }
}
```

### Template (Nunjucks)

Approval logic for GuardDuty Detector membership restriction.

```nunjucks
{% if $.resource.masterAccount %}
{%   if $.resource.masterAccount == "${var.detector_master_account}" %}
        "Approved"
{%   else %}
        "Not approved"
{%   endif %}
{% else %}
  "Approved"
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

- detector_master_account
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
