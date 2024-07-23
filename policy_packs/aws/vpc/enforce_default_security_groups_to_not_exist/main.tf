resource "turbot_policy_pack" "main" {
  title       = "Enforce AWS VPC Default Security Groups to Not Exist"
  description = "This measure ensures that all security group rules are explicitly defined and managed, reducing the risk of vulnerabilities due to misconfigurations or overly permissive default settings."
  akas        = ["aws_vpc_enforce_default_security_groups_to_not_exist"]
}
