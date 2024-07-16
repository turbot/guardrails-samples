resource "turbot_policy_pack" "main" {
  title       = "Enforce Block Actions from Unapproved CIDRs for Security Groups"
  description = "Ensure that AWS VPC security group ingress rules block actions from unapproved CIDRs to enhance security."
  akas        = ["aws_vpc_enforce_block_actions_from_unapproved_cidrs_for_security_groups"]
}
