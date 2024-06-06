# Policy Pack
resource "turbot_smart_folder" "pack" {
  title       = "Detect if encryption at rest is enabled for EFS file system"
  description = "Detect if encryption at rest is enabled for EFS file system"
  parent      = "tmod:@turbot/turbot#/"
}

# AWS > EFS > Enabled
resource "turbot_policy_setting" "aws_efs_enabled" {
  resource = turbot_smart_folder.pack.id
  type     = "tmod:@turbot/aws-efs#/policy/types/efsEnabled"
  value    = "Enabled"
}
