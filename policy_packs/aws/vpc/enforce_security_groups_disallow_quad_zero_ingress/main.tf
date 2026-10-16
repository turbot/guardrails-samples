resource "turbot_policy_pack" "main" {
  title       = "Enforce Quad-Zero Ingress Rules Are Blocked for AWS VPC Security Groups"
  description = "Detect and optionally remediate AWS VPC security group ingress rules open to the entire internet (0.0.0.0/0 or ::/0) on any protocol or port, with tag-based exceptions at the security group or account level."
  akas        = ["aws_vpc_enforce_security_groups_disallow_quad_zero_ingress"]
}
