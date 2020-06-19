# AWS EC2 - Instance Not Approved if Public Subnet

## Use case

There is an organizational requirement that in specific accounts, no EC2 instance can be booted within a subnet with 
an associated route table which has routes pointing to an Internet Gateway (IGW).

## Implementation Details

This Terraform template creates a smart folder and applies calculated policies on the policies:

- `AWS > EC2 > Instance > Approved`
- `AWS > EC2 > Instance > Approved > Usage`

Approval policy that restrict usage of EC Instances if the Subnet associated with the Instance has a Route to an IGW.

### Template Input (GraphQL)

The template input to a calculated policy is a GraphQL query.

This query is two-fold. First, it finds the subnet ID contained within the EC2 instance metadata. 
Second, all route tables in the account are found, and the associated subnet ID as well as the collection of routes.

```graphql
{
  resource {
    subnetId: get(path: "SubnetId")
  }
  resources(filter:"resourceType:'tmod:@turbot/aws-vpc-core#/resource/types/routeTable'") {
    items {
      associations: get(path: "Associations.[0].SubnetId")
      routes: get(path: "Routes")
    }
  }
}
```

### Template (Nunjucks)

Checks each returned Route Table entry and compares it against the Subnet Id of the EC2 Instance. 
When the Route Table entry is found then check each Route to find the Route with the id of `igw`.
If a Route with this id is found then the usage will be set as `Not approved`.

```nunjucks
{%- set hasIGW = false -%}
{%- for item in $.resources.items -%}
  {%- if item.associations == $.resource.subnetId -%}
    {%- for gateway in item.routes -%}
      {%- if 'igw' in gateway.GatewayId -%}
        {%- if hasIGW == false -%}
          "Not approved"
          {%- set hasIGW = true -%}
        {%- endif -%}
      {%- endif -%}
    {%- endfor -%}
  {%- endif -%}
{%- endfor -%}
{%- if hasIGW == false -%}
  "Approved if AWS > EC2 > Enabled"
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
