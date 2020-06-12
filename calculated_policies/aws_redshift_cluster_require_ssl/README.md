# AWS RedShift - Approve cluster if encryption in transit is required

## Use case

This policy is intended to approve only clusters where encryption in transit is required

## Implementation Details

This Terraform template creates a smart folder and applies calculated policies on the policies:

- `AWS > Redshift > Cluster > Approved`
- `AWS > Redshift > Cluster > Approved > Usage`

Cluster comes with a default parameter group assigned to it which doesn't requires SSL by default.
In order to require encryption in transit, cluster must use a custom parameter group with the
parameter `'require_ssl': 'true'`

### Template Input (GraphQL)

The template input to a calculated policy is a GraphQL query.

Queries cluster and parameter group assigned to it, if any

```graphql
- |
  {
    item: resource {
      parameterGroupName: get(path: "ClusterParameterGroups[0].ParameterGroupName")
      turbot {
        custom
      }
    }
  }
- |
  {
    cluster: resource {
      parameterGroup: get(path: "ClusterParameterGroups[0]")
    }
    parameterGroup: resource (id: "arn:aws:redshift:{{ $.item.turbot.custom.aws.regionName }}:{{ $.item.turbot.custom.aws.accountId }}:parametergroup:{{ $.item.parameterGroupName }}") {
      parameters: get(path:"Parameters")
    }
  }
```

### Template (Nunjucks)

If cluster has a parameter group assigned which has the parameter `'require_ssl': 'true'`
and the parameter is in-sync with the cluster, then Usage policy is set to `Approved`, otherwise `Not approved`

```nunjucks
{%- set requireSslParameter = {} -%}
{%- for parameter in $.parameterGroup.parameters -%}
  {%- if parameter.ParameterName == 'require_ssl' -%}
    {%- set requireSslParameter = parameter -%}
  {%- endif -%}
{%- endfor -%}

{%- set requireSslParameterStatus = {} -%}
{%- for parameterGroup in $.cluster.parameterGroup.ClusterParameterStatusList -%}
  {%- if parameterGroup.ParameterName == 'require_ssl' -%}
    {%- set requireSslParameterStatus = parameterGroup -%}
  {%- endif -%}
{%- endfor -%}

{%- if requireSslParameter
      and requireSslParameter.ParameterValue == 'true'
      and requireSslParameterStatus
      and requireSslParameterStatus.ParameterApplyStatus == 'in-sync' -%}
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
