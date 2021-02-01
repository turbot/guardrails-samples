#### TODO: This section could be behind a variable
# Using a calculated policy here as an example for getting started with calculated policies
# Shows an example of setting different Checks based on naming syntax and tag key:value pair
# AWS > S3 > Bucket > Versioning
# https://turbot.com/v5/mods/turbot/aws-s3/inspect#/policy/types/bucketVersioning
resource "turbot_policy_setting" "aws_s3_bucket_versioning" {
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

#### TODO: This section could be behind a variable
# Simple Policy setting for Bucket Versioning, using the Calculated Policy below as an example for a calc policy
# AWS > S3 > Bucket > Versioning
# https://turbot.com/v5/mods/turbot/aws-s3/inspect#/policy/types/bucketVersioning
# resource "turbot_policy_setting" "aws_s3_bucket_versioning_simple" {
#   resource = turbot_smart_folder.aws_all_s3.id
#   type     = "tmod:@turbot/aws-s3#/policy/types/bucketVersioning"
#   value    = "Check: Enabled"
#         # "Skip"
#         # "Check: Disabled"
#         # "Check: Enabled"
#         # "Enforce: Disabled"
#         # "Enforce: Enabled"
# }
