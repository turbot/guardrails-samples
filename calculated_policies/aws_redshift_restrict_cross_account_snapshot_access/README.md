# AWS RedShift - restrict cross-account access to Redshift manual snapshots

## Use case

Use this policy if you would like to restrict the usage of allowing an external account getting access to the
Redshift manual snapshots of the current account.

## Implementation Details

Calculated policy for policy `AWS &gt; Redshift &gt; Manual Cluster Snapshot &gt; Approved &gt; Usage`.
If a manual snapshot is configured to allow access from external accounts restore access then the approved usage 
policy will be set to `Not approved` otherwise it will be set to `Approved`.

### Template Input (GraphQL)

GraphQL query that will check if a manual cluster snapshot has accounts with restore access.
If the query returns an array of zero items, then there are no accounts with cross-account access.

```graphql
{
  clusterSnapshotManual {
    AccountsWithRestoreAccess
  }
}
```

### Template (Nunjucks)

Approval logic for Redshift cross-account access.


```nunjucks
{% if $.clusterSnapshotManual.AccountsWithRestoreAccess | length -%}
  Not approved
{% else -%}
  Approved
{% endif -%}
```

The template itself is a [Nunjucks formatted template](https://mozilla.github.io/nunjucks/templating.html).

## Prerequisites

To create the smart folder, you must have:

- [Terraform](https://www.terraform.io) Version 12
- [Turbot Terraform Provider](https://github.com/turbotio/terraform-provider-turbot)
- Credentials Configured to connect to your Turbot workspace

## Running the Example

Scripts can be run in the folder that contains the script.

### Configure the script

Update [default.tfvars](default.tfvars) or create a new Terraform configuration file.

Variables that are exposed by this script are:

- target_resource
- smart_folder_parent_resource (Optional)
- smart_folder_title (Optional)
- smart_folder_description (Optional)

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
