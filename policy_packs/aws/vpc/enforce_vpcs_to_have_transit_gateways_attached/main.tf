resource "turbot_policy_pack" "main" {
  title       = "Enforce AWS VPC VPCs to have Transit Gateway Attached"
  description = "Ensuring secure and efficient inter-VPC communication and centralized network management."
  akas        = ["aws_vpc_enforce_vpcs_to_have_transit_gateways_attached"]
}
