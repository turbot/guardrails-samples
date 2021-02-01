# Active Guardrails - https://turbot.com/v5/docs/concepts/guardrails/active

# AWS > S3 > Bucket > Active
# https://turbot.com/v5/mods/turbot/aws-s3/inspect#/policy/types/bucketActive
resource "turbot_policy_setting" "aws_s3_bucket_active" {
  count    = var.enable_s3_active_policies ? 1 : 0
  resource = turbot_smart_folder.aws_all_s3.id
  type     = "tmod:@turbot/aws-s3#/policy/types/bucketActive"
  value    = "Check: Active"
}

# AWS > S3 > Bucket > Active > Age
# https://turbot.com/v5/mods/turbot/aws-s3/inspect#/policy/types/bucketActiveAge
resource "turbot_policy_setting" "aws_s3_bucket_active_age" {
  count    = var.enable_s3_active_policies ? 1 : 0
  resource = turbot_smart_folder.aws_all_s3.id
  type     = "tmod:@turbot/aws-s3#/policy/types/bucketActiveAge"
  value    = "Force inactive if age > 60 days"
}
