resource "turbot_policy_pack" "main" {
  title       = "AWS IAM Enforce Cross Account Roles Require External ID or MFA"
  description = "Enforce that AWS IAM assumed roles across accounts have an external ID or MFA."
  akas        = ["aws_iam_enforce_cross_account_roles_require_external_id_or_mfa"]
}
