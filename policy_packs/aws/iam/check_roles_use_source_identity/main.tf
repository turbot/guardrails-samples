resource "turbot_policy_pack" "main" {
  title       = "Check if AWS IAM Roles Use Source Identity"
  description = "This guardrail checks that all IAM roles are using correct source identity statements in the role trust policy."
  akas        = ["aws_iam_check_roles_use_source_identity"]
}
