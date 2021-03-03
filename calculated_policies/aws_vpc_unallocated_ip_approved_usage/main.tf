terraform {
  required_providers {
    turbot = {
      source = "turbot/turbot"
    }
  }
  required_version = ">= 0.13"
}

# Smart Folder Definition
resource "turbot_smart_folder" "aws_vpc_elastic_ip" {
  title       = var.smart_folder_title
  description = var.smart_folder_description
  parent      = var.smart_folder_parent_resource
}

# AWS > Lambda > Function > Approved
resource "turbot_policy_setting" "awx_vpc_elastic_ip_approved" {
  resource = turbot_smart_folder.aws_vpc_elastic_ip.id
  type     = "tmod:@turbot/aws-vpc-internet#/policy/types/elasticIpApproved"
  value    = "Check: Approved"
}

# AWS > Lambda > Function > Approved > Usage
resource "turbot_policy_setting" "awx_vpc_elastic_ip_approved_usage" {
  resource = turbot_smart_folder.aws_vpc_elastic_ip.id
  type     = "tmod:@turbot/aws-vpc-internet#/policy/types/elasticIpApprovedUsage"
  # GraphQL to pull function metadata
  template_input = <<EOT
  {
    resources {
      metadata {
        stats {
          total
        }
      }
      items {
        PublicIp: get(path: "PublicIp")
        AllocationId: get(path: "AllocationId")
        AssociationId: get(path: "AssociationId")
        turbot {
          akas
        }
      }
    }
  }
  EOT
  # Nunjucks Template Nunjucks Comments are formatted: {# comment #}
  template = <<EOT
  {% set has_cross_account = false -%}
  {% if $.AssociationId == null %}
  'Not approved'
  {% else %}
  'Approved'
  {% endif %}
  EOT
}