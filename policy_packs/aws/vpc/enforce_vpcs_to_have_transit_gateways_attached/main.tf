resource "turbot_policy_pack" "main" {
  title       = "Enforce AWS VPCs to have Transit Gateways Attached"
  description = "Ensure secure and efficient inter-VPC communication and centralized network management."
  akas        = ["aws_vpc_enforce_vpcs_to_have_transit_gateways_attached"]
}
