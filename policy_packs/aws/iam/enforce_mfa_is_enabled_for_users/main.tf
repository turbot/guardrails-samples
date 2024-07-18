resource "turbot_policy_pack" "main" {
  title       = "Enforce MFA Is Enabled for AWS IAM Users"
  description = "This measure adds an extra layer of protection by requiring a second form of verification, reducing the risk of unauthorized access."
  akas        = ["aws_iam_enforce_mfa_is_enabled_for_users"]
}
