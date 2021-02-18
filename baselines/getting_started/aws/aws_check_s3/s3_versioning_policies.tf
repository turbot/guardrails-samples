# Simple Policy setting for bucket versioning. 

# This is the default version policy that will be created when applying the Terraform configuration as
# use_simple_s3_bucket_versioning defaults to true.

# AWS > S3 > Bucket > Versioning
# https://turbot.com/v5/mods/turbot/aws-s3/inspect#/policy/types/bucketVersioning
resource "turbot_policy_setting" "aws_s3_bucket_versioning_simple" {
  count    = var.use_simple_s3_bucket_versioning ? 1 : 0
  resource = turbot_smart_folder.aws_all_s3.id
  type     = "tmod:@turbot/aws-s3#/policy/types/bucketVersioning"
  value    = "Check: Enabled"
}

# Using a calculated policy here as an example for getting started with calculated policies
# Shows an example of setting different checks based on naming syntax and tag key:value pair

# To enable this policy set the variable use_simple_s3_bucket_versioning to false which will not apply the simple
# versioning version.

# AWS > S3 > Bucket > Versioning
# https://turbot.com/v5/mods/turbot/aws-s3/inspect#/policy/types/bucketVersioning
resource "turbot_policy_setting" "aws_s3_bucket_versioning" {
  count          = var.use_simple_s3_bucket_versioning ? 1 : 0
  resource       = turbot_smart_folder.aws_all_s3.id
  type           = "tmod:@turbot/aws-s3#/policy/types/bucketVersioning"
  template_input = <<-QUERY
    {
      bucket {
        Name
        turbot {
          tags
        }
      }
    }
  QUERY

  # Nunjucks template evaluate metadata.
  template = <<-TEMPLATE
    {%- set result = "Check: Enabled" -%}
    {%- set regExp = r/turbot-demo.*/g -%}

    {%- if regExp.test($.bucket.Name) or $.bucket.turbot.tags.Test == "Temp"-%}
      {%- set result = "Check: Disabled" -%}
    {%- endif -%}
    
    {{ result }}
  TEMPLATE
}
