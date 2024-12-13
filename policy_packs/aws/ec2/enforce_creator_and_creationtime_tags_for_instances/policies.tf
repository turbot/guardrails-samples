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
