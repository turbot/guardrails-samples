# AWS Well-Architected Framework Calc Policy for Key Management

## Use case

The organization has two classifications of data encryption, with a `top-secret` and `ultra` key.  This calc policy checks for the presence of those two keys.

## Implementation details

This Terraform template creates a smart folder and creates these two policies:

- `AWS > Well-Architected Tool > AWS Well-Architected Framework > Security > SEC 08. How do you protect your data at rest?`
- `AWS > Well-Architected Tool > AWS Well-Architected Framework > Security > SEC 08. How do you protect your data at rest? > Implement secure key management`

The below calc policy demonstrates how to use resource queries in a calc policy.  As is, the queries will look across the entire workspace for the `top-secret` and `ultra` keys, not in a single account.

### Template input (GraphQL)

The template input to a calculated policy is a GraphQL query.

The GraphQL query will check if two KMS keys are present, one key with 'classification'='top-secret' and 'classification'='ultra-secret'.
At least instance of both keys must be present for this policy value to be `True`, else the value is `False`.

```graphql
{
  topsecret:resources(filter:"resourceTypeId:'tmod:@turbot/aws-kms#/resource/types/key' tags:'classification'='top-secret'")
  {
   metadata {
    stats {
      total
    }
  }
  }
  ultrasecret:resources(filter:"resourceTypeId:'tmod:@turbot/aws-kms#/resource/types/key' tags:'classification'='ultra-secret'")
  {
   metadata {
    stats {
      total
    }
  }
  }
}
```

### Template (Nunjucks)

Approval logic for Key Management
If a 
```nunjucks
{% if $.topsecret.metadata.stats.total > 0 and $.ultrasecret.metadata.stats.total > 0 -%}
'True'
{% else -%}
'False'
{% endif -%}
```

The template itself is a [Nunjucks formatted template](https://mozilla.github.io/nunjucks/templating.html).

## Prerequisites

To run Turbot Calculated Policies, you must install:

- [Terraform](https://www.terraform.io) Version 12 or higher. Tested with TF 13.
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

- turbot_profile 
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
