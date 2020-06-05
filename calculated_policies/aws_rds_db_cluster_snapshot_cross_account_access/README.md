# AWS RDS - Restrict RDS DB Clusters access to cross account Manual DB Clusters Snapshots

## Use case

Cluster Snapshot set to `Not approved` if cross account access exists to an account not in a whitelist.

## Implementation Details

This Terraform template creates a smart folder and applies calculated policies on the policies:

- `AWS > RDS > DB Cluster Snapshot [Manual] > Approved`
- `AWS > RDS > DB Cluster Snapshot [Manual] > Approved > Usage`

If the account that the snapshot is shared with, given by the property `DBClusterSnapshotAttributes.AttributeValues`

### Template Input (GraphQL)

The template input to a calculated policy is a GraphQL query.

GraphQL query that will return all the shared account details to compare against a whitelist to ensure that the
snapshot is valid.

```graphql
{
  dbClusterSnapshotManual {
    sharedAccounts: get(path:"DBClusterSnapshotAttributes.AttributeValues")
  }
}
```

### Template (Nunjucks)

Add items to the currently empty `whitelist` collection as detailed in inline example comments.
The Nunjucks script will then check if all the accounts that are shared with the snapshot are valid by comparing 
entries from a whitelist of accounts.

To add entries to the whitelist can be done in two different ways:

- Using `defaults.tf`
- Amending the list in Turbot UI

#### Using `defaults.tf`

**Recommended**
Add the entries into the file as a list of accounts. 
When running the script it will add these entries into the Calculated Policy automatically and allow the end 
user to control the accounts centrally.

#### Amending the list in Turbot UI

If the company workflow is to modify the Calculated Policy directly in Turbot. 
Navigate to the policy and amend the template value by adding entries into the `whitelist` Nunjucks array. 
For example, suppose two accounts should be added, "012345678901", "109876543210", this can be added by setting
the variable by:

```nunjucks
{#- set whitelist = ["012345678901", "109876543210"] -#}
```

**Note:** All the accounts that are being shared by the snapshot need to have an entry in the whitelist in order
for the snapshot to be valid, otherwise it will be invalid and set to `Not approved`.

```nunjucks
{#- Whitelist of account that are approved for snapshot usage -#}
{%- set whitelist = ["${join("\" ,\"", var.approved_accounts)}"] -%}
{%- set approvalCount = 0 -%}

{%- for sharedAccount in $.dbClusterSnapshotManual.sharedAccounts | sort -%}
  {%- for validAccount in whitelist | sort -%}
    {%- if validAccount == sharedAccount -%}
      {%- set approvalCount = approvalCount + 1 -%}
    {%- endif -%}
  {%- endfor -%}
{%- endfor -%}

{%- if approvalCount ==  $.dbClusterSnapshotManual.sharedAccounts | length -%}
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

### Configuring Credentials

You must set your `config.tf` or environment variables to connect to your Turbot workspace.
Further information can be found in the Turbot Terraform Provider [Installation Instructions](https://turbot.com/v5/docs/reference/terraform/provider).

## Running the Example

Scripts can be run in the folder that contains the script.

### Configure the script

Update [default.tfvars](default.tfvars) or create a new Terraform configuration file.

Variables that are exposed by this script are:

- approved_accounts
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
