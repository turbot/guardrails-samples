# Approved Guardrails
#   https://turbot.com/v5/docs/concepts/guardrails/approved

# Simple policy to check if S3 is Approved for Usage -- can adjust for testing per bucket
# Will inherit the Approved Regions list if using the Approved Regions baseline or can keep the Regions setting below.

# AWS > S3 > Bucket > Approved
# https://turbot.com/v5/mods/turbot/aws-s3/inspect#/policy/types/bucketApproved
resource "turbot_policy_setting" "aws_s3_bucket_approved" {
  count    = var.enable_s3_approved_policies ? 1 : 0
  resource = turbot_smart_folder.aws_all_s3.id
  type     = "tmod:@turbot/aws-s3#/policy/types/bucketApproved"
  value    = "Check: Approved"
}

# AWS > S3 > Bucket > Approved > Usage
# https://turbot.com/v5/mods/turbot/aws-s3/inspect#/policy/types/bucketApprovedUsage
resource "turbot_policy_setting" "aws_s3_bucket_approved_usage" {
  count    = var.enable_s3_approved_policies ? 1 : 0
  resource = turbot_smart_folder.aws_all_s3.id
  type     = "tmod:@turbot/aws-s3#/policy/types/bucketApprovedUsage"
  value    = "Approved"
}

# AWS > S3 > Bucket > Approved > Regions
# https://turbot.com/v5/mods/turbot/aws-s3/inspect#/policy/types/bucketApprovedRegions
resource "turbot_policy_setting" "aws_s3_bucket_approved_regions" {
  count    = var.enable_s3_approved_policies ? 1 : 0
  resource = turbot_smart_folder.aws_all_s3.id
  type     = "tmod:@turbot/aws-s3#/policy/types/bucketApprovedRegions"
  value    = <<EOT
    - us*
  EOT
}
