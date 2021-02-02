# Smart Folder Definition
resource "turbot_smart_folder" "ec2_public_subnet" {
  title       = var.smart_folder_title
  description = var.smart_folder_description
  parent      = var.smart_folder_parent_resource
}

# AWS > EC2 > Instance > Approved
resource "turbot_policy_setting" "instance_approved" {
  resource = turbot_smart_folder.ec2_public_subnet.id
  type     = "tmod:@turbot/aws-ec2#/policy/types/instanceApproved"
  value    = "Check: Approved"
}

# AWS > EC2 > Instance > Approved > Usage
resource "turbot_policy_setting" "instance_subnet_" {
  resource = turbot_smart_folder.ec2_public_subnet.id
  type     = "tmod:@turbot/aws-ec2#/policy/types/instanceApprovedUsage"
  # GraphQL to pull instance tags
  template_input = <<EOT
  {
      resource {
          subnetId: get(path: "SubnetId")
      }
      resources(filter:"resourceType:'tmod:@turbot/aws-vpc-core#/resource/types/routeTable'") {
          items {
              associations: get(path: "Associations")
              routes: get(path: "Routes")
          }
      }
  }
  EOT

  # Nunjucks Template
  template = <<EOT
  {%- set regExp = r/^igw/g %}
  {%- set hasIGW = false -%}
  {%- for item in $.resources.items -%}
      {% for subnetid in item.associations %}
        {%- if subnetid.SubnetId == $.resource.subnetId -%}
            {%- for gateway in item.routes -%}
                {%- if regExp.test(gateway.GatewayId) -%}
                    {%- if hasIGW == false -%}
                        "Not approved"
                        {%- set hasIGW = true -%}
                    {%- endif -%}
                {%- endif -%}
            {%- endfor -%}
        {%- endif -%}
      {% endfor %}
  {%- endfor -%}
  {%- if hasIGW == false -%}
      "Approved if AWS > EC2 > Enabled"
  {%- endif -%}
  EOT
}
