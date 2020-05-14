# Smart folder which will contain the S3 tag policies
resource "turbot_smart_folder" "calc_policy_smart_folder" {
  title       = var.smart_folder_title
  description = "Calc Policy - Copy ECS tags to S3 bucket"
  parent      = var.smart_folder_parent
}

# Set the tag policy for buckets to enforce setting tags
resource "turbot_policy_setting" "s3_bucketTags" {
  resource = turbot_smart_folder.calc_policy_smart_folder.id
  type     = "tmod:@turbot/aws-s3#/policy/types/bucketTags"
  value    = "Enforce: Set tags"
}

# Set the template policy for buckets that will copy EC2 tags if S3 bucket is managed by EC2 instance
resource "turbot_policy_setting" "s3_bucketTagsTemplate" {
  resource = turbot_smart_folder.calc_policy_smart_folder.id
  type     = "tmod:@turbot/aws-s3#/policy/types/bucketTagsTemplate"

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
