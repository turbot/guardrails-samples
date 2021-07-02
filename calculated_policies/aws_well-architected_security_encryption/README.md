# AWS Well-Architected Framework Calc Policy for Encryption at Rest

## Use case

The organization has encryption at rest requirements for many AWS services.  Instead of enumerating checks on all the required services, one can use the [Encryption at Rest](https://turbot.com/v5/mods/turbot/turbot/inspect#/control/categories/resourceEncryptionAtRest) [control category](https://turbot.com/v5/docs/concepts/controls#control-categories). Control categories aggregate related policies across services and across cloud platforms.

## Implementation details

This Terraform template creates a smart folder and creates these two policies:

- `AWS > Well-Architected Tool > AWS Well-Architected Framework > Security > SEC 08. How do you protect your data at rest?`
- `AWS > Well-Architected Tool > AWS Well-Architected Framework > Security > SEC 08. How do you protect your data at rest? > Enforce encryption at rest`

The below calc policy demonstrates how to look at control category queries in a calc policy.  As is, the queries will look across the entire workspace for the encryption at rest controls in `ok` and `alarm`.

### Template input (GraphQL)

The template input for this calc policy grabs a count of all Encryption at Rest controls (and as a freebie the Encryption in Transit controls too) in `ok` and in `alarm`.  

Be aware that the metadata.stats.total queries can be expensive in large environments.  As an alternative method for checking for presence, one might put `limit:1` in the query and replace the `{metadata{stats{total}}}` block with `items{...}`.  The advantage of `limit:1` is that Turbot only needs to grab a single row instead of getting all rows to generate the `total`.  

```graphql
{
  alarms:controls(filter: "state:alarm controlCategoryId:'tmod:@turbot/turbot#/control/categories/resourceEncryptionAtRest','tmod:@turbot/turbot#/control/categories/resourceEncryptionInTransit'")
  { metadata
    {stats
      {
      	total
    	}
    }
  }
  ok:controls(filter: "state:ok controlCategoryId:'tmod:@turbot/turbot#/control/categories/resourceEncryptionAtRest','tmod:@turbot/turbot#/control/categories/resourceEncryptionInTransit'")
  { metadata
    {stats
      {
      	total
    	}
    }
  }
}
```

### Template (Nunjucks)

This code checks if there are controls in `alarm` and `ok` present.  This is a shortcut to make sure that at least one encryption at rest policies are set.  Stronger checks are certainly possible. 
```nunjucks
{% if $.alarms.metadata.stats.total >= 0 and $.ok.metadata.stats.total > 0 -%}
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
