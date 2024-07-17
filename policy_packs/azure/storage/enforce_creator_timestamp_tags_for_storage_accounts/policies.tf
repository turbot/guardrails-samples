# Azure > Storage > Storage Account > Tags
resource "turbot_policy_setting" "azure_storage_storage_account_tags" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/azure-storage#/policy/types/storageAccountTags"
  value    = "Check: Tags are correct"
  # value    = "Enforce: Set tags"
}

# Azure > Storage > Storage Account > Tags > Template
resource "turbot_policy_setting" "azure_storage_storage_account_tags_template" {
  resource       = turbot_policy_pack.main.id
  type           = "tmod:@turbot/azure-storage#/policy/types/storageAccountTagsTemplate"
  template_input = <<-EOT
    {
      item: storageAccount {
        metadata
        name
      }
    }
    EOT
  template       = <<-EOT
    {%- set metadata = $.item.metadata -%}

    {%- if metadata -%}
      # Actor who created the resource and creation timestamp
      Creator: "{{ metadata.createdBy }}"
      Createtimestamp: "{{ metadata.createTimestamp }}"
    {%- endif -%}

    EOT
}
