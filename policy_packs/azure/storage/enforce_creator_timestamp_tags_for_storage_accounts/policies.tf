# Azure > Storage > Storage Account > Tags
resource "turbot_policy_setting" "azure_storage_storage_account_tags_detective" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/azure-storage#/policy/types/storageAccountTags"
  value    = "Check: Tags are correct"
  # value    = "Enforce: Set tags"
}

# Azure > Storage > Storage Account > Tags > Template
resource "turbot_policy_setting" "azure_storage_storage_account_tags_template_detective" {
  resource       = turbot_policy_pack.main.id
  type           = "tmod:@turbot/azure-storage#/policy/types/storageAccountTagsTemplate"
  template_input = <<-EOT
    {
      resource {
        turbot {
          title
          tags
        }
      creator: notifications(filter: "sort:version_id limit:1") {
          items {
            actor {
              alternatePersona
              identity {
                turbot {
                  title
                }
              }
            }
            turbot {
              createTimestamp
            }
          }
        }
      }
    }
    EOT
  template       = <<-EOT
    # Bring in environment metadata / attributes
    Name: "{{ $.resource.turbot.title }}"
    # Actor who created the resource
    Creator: "{% if $.resource.creator.items[0].actor.identity.turbot.title == 'Unidentified Identity' %}{{ $.resource.creator.items[0].actor.alternatePersona }}{% else %}{{ $.resource.creator.items[0].actor.identity.turbot.title }}{% endif %}"
    # Creation Timestamp
    Createtimestamp: "{{ $.resource.creator.items[0].turbot.createTimestamp }}"
    EOT
}
