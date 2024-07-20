# AWS > EC2 > Instance > Approved
resource "turbot_policy_setting" "aws_ec2_instance_approved" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/aws-ec2#/policy/types/instanceApproved"
  value    = "Check: Approved"
  # value    = "Enforce: Stop unapproved"
  # value    = "Enforce: Stop unapproved if new"
  # value    = "Enforce: Delete unapproved if new"
}

# A list of instance types that the AWS EC2 instance is approved to use
# AWS > EC2 > Instance > Approved > Instance Types
resource "turbot_policy_setting" "aws_ec2_instance_approved_volume_types" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/aws-ec2#/policy/types/instanceApprovedInstanceTypes"
  value    = <<-EOT
    - "t3.*"
    - "m5.xlarge"
  EOT
}
