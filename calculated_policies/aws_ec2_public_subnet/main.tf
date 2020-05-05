resource "turbot_smart_folder" "ec2_public_subnet" {
  title         = var.smart_folder_title
  description   = "Set any instance to 'Not Approved' if the instance is in a public subnet"
  parent        = "tmod:@turbot/turbot#/"
}

resource "turbot_policy_setting" "instance_approved" {
  resource   = turbot_smart_folder.ec2_public_subnet.id
  type       = "tmod:@turbot/aws-ec2#/policy/types/instanceApproved"
  value      = "Check: Approved"
}

resource "turbot_policy_setting" "instance_subnet_" {
  resource   = turbot_smart_folder.ec2_public_subnet.id
  type       = "tmod:@turbot/aws-ec2#/policy/types/instanceApprovedUsage"
  # GraphQL to pull instance tags
  template_input = <<EOT
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
  EOT
  
  # Nunjucks Template
  template      = <<EOT
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
  EOT
}