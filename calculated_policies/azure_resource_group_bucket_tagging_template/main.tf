# Smart Folder Definition
resource "turbot_smart_folder" "azure_resource_group_tagging_template" {
  title       = var.smart_folder_title
  description = var.smart_folder_description
  parent      = var.smart_folder_parent_resource
}

# Azure > Resource Group > Tags > Template
resource "turbot_policy_setting" "azure_resource_group_tagging_template" {
  resource = turbot_smart_folder.azure_resource_group_tagging_template.id
  type     = "tmod:@turbot/azure#/policy/types/resourceGroupTagsTemplate"
  # GraphQL to pull bucket metadata
  template_input = <<EOT
  {
    resource {
      tags
    }
  }
  EOT
  # Nunjucks Template Nunjucks Comments are formatted: {# comment #}
  template = <<EOT
  "${var.tag_key}": "{% if $.resource.tags['${var.tag_key}'] %}{{ $.resource.tags['${var.tag_key}'] }}{% else %}${var.tag_default_value}{% endif %}"
  EOT
}

# Attach Smart Folder
resource "turbot_smart_folder_attachment" "azure_resource_group_tagging_template" {
  resource     = var.target_resource
  smart_folder = turbot_smart_folder.azure_resource_group_tagging_template.id
}
