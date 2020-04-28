# EC2 Volume Approved folder

resource "turbot_smart_folder" "ec2_volume_approved" {
  title         = var.smart_folder_title
  description   = "Create a smart folder and set volume approved policies"
  parent        = "tmod:@turbot/turbot#/"
}

# Determine the action to take when an AWS EC2 volume is not approved based on AWS > EC2 > Volume > Approved > * policies
# AWS > EC2 > Volume > Approved
resource "turbot_policy_setting" "ec2_vol_approved" {
  resource = turbot_smart_folder.ec2_volume_approved.id
  type = "tmod:@turbot/aws-ec2#/policy/types/volumeApproved"
  value = "Check: Approved"
}

# A list of volume types that the AWS EC2 volume is approved to use.
# AWS > EC2 > Volume > Approved > Volume Types
resource "turbot_policy_setting" "ec2_vol_approved_types" {
  resource = turbot_smart_folder.ec2_volume_approved.id
  type = "tmod:@turbot/aws-ec2#/policy/types/volumeApprovedVolumeTypes"
  value = yamlencode(["standard","gp2","io1","sc1","st1"])
}

# Configure the behavior of Active Control for the AWS EC2 volume, based on the AWS > EC2 > Volume > Active > * policies.
# AWS > EC2 > Volume > Active
resource "turbot_policy_setting" "ec2_volume_active" {
  resource = turbot_smart_folder.ec2_volume_approved.id
  type = "tmod:@turbot/aws-ec2#/policy/types/volumeActive"
  value = "Check: Active"
}