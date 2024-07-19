resource "turbot_policy_pack" "main" {
  title       = "Enforce to Not Use Unapproved NAT Gateways"
  description = "Ensure to use only approved NAT Gateways, as this is crucial for maintaining network security, cost control, and compliance with organizational policies"
  akas        = ["aws_vpc_enforce_usage_restriction_on_all_nat_gateways"]
}
