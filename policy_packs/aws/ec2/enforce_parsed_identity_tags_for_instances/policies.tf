# AWS > EC2 > Instance > Tags
resource "turbot_policy_setting" "aws_ec2_instance_tags" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/aws-ec2#/policy/types/instanceTags"
  value    = "Check: Tags are correct"
  # value    = "Enforce: Set tags"
}

# AWS > EC2 > Instance > Tags > Template
resource "turbot_policy_setting" "aws_ec2_instance_tags_template" {
  resource       = turbot_policy_pack.main.id
  type           = "tmod:@turbot/aws-ec2#/policy/types/instanceTagsTemplate"
  template_input = <<-EOT
    {
      resource {
        metadata
      }
    }
    EOT
  template       = <<-EOT
    {% set tags_plan = {} -%}
    {%- if $.resource.metadata.createdBy -%}
      {%- set creator_arn = $.resource.metadata.createdBy -%}
      {%- if "assumed-role" in creator_arn -%}
        {# split arn into parts #}
        {%- set user_id = creator_arn.split('/') | last -%}
        {%- if "turbot.directory" in user_id -%}
          {# remove 'turbot.directory' string if present #}
          {%- set user_id = (user_id | replace("turbot.directory", ""))-%}
          {# remove trailing hash value to cleanup #}
          {%- set user_id = user_id.split("-") | first -%}
        {%- endif -%}
        {%- set tags_plan = setAttribute(tags_plan, "owner", user_id) -%}
      {%- endif -%}
      {%- set tags_plan = setAttribute(tags_plan, "creator", $.resource.metadata.createdBy) -%}
    {%- endif -%}

    {%- if $.resource.metadata.createTimestamp -%}
      {%- set tags_plan = setAttribute(tags_plan, "creationTime", $.resource.metadata.createTimestamp.split('T')[0]) -%}
    {%- endif -%}

    {%- if tags_plan | length < 1 -%}
      []
    {%- else -%}
      {{ tags_plan | json }}
    {%- endif -%}
    EOT
}
