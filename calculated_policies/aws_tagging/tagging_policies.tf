## Description:  Enforce default tag template and tag controls for all resource types
## NOTE: This Terraform plan WILL ENFORCE TAGGING TEMPLATES! Ensure that either the value is set to "Check"
## or that each service has been vetted to ensure that no unintentional resource tagging occurs.

## Sets tagging policy for each resource type in the resource_tags map.
resource "turbot_policy_setting" "set_resource_tag_policies" {
  count           = length(var.resource_tags)
  resource        = turbot_smart_folder.aws_tagging.id
  type            = var.policy_map[element(keys(var.resource_tags), count.index)]
  value           = element(values(var.resource_tags), count.index)
}

## Sets the default tag template for all resources.
resource "turbot_policy_setting" "default_tag_template" {
  resource        = turbot_smart_folder.aws_tagging.id
  type            = "tmod:@turbot/aws#/policy/types/defaultTagsTemplate"
  # GraphQL to pull policy Statements
  template_input  = <<-QUERY
    {
        resource {
            tags
        }
        folder {
            turbot {
                tags
            }
        }
    }
    QUERY

  # Nunjucks template to set tags and check for tag validity.
  template        = <<TEMPLATE
{#- Set default value for non-existant and incorrect tags -#}
{#- #################################################### -#} 
{%- set missingTag = "__MissingTag__" -%}
{#- Set regex for valid email -#} 
{#- ######################### -#} 
{%- set regExp = r/(^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$)/ %}
{#- Check for required tags -#} 
{#- ####################### -#} 
{#- Check that owner tag exists and is valid -#} 
{#- ######################################## -#} 
{%- if $.resource.tags['owner'] -%}
  {%- if regExp.test($.resource.tags['owner']) -%}
    - owner: {{$.resource.tags['owner']}}
  {%- else -%}
    - owner: InvalidTagValue __{{$.resource.tags['owner']}}__
  {%- endif %}
{% else -%}
  {%- if $.folder.turbot.tags['owner'] -%}
    - owner: {{$.folder.turbot.tags['owner']}}
  {% else -%}
    - owner: {{missingTag}}
  {%- endif %}
{% endif -%}
{#- Check that environment tag exists and is valid -#} 
{#- ######################################## -#} 
{%- set acceptableValues = ['dev', 'test', 'prod'] -%}
{%- if $.resource.tags['environment'] -%}
  {%- if $.resource.tags['environment'] in acceptableValues -%}
    - environment: {{$.resource.tags['environment']}}
  {%- else -%}
    - environment: InvalidTagValue __{{$.resource.tags['environment']}}__
  {%- endif %}
{% else -%}
  {%- if $.folder.turbot.tags['environment'] -%}
    - environment: {{$.folder.turbot.tags['environment']}}
  {% else -%}
    - environment: {{missingTag}}
  {%- endif %}
{% endif -%}
{#- Check that costcenter tag exists -#} 
{#- ######################################## -#} 
{%- if $.resource.tags['costcenter'] -%}
    - costcenter: {{$.resource.tags['costcenter']}}
{% else -%}
  {%- if $.folder.turbot.tags['costcenter'] -%}
    - costcenter: {{$.folder.turbot.tags['costcenter']}}
  {% else -%}
    - costcenter: {{missingTag}}
  {%- endif %}
{% endif -%}
TEMPLATE
} 