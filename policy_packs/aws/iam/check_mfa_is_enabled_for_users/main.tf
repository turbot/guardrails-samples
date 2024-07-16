resource "turbot_policy_pack" "main" {
  title       = "Check MFA Is Enabled for Users"
  description = "Ensure that Multi-Factor Authentication (MFA) is enabled and required for AWS IAM users to enhance security."
  akas        = ["aws_iam_check_mfa_is_enabled_for_users"]
}
