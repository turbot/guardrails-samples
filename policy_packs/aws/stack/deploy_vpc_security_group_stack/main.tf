resource "turbot_policy_pack" "main" {
  title       = "Deploy security group in VPC"
  description = "Deploy and manage security group using OpenTofu with AWS > VPC > VPC > Stack [Native] control."
  akas        = ["aws_vpc_core_vpc_stack_native"]
}
