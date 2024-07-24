resource "turbot_policy_pack" "main" {
  title       = "Enforce Removal of AWS VPC Internet Gateways"
  description = "This measure minimizes the attack surface, reduces the risk of unauthorized access and potential data breaches, and ensures that all external connectivity is tightly controlled and monitored through alternative, more secure methods."
  akas        = ["aws_vpc_enforce_internet_gateways_to_not_exist"]
}
