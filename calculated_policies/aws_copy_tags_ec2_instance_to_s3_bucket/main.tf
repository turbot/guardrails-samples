resource "turbot_smart_folder" "s3_tags" {
  title       = var.smart_folder_title
  description = "Enables bucket to over ride tags from ec2 instance"
  parent      = "tmod:@turbot/turbot#/"
}

resource "turbot_policy_setting" "s3_bucketTags" {
  resource = turbot_smart_folder.s3_tags.id
  type     = "tmod:@turbot/aws-s3#/policy/types/bucketTags"
  value    = "Enforce: Set tags"
}

resource "turbot_policy_setting" "s3_bucketTagsTemplate" {
  resource = turbot_smart_folder.s3_tags.id
  type     = "tmod:@turbot/aws-s3#/policy/types/bucketTagsTemplate"
  # GraphQL to pull instance tags
  template_input = <<EOT
{
  resource(id: 190397275456727) {
    tags
  }
}
  EOT

  # Nunjucks Template
  template = <<EOT
{%- if $.resource.tags | length == 0 %}
[] 
{%- elif $.resource.tags != undefined %}
{{ $.resource.tags | dump | safe }}
{%- else %}
{% for item in $.resource.tags %}
- {{ item }}
{% endfor %}
{% endif %}
  EOT
}
