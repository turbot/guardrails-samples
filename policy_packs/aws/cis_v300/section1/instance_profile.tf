# AWS > EC2 > Instance > Instance Profile
resource "turbot_policy_setting" "aws_ec2_instance_instance_profile" {
  resource = turbot_smart_folder.main.id
  type     = "tmod:@turbot/aws-ec2#/policy/types/instanceProfile"
  note     = "AWS CIS v3.0.0 - Controls: 1.18"
  value    = "Check: Instance profile attached"
  # value    = "Check: Instance Profile > Name attached"
  # value    = "Enforce: Attach Instance Profile > Name"
}

# AWS > EC2 > Instance > Instance Profile > Name
resource "turbot_policy_setting" "aws_ec2_instance_instance_profile_role_name" {
  resource = turbot_smart_folder.main.id
  type     = "tmod:@turbot/aws-ec2#/policy/types/instanceProfileName"
  note     = "AWS CIS v3.0.0 - Controls: 1.18"
  # EC2 Instance Profile name. Just the name not the full ARN.
  value = "orgDefaultInstanceProfile"
}