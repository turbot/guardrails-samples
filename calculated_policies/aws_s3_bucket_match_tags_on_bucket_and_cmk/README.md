# AWS S3 - Match tags on Bucket and corresponding CMK

## Use case

The business owner may have different classifications of data (PII, Health, Proprietary, etc).
Where, S3 buckets are designated to hold specific classes of data. For each classification, a corresponding
Customer Managed Key should exist.
To ensure that the right CMK is attached to the right bucket, a comparison needs to be made between the tags
on the bucket and on the CMK.

## Implementation Details

This Terraform template creates a smart folder and applies calculated policies on the policies:

- `AWS > S3 > Bucket > Encryption at Rest`
- `AWS > S3 > Bucket > Encryption at Rest > Customer Managed Key`

The policy execute queries to get the bucket's tags and the corresponding CMK's tags
A comparison is then made between the bucket's tags, and the tags on the KMS key.
If they match, the bucket is approved, else the bucket is unapproved.
In case the bucket is not encrypted with KMS, then it is unapproved.
Depending on the value set in `AWS > S3 > Bucket > Encryption at Rest`, customer may choose to raise an alarm or
remediate the KMS attached to the bucket.

### Template Input (GraphQL)

The template input to a calculated policy is a GraphQL query.

In the fist query, policy gets the encryption rules for the bucket where may contain the KMS Arn
In the second query, policy uses Numjucks to iterate over encryption rules searching for the KMS Arn
If it finds, then it will get current bucket tags and the corresponding MKS key tags by KMS Arn,
otherwise it will only get current bucket tags

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
    bucket: resource {
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

Checks if KMS key exists and contains the desired tag (set on [default.tfvars](default.tfvars) `cross_resource_tag_key`)
Checks if bucket contains the desired tag (set on [default.tfvars](default.tfvars) `cross_resource_tag_key`)
Checks if the value of both KMS key `cross_resource_tag_key` tag and Bucket matches
If it does match, then policy is set to `Approved`
Any other case it is set to `Not approved`

```nunjucks
{%- if $.kmsKey.tags['${var.cross_resource_tag_key}']
  and $.bucket.tags['${var.cross_resource_tag_key}']
  and $.kmsKey.tags['${var.cross_resource_tag_key}'] == $.bucket.tags['${var.cross_resource_tag_key}'] -%}
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
