# Simple tagging controls to check for adhernece to the tagging template example
# Tag template should be updated per your specific use case
# More Info: https://turbot.com/v5/docs/concepts/guardrails/tagging


# 
## Sets tagging policy for each resource type in the resource_tags map.
resource "turbot_policy_setting" "set_resource_tag_policies" {
  for_each = var.resource_tags
  resource = turbot_smart_folder.azure_tagging.id
  type     = local.policy_map[each.key]
  value    = each.value
}

## Sets the default tag template for all resources.
resource "turbot_policy_setting" "default_tag_template" {
  for_each = var.resource_tags
  resource = turbot_smart_folder.azure_tagging.id
  type     = local.policy_map_template[each.key]
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
  # Bring in environment metadata / attributes
  Name: "{{ $.resource.turbot.title }}"
  # Enforce selection of values, set to "Non-Compliant" if out of bounds
  Environment: "{% if $.resource.turbot.tags['Environment'] in ['Dev', 'QA', 'Prod', 'Temp'] %}{{ $.resource.turbot.tags['Environment'] }}{% else %}Non-Compliant Tag{% endif %}"
  # Actor who created the resource
  CreatedByActor: "{% if $.resource.creator.items[0].actor.identity.turbot.title == 'Unidentified Identity' %}{{ $.resource.creator.items[0].actor.alternatePersona }}{% else %}{{ $.resource.creator.items[0].actor.identity.turbot.title }}{% endif %}"
  # Creation Timestamp
  CreatedByTime: "{{ $.resource.creator.items[0].turbot.createTimestamp }}"
    TEMPLATE
}

## Missing Tag on folder use case:
##  {%- set missingTag = "__MissingTag__" -%}
#  {%- set required_tags = ${jsonencode([for tag_name in var.required_tags : tag_name])} -%}
#  # If Resource has a required tag, will accept the resource tag, else will tag with Folder tag value. 
#  {%- for tag_name in required_tags %}
#    {%- if tag_name in $.resource.turbot.tags %}
#  {{tag_name}}: "{{ $.resource.turbot.tags[tag_name] }}"
#    {%- elif tag_name in $.folder.turbot.tags %}
#  {{tag_name}}: "{{ $.folder.turbot.tags[tag_name] }}"
#    {%- else %}
#  {{tag_name}}: {{missingTag}}
#    {%- endif %}
#  {%- endfor %}

