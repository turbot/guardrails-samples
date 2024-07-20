resource "turbot_policy_pack" "main" {
  title       = "Enforce Elastic IPs To Not Exist"
  description = "Preventing the allocation of Elastic IPs enhances security and cost management by reducing public exposure, minimizing potential attack surfaces, and controlling unnecessary expenses associated with idle IP addresses."
  akas        = ["aws_vpc_enforce_elastic_ips_to_not_exist"]
}
