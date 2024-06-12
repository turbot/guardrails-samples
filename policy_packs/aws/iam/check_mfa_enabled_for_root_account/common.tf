# Policy Pack
resource "turbot_smart_folder" "pack" {
  title       = "Detect MFA Enabled for AWS IAM Root Account"
  description = "Detect if MFA is enabled for AWS IAM root account."
  parent      = "tmod:@turbot/turbot#/"
}

# AWS > IAM > Enabled
resource "turbot_policy_setting" "aws_iam_enabled" {
  resource = turbot_smart_folder.pack.id
  type     = "tmod:@turbot/aws-iam#/policy/types/iamEnabled"
  value    = "Enabled"
}
