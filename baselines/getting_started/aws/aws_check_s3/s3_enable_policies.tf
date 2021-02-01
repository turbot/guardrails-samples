# AWS > S3 > Enabled
# https://turbot.com/v5/mods/turbot/aws-s3/inspect#/policy/types/s3Enabled
resource "turbot_policy_setting" "aws_s3_s3_enabled" {
  count    = var.enable_s3_enabled_policies ? 1 : 0
  resource = turbot_smart_folder.aws_all_s3.id
  type     = "tmod:@turbot/aws-s3#/policy/types/s3Enabled"
  value    = "Enabled"
}

# AWS > S3 > API Enabled
# https://turbot.com/v5/mods/turbot/aws-s3/inspect#/policy/types/s3ApiEnabled
resource "turbot_policy_setting" "aws_s3_s3_api_enabled" {
  count    = var.enable_s3_enabled_policies ? 1 : 0
  resource = turbot_smart_folder.aws_all_s3.id
  type     = "tmod:@turbot/aws-s3#/policy/types/s3ApiEnabled"
  value    = "Enabled"
}
