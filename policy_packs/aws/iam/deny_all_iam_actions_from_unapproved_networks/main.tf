resource "turbot_policy_pack" "main" {
  title       = "Deny all AWS IAM actions from Unapproved Networks"
  description = "Ensure that IAM actions, such as creating, modifying, or deleting resources, can only be performed from trusted and approved networks."
  akas        = ["aws_iam_deny_all_iam_actions_from_unapproved_networks"]
}
