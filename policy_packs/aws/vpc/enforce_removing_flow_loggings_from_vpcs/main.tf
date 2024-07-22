resource "turbot_policy_pack" "main" {
  title       = "Enforce Flow Loggings to not exists in VPCs"
  description = "This measure prevents inadvertent exposure of sensitive network traffic data, reducing potential compliance and security risks and maintaining the confidentiality and integrity of network information."
  akas        = ["aws_vpc_enforce_removing_flow_loggings_from_vpcs"]
}
