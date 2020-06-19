# Azure Networking - Prevent unapproved network configuration for load balancers

## Use case

The cloud operations team would like to ensure that they can detect if any load balancers exist that allow 
communication on known non-encrypted ports (e.g. FTP/21, HTTP/80 and SMTP/25).

## Implementation Details

This Terraform template creates a smart folder and applies calculated policies on the policies:

- `Azure > Load Balancer > Load Balancer > Approved`
- `Azure > Load Balancer > Load Balancer > Approved > Usage`

The Calculated policy sets the value to "Unapproved" when one of the specified ports are present in the NAT or Load 
Balancer front end or back end rules and sets the value "Approved" otherwise.

### Template Input (GraphQL)

The template input to a calculated policy is a GraphQL query.

In this case the query selects all of the front end and back end port values from the NAT and Load Balancer rules.

```graphql
{
  resource {
    natrules: get(path: "inboundNatRules")
    lbr: get(path: "loadBalancingRules")
  }
}
```

### Template (Nunjucks)

```nunjucks
{% set badPorts = [80,21,25] %}{# editable array of ports to be blocked #}
{% set badPortFound = "False" %}
{%- for item in $.resource.natrules%}
  {% if item.backendPort in badPorts or item.frontendPort in badPorts%}
    {% set badPortFound = "True" %} 
  {% endif %}
{% endfor %}
{%- for item in $.resource.lbr%}
  {% if item.backendPort in badPorts or item.frontendPort in badPorts%}
    {% set badPortFound = "True" %} 
  {% endif %}
{% endfor %}
{% if badPortFound == "True" %} 
  "Not approved"
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
