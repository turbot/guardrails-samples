# Policy Pack
resource "turbot_smart_folder" "pack" {
  title       = "Enforce Encryption at Rest is Enabled for AWS EFS File Systems"
  description = "Delete AWS EFS file systems that do not have encryption at rest enabled."
  parent      = "tmod:@turbot/turbot#/"
}

# AWS > EFS > Enabled
resource "turbot_policy_setting" "aws_efs_enabled" {
  resource = turbot_smart_folder.pack.id
  type     = "tmod:@turbot/aws-efs#/policy/types/efsEnabled"
  value    = "Enabled"
}
