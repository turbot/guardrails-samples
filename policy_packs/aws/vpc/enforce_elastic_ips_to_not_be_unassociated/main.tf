resource "turbot_policy_pack" "main" {
  title       = "Enforce AWS VPC Elastic IPs to Not Be Unassociated"
  description = "Ensure that all allocated Elastic IPs are actively used, reducing the risk of unnecessary costs, potential IP misconfigurations, and security vulnerabilities associated with unused IP addresses."
  akas        = ["aws_vpc_enforce_elastic_ips_to_not_be_unassociated"]
}
