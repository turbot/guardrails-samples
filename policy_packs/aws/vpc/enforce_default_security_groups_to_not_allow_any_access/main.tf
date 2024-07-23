resource "turbot_policy_pack" "main" {
  title       = "Enforce AWS VPC Default Security Groups to Not Allow Any Access"
  description = "Ensure default security groups are not left open, as they could inadvertently permit unrestricted inbound and outbound traffic, leading to unauthorized access and exploitation of resources within the VPC."
  akas        = ["aws_vpc_enforce_default_security_groups_to_not_allow_any_access"]
}
