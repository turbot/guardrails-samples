resource "turbot_policy_pack" "main" {
  title       = "Enforce AWS VPCs Have Transit Gateways Attached"
  description = "Ensure secure and efficient inter-VPC communication and centralized network management."
  akas        = ["aws_vpc_enforce_vpcs_have_transit_gateways_attached"]
}
