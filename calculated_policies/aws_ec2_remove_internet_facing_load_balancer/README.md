# AWS EC2 - Instance Not Approved if Public Subnet

## Use case

There is an organizational requirement that in specific accounts, no EC2 Load Balancer can exist as `internet-facing`. 

## Implementation details

This Terraform template creates a smart folder and applies the following calculated policies:

- `AWS > EC2 > Application Load Balancer > Approved`
- `AWS > EC2 > Application Load Balancer > Approved > Usage`

- `AWS > EC2 > Classic Load Balancer > Approved`
- `AWS > EC2 > Classic Load Balancer > Approved > Usage`

- `AWS > EC2 > Network Load Balancer > Approved`
- `AWS > EC2 > Network Load Balancer > Approved > Usage`

First, Turbot checks the load balancer to see if it is internet facing, and if it is, an alarm is generated.

### Template input (GraphQL)

The template input to a calculated policy is a GraphQL query.

Each type of Load Balancer will have a slightly different query:

Application Load Balancer:
```graphql
{
  classicLoadBalancer{
    Scheme
  }
}
```

Classic Load Balancer:
```graphql
{
  applicationLoadBalancer{
    Scheme
  }
}
```

Network Load Balancer:
```graphql
{
  networkLoadBalancer{
    Scheme
  }
}
```

Notice the difference is only the resource name that is initializes the request.

### Template (Nunjucks)

Similar to the query, each Load Balancer type will have a slighly different calculated policy, but in each case Turbot checks the `Scheme` attribute, and if that attribute is defined as `internet-facing`, the Load Balancer is not approved.
Below is the query for the Network Load Balancer. Simply swap the `networkLoadBalancer` with either `classicLoadBalancer` or `applicationLoadBalancer` for remaining two LB types.

```nunjucks
{%- if $.networkLoadBalancer.Scheme == "internet-facing" -%}
"Not approved"
{%- else -%}
"Approved"
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
