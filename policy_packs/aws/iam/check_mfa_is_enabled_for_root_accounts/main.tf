resource "turbot_policy_pack" "main" {
  title       = "Check MFA is Enabled for AWS IAM Root Accounts"
  description = "Prevent potential security breaches and enhance overall account security by requiring a second form of verification."
}
