resource "turbot_policy_pack" "main" {
  title       = "Enforce Removal of AWS VPC Elastic IPs"
  description = "This measure minimizes the attack surface by eliminating potential entry points for unauthorized access and reducing the risk of data breaches, thereby ensuring compliance with security best practices."
  akas        = ["aws_vpc_enforce_elastic_ips_to_not_exist"]
}
