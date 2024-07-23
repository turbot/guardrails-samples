# AWS > Turbot > Audit Trail
resource "turbot_policy_setting" "aws_turbot_audit_trail" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/aws#/policy/types/auditTrail"
  value    = "Check: Configured"
  # value    = "Enforce: Configured"
}

# AWS > Turbot > Audit Trail > CloudTrail > Trail > Enabled
resource "turbot_policy_setting" "aws_turbot_audit_trail_cloudtrail_trail_enabled" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/aws#/policy/types/trailEnabled"
  value    = "Enabled"
}

# AWS > Turbot > Audit Trail > CloudTrail > Trail > Global Region
resource "turbot_policy_setting" "aws_turbot_audit_trail_cloudtrail_trail_global_region" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/aws#/policy/types/trailGlobalRegion"
  # Region that will host the trail when configured to use a multi-region trail.
  value    = "us-east-1"
}

# AWS > Turbot > Audit Trail > CloudTrail > Trail > S3 Bucket
resource "turbot_policy_setting" "aws_turbot_audit_trail_cloudtrail_trail_s3_bucket" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/aws#/policy/types/trailBucket"
  # Your logging bucket name to which the trail will be delivered. Defaults to bucket name created via `AWS > Turbot > Logging > Bucket` control
  value    = "mybucket"
}
