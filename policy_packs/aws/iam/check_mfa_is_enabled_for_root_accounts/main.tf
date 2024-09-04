resource "turbot_policy_pack" "main" {
  title       = "Check MFA Is Enabled for AWS IAM Root Accounts"
  description = "Prevent potential security breaches and enhance overall account security by requiring a second form of verification."
  akas        = ["aws_iam_check_mfa_is_enabled_for_root_accounts"]
}
