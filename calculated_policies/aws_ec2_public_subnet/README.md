# AWS EC2 Instance Not Approved if Public Subnet

## User Story

There is an organizational requirement that in specific accounts, no EC2 instance can be booted within a subnet with an associated route table which has routes pointing to an Internet Gateway (IGW).

## Implementation Details

This script provides a Terraform configuration for creating a smart folder and applying a calculated policy using `AWS > EC2 > Instance > Approved > Usage` policy, and then setting `AWS > EC2 > Instance > Approved` to check. T

### Template Input (GraphQL)

The template input to a calculated policy is a GraphQL query.  This query is two-fold. First, it finds the subnet ID contained within the EC2 instance metadata. Second, all route tables in the account are found, and the associated subnet ID as well as the collection of routes :
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

The template itself is a [Nunjucks formatted template](https://mozilla.github.io/nunjucks/templating.html) with custom logic:
```js
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

## Pre-requisites

To create the smart folder, you must have:
- [Terraform](https://www.terraform.io) Version 12
- [Turbot Terraform Provider](https://github.com/turbotio/terraform-provider-turbot)
- Credentials Configured to connect to your Turbot workspace

## Running the Example

To run the template:
1. Navigate to the directory on the command line `cd aws_ec2_public_subnet`
2. Run `terraform plan -var-file="default.tfvars"` and review the changes to be applied
3. Run `terraform apply -var-file="default.tfvars"` to execute and apply the policy settings

The template will run using the default values defined [default.tfvars](default.tfvars)
