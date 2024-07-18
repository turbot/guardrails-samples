resource "turbot_policy_pack" "main" {
  title       = "Enforce Credential Report Records Are Enabled For Accounts"
  description = "Enforcing credential reports for accounts help monitor and audit credential usage, identify potential security risks, and ensure compliance with security policies by providing detailed reports on the status and activity of IAM users and their associated credentials."
  akas        = ["aws_iam_enforce_credential_report_records_is_enabled_for_accounts"]
}
