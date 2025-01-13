resource "turbot_policy_pack" "main" {
  title       = "Deploy Landing Zone VPCs"
  description = "Deploy Landing Zone VPCs using OpenTofu, including subnets, gateways, and route tables"
  akas        = ["aws_vpc_stack_deploy_landing_zone_vpcs"]
}


