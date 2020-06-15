# AWS S3 - Match tags on Bucket and corresponding Key Management Service.

## Use case

The business owner may have different classifications of data (PII, Health, Proprietary, etc) where, S3 Buckets are 
designated to hold specific classes of data. 
For each classification, a corresponding Customer Managed Key should exist.
A comparison needs to be made between the tags on the S3 Bucket and on that on the Key Management Service to ensure
that the right Key Management Service is attached to the right S3 Bucket.

## Implementation Details

This Terraform template creates a smart folder and applies calculated policies on the policies:

- `AWS > S3 > Bucket > Encryption at Rest`
- `AWS > S3 > Bucket > Encryption at Rest > Customer Managed Key`

The policy execute queries to get the S3 Bucket's tags and the corresponding Key Management Service's tags.
A comparison is then made between the tags.
If they match, the S3 Bucket is `Approved` otherwise `Not approved`.
Depending on the value set in `AWS > S3 > Bucket > Encryption at Rest`, a customer may choose to raise an alarm or
remediate the Key Management Service attached to the S3 Bucket.

### Template Input (GraphQL)

The template input to a calculated policy is a GraphQL query.

In the fist query gets the encryption rules for the S3 Bucket.
In the second query, policy uses Nunjucks to iterate over encryption rules searching for the Key Management Service 
ARN.
If a match is found, the script will then then query will get the tags for the Key Management Service's tags which 
will later be used to compare against the S3 Bucket tags.

```graphql
- |
  {
    item: resource {
      encryptionRules: get(path: "Encryption.ServerSideEncryptionConfiguration.Rules")
    }
  }
- |
  {%- set encryptionRule = {} -%}
  {%- for rule in $.item.encryptionRules -%}
    {%- if rule.ApplyServerSideEncryptionByDefault -%}
      {%- set encryptionRule = rule -%}
    {%- endif -%}
  {%- endfor -%}
  {
    S3 Bucket: resource {
      tags
    }
    {%- if encryptionRule.ApplyServerSideEncryptionByDefault.KMSMasterKeyID -%}
    kmsKey: resource (id: "{{ encryptionRule.ApplyServerSideEncryptionByDefault.KMSMasterKeyID }}") {
      tags
    }
    {%- endif -%}
  }
```

### Template (Nunjucks)

Checks if Key Management Service key exists and contains the desired tag (set using [default.tfvars](default.tfvars)
variable  `cross_resource_tag_key`.
Checks if S3 Bucket contains the desired tag (set using [default.tfvars](default.tfvars) `cross_resource_tag_key`.
Finally the script will check if the tags match.
If it does match, then policy is set to `Approved` otherwise the policy value will be set to `Not approved`

```nunjucks
{%- if $.kmsKey.tags['${var.cross_resource_tag_key}']
  and $.S3 Bucket.tags['${var.cross_resource_tag_key}']
  and $.kmsKey.tags['${var.cross_resource_tag_key}'] == $.S3 Bucket.tags['${var.cross_resource_tag_key}'] -%}
  Approved
{%- else -%}
  Not approved
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
