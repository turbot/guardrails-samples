resource "turbot_policy_pack" "main" {
  title       = "Enforce NAT Gateways Are Deleted"
  description = "This measure prevents any outbound internet traffic from private subnets, reducing the risk of data exfiltration, unauthorized access, and potential security breaches."
  akas        = ["aws_vpc_enforce_nat_gateways_are_deleted"]
}
