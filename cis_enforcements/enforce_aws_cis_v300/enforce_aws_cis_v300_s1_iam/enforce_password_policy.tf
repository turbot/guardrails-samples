
# AWS > IAM > Account Password Policy > Settings
resource "turbot_policy_setting" "aws_iam_account_password_policy_settings" {
  resource = turbot_smart_folder.aws_cis_v300_s1_iam.id
  type     = "tmod:@turbot/aws-iam#/policy/types/accountPasswordPolicySettings"
  value    = "Check: Configured"
  # value    = "Enforce: Configured"
  note     = "AWS CIS v3.0.0 - Controls: 1.8 & 1.9"
}

# AWS > IAM > Account Password Policy > Settings > Minimum Length
resource "turbot_policy_setting" "aws_iam_account_password_policy_settings_minimum_length" {
  resource = turbot_smart_folder.aws_cis_v300_s1_iam.id
  type     = "tmod:@turbot/aws-iam#/policy/types/accountPasswordPolicySettingsMinimumLength"
  value    = 14
  note     = "AWS CIS v3.0.0 - Controls: 1.8"
}

# AWS > IAM > Account Password Policy > Settings > Reuse Prevention
resource "turbot_policy_setting" "aws_iam_account_password_policy_settings_reuse_prevention" {
  resource = turbot_smart_folder.aws_cis_v300_s1_iam.id
  type     = "tmod:@turbot/aws-iam#/policy/types/accountPasswordPolicySettingsReusePrevention"
  value    = 24
  note     = "AWS CIS v3.0.0 - Controls: 1.9"
}
