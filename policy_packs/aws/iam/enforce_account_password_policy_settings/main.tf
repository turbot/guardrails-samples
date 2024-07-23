resource "turbot_policy_pack" "main" {
  title       = "Enforce AWS IAM Account Password Policy Settings"
  description = "Ensure that passwords meet specific complexity, length, and rotation requirements, reducing the risk of unauthorized access and aligning with best practices and regulatory compliance."
  akas        = ["aws_iam_enforce_account_password_policy_settings"]
}
