
# AWS > IAM > Account Password Policy > Settings
resource "turbot_policy_setting" "aws_iam_account_password_policy_settings" {
  note     = <<-EOT
    AWS CIS v3.0.0 - Section 1 - IAM: |
      1.8 Ensure IAM password policy requires minimum length of 14 or greater. |
      1.9 Ensure IAM password policy prevents password reuse. |
    EOT
  resource = turbot_smart_folder.aws_cis_v300_s1_iam.id
  type     = "tmod:@turbot/aws-iam#/policy/types/accountPasswordPolicySettings"
  value    = "Check: Configured"
  # value    = "Enforce: Configured"
}

# AWS > IAM > Account Password Policy > Settings > Minimum Length
resource "turbot_policy_setting" "aws_iam_account_password_policy_settings_minimum_length" {
  note     = <<-EOT
    AWS CIS v3.0.0 - Section 1 - IAM: |
      1.8 Ensure IAM password policy requires minimum length of 14 or greater.
    EOT
  resource = turbot_smart_folder.aws_cis_v300_s1_iam.id
  type     = "tmod:@turbot/aws-iam#/policy/types/accountPasswordPolicySettingsMinimumLength"
  value    = 14
}

# AWS > IAM > Account Password Policy > Settings > Reuse Prevention
resource "turbot_policy_setting" "aws_iam_account_password_policy_settings_reuse_prevention" {
  note     = <<-EOT
    AWS CIS v3.0.0 - Section 1 - IAM: |
      1.9 Ensure IAM password policy prevents password reuse.
    EOT
  resource = turbot_smart_folder.aws_cis_v300_s1_iam.id
  type     = "tmod:@turbot/aws-iam#/policy/types/accountPasswordPolicySettingsReusePrevention"
  value    = 24
}
