resource "turbot_policy_pack" "main" {
  title       = "AWS IAM Enforce Resource Policies Do Not Allow All Actions"
  description = "Enforce that AWS IAM Resource policies do not allow all actions."
  akas        = ["aws_iam_enforce_resource_policies_do_not_allow_all_actions"]
}
