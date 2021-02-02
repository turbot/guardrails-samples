# Simple labeling/tagging controls to check for adhernece to the tagging template example
# Tag template should be updated per your specific use case
# More Info: https://turbot.com/v5/docs/concepts/guardrails/tagging

## Sets tagging policy for each resource type in the resource_tags map.
resource "turbot_policy_setting" "set_resource_tag_policies" {
  for_each = var.resource_tags
  resource = turbot_smart_folder.gcp_labeling.id
  type     = var.policy_map[each.key]
  value    = each.value
}

## Sets the default tag template for all resources.
resource "turbot_policy_setting" "default_tag_template" {
  for_each = var.resource_tags
  resource = turbot_smart_folder.gcp_labeling.id
  type     = var.policy_map_template[each.key]
  # GraphQL to pull metadata
  template_input = <<-QUERY
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
    QUERY

  # Nunjucks template to set tags and check for tag validity.
  template = <<-TEMPLATE
# Actor who created the resource
{%- set owner = $.resource.creator.items[0].actor.identity.turbot.title -%}
created_by: "{{ owner | lower | replace(" ", "_") }}"

# Creation Timestamp
{%- set create_time = $.resource.creator.items[0].turbot.createTimestamp -%}
created_time: "{{ create_time | lower | replace(".", "_") | replace(":", "-") }}"
    TEMPLATE
}