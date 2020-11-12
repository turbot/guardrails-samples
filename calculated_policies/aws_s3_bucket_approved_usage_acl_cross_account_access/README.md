# AWS S3 Bucket - Restrict ACL Cross Account Access by user defined Whitelist

## Use case

Bucket set to `Not approved` if ACL cross-account access exists to an account not in a whitelist.

## Implementation details

This Terraform template creates a smart folder and applies calculated policies on the policies:

- `AWS > Region > Bucket > Approved`
- `AWS > Region > Bucket > Approved > Usage`

If the account that the access is shared with through ACL, given by the property `Acl.Grants[].Grantee.ID`
is not whitelisted, then the policy will be set to `Not approved` otherwise it will be set to `Approved`.

### Template input (GraphQL)

The template input to a calculated policy is a GraphQL query.

GraphQL query that will return all the ACL cross-account access rules to compare against an account whitelist
to ensure that the entry is valid.

```graphql
{
  resource {
    onwerId: get(path:"Acl.Owner.ID")
    aclGrants: get(path:"Acl.Grants")
  }
}
```

### Template (Nunjucks)

Add items to the currently empty `whitelist` collection as detailed in inline example comments.
The Nunjucks script will then check if all the accounts in the Bucket ACL are valid by comparing
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
Navigate to the policy and amend the template value by adding entries into the `approvedAccounts` Nunjucks array.
For example, suppose two accounts should be added,
"14dc98d5f2185f3d62afcc95361dd156098a788f09fdd581d68710b503cfad09", and
"49b5a5892783e49a3bd87044a68205269838794f589eaa65a5376d281f839527", this can be added by setting the variable by:

```nunjucks
{#- set approvedAccounts = ["14dc98d5f2185f3d62afcc95361dd156098a788f09fdd581d68710b503cfad09",
          "49b5a5892783e49a3bd87044a68205269838794f589eaa65a5376d281f839527"] -#}
```

**Notes:**
1. All the accounts in Bucket ACL need to have an entry in the whitelist variable named `approvedAccounts`
in order for the Bucket to be valid, otherwise it will be invalid and set to `Not approved`.
2. AWS Account should be in `Canonical user ID` form. Read more about it here:
  https://docs.aws.amazon.com/general/latest/gr/acct-identifiers.html

```nunjucks
{#- Whitelist of accounts that are approved for access through ACL in Canonical user ID form -#}
{#- Read more about Canonical user IDs: https://docs.aws.amazon.com/general/latest/gr/acct-identifiers.html -#}
{%- set approvedAccounts = ["${join("\",\n      \"", var.approved_accounts)}"] -%}
{%- set hasUnapprovedAccount = false -%}

{%- for aclGrant in $.resource.aclGrants -%}
  {%- if aclGrant.Grantee.Type == "CanonicalUser" and aclGrant.Grantee.ID != $.resource.onwerId and aclGrant.Grantee.ID not in approvedAccounts -%}
    {%- set hasUnapprovedAccount = true -%}
  {%- endif -%}
{%- endfor -%}

{%- if not hasUnapprovedAccount -%}
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
