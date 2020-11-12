# AWS S3 Bucket - Restrict Cross Account Replication by user defined Whitelist

## Use case

Turbot V3 had the ability to skip a specific setting in the Public Access Block.
This calculated policy reintroduces that behaviour.

## Implementation details

This Terraform template creates a smart folder and applies calculated policies on the policies:

- `AWS > S3 > Bucket > Public Access Block`
- `AWS > S3 > Bucket > Public Access Block > Settings`

If the account that the replication is shared with, given by the property `Replication.Rules[].Destination.Account`
is not whitelisted, then the policy will be set to `Not approved` otherwise it will be set to `Approved`.

### Template input (GraphQL)

The template input to a calculated policy is a GraphQL query.

Query to return the current settings of the Public Access Block.

```graphql
{
  resource: bucket {
    publicAccessBlock: get(path: "PublicAccessBlock")
  }
}
```

### Template (Nunjucks)

Add the desired settings into the variable `public_access_block_settings_skip_list` which is a list of strings.
If a setting is not provided then the value of the resource will be used as the value is expected.
The settings can be configured using the variable definition file `default.tfvars` and is by default an empty set.

#### Using `defaults.tf`

**Recommended**
Add the settings into the file as a list of strings.
When running the script it will add these entries into the Calculated Policy automatically and allow the end
user to control the accounts centrally.

#### Amending the list in Turbot UI

If the company workflow is to modify the Calculated Policy directly in Turbot.
Navigate to the policy and amend the template value by adding settings into the Nunjucks array.
For example, suppose two accounts should be added, "check_block_public_acls", "uncheck_block_public_bucket_policies",
this can be added by setting the variable by:

```nunjucks
{%- set settings = ["check_block_public_acls", "uncheck_block_public_bucket_policies"] -#}
```

The template body will look at the current settings and will use the previous values if no setting was found.

```nunjucks
{%- set result = "" -%}
{%- set settings = ["${join("\", \"", var.public_access_block_settings_skip_list)}"] -%}
{%- set completedBlockPublicAcl = false -%}
{%- set completedBlockPublicBucketPolicies = false -%}
{%- set completedIgnorePublicACLs = false -%}
{%- set completedRestrictPublicBucketPolicies = false -%}

{%- for setting in settings -%}
    {%- if setting == "check_block_public_acls" -%}
        {%- set result = result + "- Block Public ACLs\n" -%}
        {%- set completedBlockPublicAcl = true -%}
    {%- elif setting == "uncheck_block_public_acls" -%}
        {%- set completedBlockPublicAcl = true -%}
    {%- endif -%}

    {%- if setting == "check_block_public_bucket_policies" -%}
        {%- set result = result + "- Block Public Bucket Policies\n" -%}
        {%- set completedBlockPublicBucketPolicies = true -%}
    {%- elif setting == "uncheck_block_public_bucket_policies" -%}
        {%- set completedBlockPublicBucketPolicies = true -%}
    {%- endif -%}

    {%- if setting == "check_ignore_public_acls" -%}
        {%- set result = result + "- Ignore Public ACLs\n" -%}
        {%- set completedIgnorePublicACLs = true -%}
    {%- elif setting == "uncheck_ignore_public_acls" -%}
        {%- set completedIgnorePublicACLs = true -%}
    {%- endif -%}

    {%- if setting == "check_restrict_public_bucket_policies" -%}
        {%- set result = result + "- Restrict Public Bucket Policies\n" -%}
        {%- set completedRestrictPublicBucketPolicies = true -%}
    {%- elif setting == "uncheck_restrict_public_bucket_policies" -%}
        {%- set completedRestrictPublicBucketPolicies = true -%}
    {%- endif -%}
{%- endfor -%}
{%- if completedBlockPublicAcl == false and $.resource.publicAccessBlock.BlockPublicAcls == true -%}
    {%- set result = result + "- Block Public ACLs\n" -%}
{%- endif -%}

{%- if completedBlockPublicBucketPolicies == false and $.resource.publicAccessBlock.BlockPublicPolicy == true -%}
    {%- set result = result + "- Block Public Bucket Policies\n" -%}
{%- endif -%}

{%- if completedIgnorePublicACLs == false and $.resource.publicAccessBlock.IgnorePublicAcls == true -%}
    {%- set result = result + "- Ignore Public ACLs\n" -%}
{%- endif -%}

{%- if completedRestrictPublicBucketPolicies == false and $.resource.publicAccessBlock.RestrictPublicBuckets == true -%}
    {%- set result = result + "- Restrict Public Bucket Policies\n" -%}
{%- endif -%}

{%- if result == "" -%}
[]
{%- else -%}
{{ result }}
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
