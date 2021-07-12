resource "turbot_policy_setting" "s3_tags" {
  resource = turbot_smart_folder.s3_tagging_template.id
  type     = "tmod:@turbot/aws-s3#/policy/types/bucketTags"
  value    = "Check: Tags are correct"
}

# AWS > Region > Bucket > Tags > Template
resource "turbot_policy_setting" "s3_tag_template" {
  resource = turbot_smart_folder.s3_tagging_template.id
  type     = "tmod:@turbot/aws-s3#/policy/types/bucketTagsTemplate"
  # GraphQL to pull bucket metadata
  template_input = <<EOT
  {
    resource {
      turbot {
        tags
      }
    }
  EOT
  # Nunjucks Template Nunjucks Comments are formatted: {# comment #}
  template = <<EOT
  {%- set approved = 'no' -%}

  {%- for key,value in $.resource.turbot.tags -%}
    {%- if r/owners/.test(key | lower) -%}
      {%- if r/john doe/.test(value | lower) %}
        {%- set approved = 'yes' -%}
          {%- endif %}
    {%- endif -%}
  {%- endfor -%}

  {%- if approved == 'no' -%}
  - owner: 'Missing_tag'
  {%- else -%}
  []
  {%- endif -%}
  EOT
}
