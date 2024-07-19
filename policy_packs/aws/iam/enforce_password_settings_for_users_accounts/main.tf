resource "turbot_policy_pack" "main" {
  title       = "Enforce Password Settings for AWS IAM User Accounts"
  description = "Enforce password settings for user accounts ensures that password policies, such as complexity, length, and rotation frequency, are consistently applied, thereby enhancing the security of user accounts and reducing the risk of password-related security breaches."
  akas        = ["aws_iam_enforce_password_settings_for_users_accounts"]
}
