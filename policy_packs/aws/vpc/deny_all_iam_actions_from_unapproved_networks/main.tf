resource "turbot_policy_pack" "main" {
  title       = "Deny all IAM actions from Unapproved Networks"
  description = "Ensure that IAM actions, such as creating, modifying, or deleting resources, can only be performed from trusted and approved networks."
  akas        = ["aws_vpc_deny_access_from_unapproved_cidrs_for_security_groups"]
}
