# Policy Pack
resource "turbot_smart_folder" "pack" {
  title       = "Detect that IMDSv2 is enforced for all AWS EC2 instances"
  description = "Detect if AWS EC2 instance has IMDSv2 enforced"
  parent      = "tmod:@turbot/turbot#/"
}

# AWS > EC2 > Enabled
resource "turbot_policy_setting" "aws_ec2_enabled" {
  resource = turbot_smart_folder.pack.id
  type     = "tmod:@turbot/aws-ec2#/policy/types/ec2Enabled"
  value    = "Enabled"
}
