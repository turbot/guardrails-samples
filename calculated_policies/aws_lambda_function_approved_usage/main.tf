terraform {
  required_providers {
    turbot = {
      source = "turbot/turbot"
    }
  }
  required_version = ">= 0.13"
}

# Smart Folder Definition
resource "turbot_smart_folder" "lambda_approved" {
  title       = var.smart_folder_title
  description = var.smart_folder_description
  parent      = var.smart_folder_parent_resource
}

# AWS > Lambda > Function > Approved
resource "turbot_policy_setting" "aws_lambda_function_approved" {
  resource = turbot_smart_folder.lambda_approved.id
  type     = "tmod:@turbot/aws-lambda#/policy/types/functionApproved"
  value    = "Check: Approved"
}

# AWS > Lambda > Function > Approved > Usage
resource "turbot_policy_setting" "aws_lambda_function_approved_usage" {
  resource = turbot_smart_folder.lambda_approved.id
  type     = "tmod:@turbot/aws-lambda#/policy/types/functionApprovedUsage"
  # GraphQL to get Lambda config info
  template_input = <<EOT
  {
    resource {
      data
      metadata
      trunk {
        title
      }
      turbot {
        akas
        id
        tags
      }
    }
  }
  EOT
  # Nunjucks Template Nunjucks Comments are formatted: {# comment #}
  template = <<EOT
  {% set current_time = now | date("constructor") | date("getTime") %}
  {% set lastmodified_time = $.resource.data.Configuration.LastModified | date("getTime") %}
  {% if "ApplicationID" not in $.resource.turbot.tags and duration > 300000 %}
  Not approved
  {% else %}
  Approved
  {% endif %}
  {% endif %}
  EOT
}
