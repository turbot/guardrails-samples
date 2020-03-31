resource "turbot_smart_folder" "s3_lower_case_tags" {
  title          = var.smart_folder_title
  description    = "Checks all bucket tags and converts to lower case if applicable."
  parent         = "tmod:@turbot/turbot#/"
}

resource "turbot_policy_setting" "s3_tag_template" {
  resource       = "turbot_smart_folder.s3_lower_case_tags.id"
  type           = "tmod:@turbot/aws-s3#/policy/types/bucketTagsTemplate"
  # GraphQL to pull bucket metadata
  template_input = <<EOT
  {
    bucket{
      turbot {
        tags
      }
    }
  }
  EOT
  # Nunjucks Template Nunjucks Comments are formatted: {# comment #}
  template       = <<EOT
  {%- set keys = [] %}
  {%- for k,v in $.bucket.turbot.tags %}
    {%- set ignore = keys.push(k) %}
  {%- endfor %}
  {%- set ignore = keys.sort() %}
  {%- set set_keys = [] %}
  {%- for k in keys %}
    {%- set lower_k = k | lower %}
    {%- set lower_v = $.bucket.turbot.tags[k] | lower %}
    {%- if k == lower_k %}
      {%- if lower_v != $.bucket.turbot.tags[k] %}
        "{{lower_k}}": "{{lower_v}}"
        {%- set ignore = set_keys.push(lower_k) %}
      {%- endif %}
    {%- else %}
      "{{k}}": null
      {%- if not set_keys.includes(lower_k) %}
        "{{lower_k}}": "{{lower_v}}"
      {%- endif %}
      {%- set ignore = set_keys.push(lower_k) %}
    {%- endif %}
  {%- endfor %}
  {%- if not set_keys | length %}
    {}
  {%- endif %}
  EOT
}