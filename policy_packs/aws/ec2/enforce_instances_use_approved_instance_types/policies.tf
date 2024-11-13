# AWS > EC2 > Instance > Approved > Instance Type
resource "turbot_policy_setting" "aws_ec2_instance_approved_instance_type" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/aws-ec2#/policy/types/instanceApprovedInstanceType"
  value    = "Check: Approved instance type"
  # value    = "Enforce: Stop if unapproved instance type"
  # value    = "Enforce: Stop if unapproved instance type and new"
  # value    = "Enforce: Delete if unapproved instance type and new"
}

# List of instance types that are approved for use
# AWS > EC2 > Instance > Approved > Instance Type > Types
resource "turbot_policy_setting" "aws_ec2_instance_approved_instance_type_types" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/aws-ec2#/policy/types/instanceApprovedInstanceTypeTypes"
  value    = <<-EOT
    - "t3.*"
    - "m5.xlarge"
  EOT
}
