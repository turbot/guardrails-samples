# Policy Pack
resource "turbot_smart_folder" "pack" {
  title       = "Detect IAM access key 90 days older"
  description = "Detect and report IAM access keys that is older than 90 days"
  parent      = "tmod:@turbot/turbot#/"
}

# AWS > IAM > Enabled
resource "turbot_policy_setting" "aws_iam_enabled" {
  resource = turbot_smart_folder.pack.id
  type     = "tmod:@turbot/aws-iam#/policy/types/iamEnabled"
  value    = "Enabled"
}
