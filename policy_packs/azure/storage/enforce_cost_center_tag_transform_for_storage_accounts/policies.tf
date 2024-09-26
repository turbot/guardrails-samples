locals {
  yaml_string = <<-EOT
    Cost_Center:
      incorrectKeys:
        - /.*cost.*cent.*/gi
      replacementValue: undefined
    EOT
}

# Turbot > File
resource "turbot_file" "azure_tag_transform_rules" {
  parent  = "tmod:@turbot/turbot#/"
  title   = "Azure Tag Transform Rules"
  akas    = ["azure_tag_transform_rules"]
  content = jsonencode(yamldecode(local.yaml_string))
}

# Azure > Storage > Storage Account > Tags
resource "turbot_policy_setting" "azure_storage_storage_account_tags" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/azure-storage#/policy/types/storageAccountTags"
  value    = "Check: Tags are correct"
  # value    = "Enforce: Set tags"
}

# Azure > Storage > Storage Account > Tags > Template
resource "turbot_policy_setting" "azure_storage_account_tags_template" {
  resource       = turbot_policy_pack.main.id
  type           = "tmod:@turbot/azure-storage#/policy/types/storageAccountTagsTemplate"
  template_input = <<-EOT
    {
      rules: resource(id:"tag_transform_rules") {
        data
      }
      resource {
        turbot {
          tags
        }
      }
    }
    EOT
  template       = <<-EOT
    {%- set tags_map = $.resource.turbot.tags -%}
    {%- set rules = $.rules.data -%}

    {% for key,value in transformMap(tags_map, rules) -%}
    - "{{key}}": "{{value}}"
    {% endfor -%}

    EOT
}
