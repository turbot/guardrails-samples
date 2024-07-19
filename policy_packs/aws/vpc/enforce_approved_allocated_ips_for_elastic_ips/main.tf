resource "turbot_policy_pack" "main" {
  title       = "Enforce AWS VPC to use associated EIPs"
  description = "Ensuring consistent and reliable public IP addresses, which is essential for maintaining stable and secure connectivity."
  akas        = ["aws_vpc_enforce_approved_allocated_ips_for_elastic_ips"]
}
