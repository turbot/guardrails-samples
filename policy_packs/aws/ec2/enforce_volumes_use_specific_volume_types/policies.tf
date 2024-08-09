# AWS > EC2 > Volume > Approved
resource "turbot_policy_setting" "aws_ec2_volume_approved" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/aws-ec2#/policy/types/volumeApproved"
  value    = "Check: Approved"
  # value    = "Enforce: Detach unapproved if new"
  # value    = "Enforce: Detach, snapshot and delete unapproved if new"
}

# List of volume types that are approved for use
# AWS > EC2 > Volume > Approved > Volume Types
resource "turbot_policy_setting" "aws_ec2_volume_approved_volume_types" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/aws-ec2#/policy/types/volumeApprovedVolumeTypes"
  value    = <<-EOT
    - "gp2"
    - "io1"
    - "sc1"
    - "st1"
    - "standard"
  EOT
}
