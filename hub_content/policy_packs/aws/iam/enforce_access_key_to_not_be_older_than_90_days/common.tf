# Policy Pack
resource "turbot_smart_folder" "pack" {
  title       = "Enforce IAM access keys to be not older than 90 days"
  description = "Deactivate or delete IAM access keys that are older than 90 days."
  parent      = "tmod:@turbot/turbot#/"
}

# AWS > IAM > Enabled
resource "turbot_policy_setting" "aws_iam_enabled" {
  resource = turbot_smart_folder.pack.id
  type     = "tmod:@turbot/aws-iam#/policy/types/iamEnabled"
  value    = "Enabled"
}
