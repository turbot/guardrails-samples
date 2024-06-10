# Policy Pack
resource "turbot_smart_folder" "pack" {
  title       = "Deny configuration changes to AWS config"
  description = "Disallow configuration changes to AWS config."
  parent      = "tmod:@turbot/turbot#/"
}

# AWS > IAM > Enabled
resource "turbot_policy_setting" "aws_iam_enabled" {
  resource = turbot_smart_folder.pack.id
  type     = "tmod:@turbot/aws-iam#/policy/types/iamEnabled"
  value    = "Enabled"
}
