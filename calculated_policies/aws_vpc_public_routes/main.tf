# Smart Folder Definition
resource "turbot_smart_folder" "aws_vpc_public_route_check" {
  title       = var.smart_folder_title
  description = var.smart_folder_description
  parent      = var.smart_folder_parent_resource
}

# Calculated policy to check route tables for public routes
resource "turbot_policy_setting" "vpc_route_table_approved_usage"{
  resource = turbot_smart_folder.aws_vpc_public_route_check.id
  type = "tmod:@turbot/aws-vpc-core#/policy/types/routeTableApprovedUsage"
  template_input = <<EOT
{
  routeTable{
    Routes{
      DestinationCidrBlock
      GatewayId
    }
  }
}
  EOT
  template      = <<EOT
{%- set cidrMatches = false -%}
{%- for cidr in $.routeTable.Routes -%}
{%- if cidr.DestinationCidrBlock == "0.0.0.0/0" -%}
{%- set cidrMatches = true -%}
{%- endif -%}
{%- endfor -%}

{%- set igwMatches = false -%}
{%- for igw in $.routeTable.Routes -%}
{%- if igw.GatewayId.startsWith("igw") -%}
{%- set igwMatches = true -%}
{%- endif -%}
{%- endfor -%}

{%- if cidrMatches and igwMatches -%}
"Not approved"
{%- else -%}
"Approved"
{%- endif -%}
EOT
}

# Approval policy. Default setting is `Check: Approved`. The value `Enforce: Delete unapproved if new` can be set to enforce no public routes.
resource "turbot_policy_setting" "vpc_route_table_approved"{
  resource = turbot_smart_folder.aws_vpc_public_route_check.id
  type = "tmod:@turbot/aws-vpc-core#/policy/types/routeTableApproved"
  value = "Check: Approved"
  #value = "Enforce: Delete unapproved if new"
}