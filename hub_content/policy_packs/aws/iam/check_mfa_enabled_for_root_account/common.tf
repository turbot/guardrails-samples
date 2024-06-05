# Policy Pack
resource "turbot_smart_folder" "pack" {
  title       = "Detect MFA enabled for root account"
  description = "Detect and report root account where MFA is Enabled"
  parent      = "tmod:@turbot/turbot#/"
}

# AWS > IAM > Enabled
resource "turbot_policy_setting" "aws_iam_enabled" {
  resource = turbot_smart_folder.pack.id
  type     = "tmod:@turbot/aws-iam#/policy/types/iamEnabled"
  value    = "Enabled"
}

