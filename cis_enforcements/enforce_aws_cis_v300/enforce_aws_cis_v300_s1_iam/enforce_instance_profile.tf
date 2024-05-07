# AWS > EC2 > Instance > Instance Profile
resource turbot_policy_setting "aws_ec2_instance_instance_profile" {
  resource = turbot_smart_folder.aws_cis_v300_s1_iam.id
  type = "tmod:@turbot/aws-ec2#/policy/types/instanceProfile"
  value = "Check: Instance profile attached"
  #   value = "Check: Instance Profile > Name attached"
  #   value = "Enforce: Attach Instance Profile > Name"
  note = "AWS CIS v3.0.0 AWS CIS v3.0.0 - Controls: 1.18"
}

# AWS > EC2 > Instance > Instance Profile > Name
resource turbot_policy_setting "aws_ec2_instance_instance_profile_role_name" {
  resource = turbot_smart_folder.aws_cis_v300_s1_iam.id
  type = "tmod:@turbot/aws-ec2#/policy/types/instanceProfileName"
  value = var.ec2_instance_profile
  note = "Needs just the name of the role, not the full ARN."
}
