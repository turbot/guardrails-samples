# Policy Pack
resource "turbot_smart_folder" "pack" {
  title       = "Enforce IMDSv2 on AWS EC2 Instances"
  description = "Ensure that IMDSv2 is enforced for AWS EC2 instances."
  parent      = "tmod:@turbot/turbot#/"
}

# AWS > EC2 > Enabled
resource "turbot_policy_setting" "aws_ec2_enabled" {
  resource = turbot_smart_folder.pack.id
  type     = "tmod:@turbot/aws-ec2#/policy/types/ec2Enabled"
  value    = "Enabled"
}
