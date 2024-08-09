resource "turbot_policy_pack" "main" {
  title       = "Enforce Unapproved Traffic is Blocked for AWS VPC Security Groups"
  description = "Allow only approved ingress rules for AWS VPC Security Groups to ensure that only specific ports (22, 443, 3389) are accessible from individual IP addresses (bitmask =32) and specific CIDRs."
  akas        = ["aws_vpc_enforce_unapproved_traffic_is_blocked_for_security_groups"]
}
