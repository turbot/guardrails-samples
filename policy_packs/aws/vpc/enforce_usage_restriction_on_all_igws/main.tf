resource "turbot_policy_pack" "main" {
  title       = "Enforce to Not Use Unapproved Internet Gateways"
  description = "Ensure to use only approved Internet Gateways, as this is crucial for maintaining security and integrity of a network"
  akas        = ["aws_vpc_enforce_usage_restriction_on_all_igws"]
}
