resource "turbot_policy_pack" "main" {
  title       = "Configure VPC Security Group Rules"
  description = "Configure VPC Security Group Rules using OpenTofu with AWS > VPC > VPC > Stack [Native] control."
  akas        = ["aws_vpc_configure_vpc_sg_rules_stack"]
}
