# AWS EC2 - Restrict Instance images to trusted AWS accounts AMIs

## Use case

Organizations often require restrictions surrounding default security groups within a VPC, especially now that default security groups cannot be deleted. Customers
often also like to restrict ingress rules on all security groups to specific CIDR ranges.

## Implementation Details

This Terraform template creates a smart folder and the following calculated policies:

- `AWS > VPC > Security Group > Ingress Rules > Approved`
- `AWS > VPC > Security Group > Ingress Rules > Approved > CIDR Ranges`
- `AWS > VPC > Security Group > Ingress Rules > Approved > Rules`
- `AWS > VPC > Security Group > Egress Rules > Approved > Rules`



### Template Input (GraphQL)

In this situation, there are multiple calculated policies being created. As such, there are multiple GraphQL queries.

`AWS > VPC > Security Group > Ingress Rules > Approved > Rules`
```graphql
{   
  resource {
    name: get(path: "GroupName")
  }
}
```

`AWS > VPC > Security Group > Egress Rules > Approved > Rules`
```graphql
{   
  resource {
    name: get(path: "GroupName")
  }
}
```

### Template (Nunjucks)

Similarly to the GraphQL queries, there will be two Nunjuck templates across Ingress and Egress rule policies.

`AWS > VPC > Security Group > Ingress Rules > Approved > Rules`
```nunjucks
{%- if $.resource.name == "default" -%}
  REJECT *
{%- else -%}
  APPROVE *
{%- endif -%}
```

`AWS > VPC > Security Group > Egress Rules > Approved > Rules`
```nunjucks
{%- if $.resource.name == "default" -%}
  REJECT *
{%- else -%}
  APPROVE *
{%- endif -%}
```

The template itself is a [Nunjucks formatted template](https://mozilla.github.io/nunjucks/templating.html).

## Prerequisites

To run Turbot Calculated Policies, you must install:

- [Terraform](https://www.terraform.io) Version 12
- [Turbot Terraform Provider](https://turbot.com/v5/docs/reference/terraform/provider)
- [Configured credentials](https://turbot.com/v5/docs/reference/cli/installation) to connect to your Turbot workspace

### Configuring Credentials

You must set your `config.tf` or environment variables to connect to your Turbot workspace.
Further information can be found in the Turbot Terraform Provider [Installation Instructions](https://turbot.com/v5/docs/reference/terraform/provider).

## Running the Example

Scripts can be run in the folder that contains the script.

### Configure the script

Update [default.tfvars](default.tfvars) or create a new Terraform configuration file.

Variables that are exposed by this script are:

- smart_folder_title
- target_resource
- approved_account_ami_list

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
