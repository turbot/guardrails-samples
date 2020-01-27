resource "turbot_smart_folder" "prod_s3_versioning" {
  title         = var.smart_folder_title
  description   = "Enables bucket versioning for all buckets tagged with {Environment:=Prod}"
  parent        = "tmod:@turbot/turbot#/"
}

resource "turbot_policy_setting" "s3_bucket_versioning" {
  resource   = turbot_smart_folder.prod_s3_versioning.id
  type       = "tmod:@turbot/aws-s3#/policy/types/bucketVersioning"
  # GraphQL to pull resource tags
  template_input = <<EOT
    { 
        resource {
            tags
        }
    }
  EOT
  # Nun
  template      = <<EOT
    {% if $.resource.tags.data-classification == "temp" %}
    "Enforce: Disabled"
    {% else %}
    "Enforce: Enabled"
    {% endif %}
  EOT
}