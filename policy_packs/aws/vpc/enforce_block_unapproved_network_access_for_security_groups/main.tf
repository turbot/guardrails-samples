resource "turbot_policy_pack" "main" {
  title       = "Enforce Block Unapproved Network Access for Security Groups"
  description = "Allow only approved ingress rules for AWS VPC Security Groups to ensure that only specific ports (22, 443, 3389) are accessible from individual IP addresses (bitmask =32) and specific CIDRs."
  akas        = ["aws_vpc_enforce_block_unapproved_network_access_for_security_groups"]
}
