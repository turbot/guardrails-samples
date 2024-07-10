resource "turbot_smart_folder" "main" {
  title       = "Check MFA is Enabled for AWS IAM Root Accounts"
  description = "Prevent potential security breaches and enhance overall account security by requiring a second form of verification."
  parent      = "tmod:@turbot/turbot#/"
}
