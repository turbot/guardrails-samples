resource "turbot_smart_folder" "aws_cis_v300_s2_storage" {
  parent      = "tmod:@turbot/turbot#/"
  title       = "AWS CIS v3.0.0 - Section 2 - Storage"
  description = "This section contains recommendations for configuring AWS Storage."
}

# AWS > S3 > Enabled
resource "turbot_policy_setting" "aws_iam_enabled" {
  resource = turbot_smart_folder.aws_cis_v300_s2_storage.id
  type     = "tmod:@turbot/aws-s3#/policy/types/s3Enabled"
  value    = "Enabled"
}

# AWS > EC2 > Enabled
resource "turbot_policy_setting" "aws_ec2_enabled" {
  resource = turbot_smart_folder.aws_cis_v300_s2_storage.id
  type     = "tmod:@turbot/aws-ec2#/policy/types/ec2Enabled"
  value    = "Enabled"
}

# AWS > RDS > Enabled
resource "turbot_policy_setting" "aws_rds_enabled" {
  resource = turbot_smart_folder.aws_cis_v300_s2_storage.id
  type     = "tmod:@turbot/aws-ec2#/policy/types/rdsEnabled"
  value    = "Enabled"
}

# AWS > RDS > Enabled
resource "turbot_policy_setting" "aws_efs_enabled" {
  resource = turbot_smart_folder.aws_cis_v300_s2_storage.id
  type     = "tmod:@turbot/aws-efs#/policy/types/efsEnabled"
  value    = "Enabled"
}

