resource "turbot_policy_pack" "main" {
  title       = "Enforce Trusted Access for AWS IAM Roles"
  description = "Enforce trusted access for roles is critical for ensuring that only authorized entities can assume specific roles, thereby maintaining a secure and controlled access environment"
  akas        = ["aws_iam_enforce_trusted_access_for_roles"]
}
