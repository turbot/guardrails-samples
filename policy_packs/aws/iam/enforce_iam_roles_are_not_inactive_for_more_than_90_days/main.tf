resource "turbot_policy_pack" "main" {
  title       = "AWS IAM Enforce Roles Are Not Inactive for More Than 90 Days"
  description = "Enforce that AWS IAM Roles are not inactive for more than 90 days."
  akas        = ["aws_iam_enforce_iam_roles_are_not_inactive_for_more_than_90_days"]
}
