# Policy Pack
resource "turbot_smart_folder" "pack" {
  title       = "Detect whether encryption is enabled for AWS EBS volumes attached to AWS EC2 instances"
  description = "Detect if encryption is enabled for AWS EBS volumes attached to EC2 instances"
  parent      = "tmod:@turbot/turbot#/"
}

# AWS > EC2 > Enabled
resource "turbot_policy_setting" "aws_ec2_enabled" {
  resource = turbot_smart_folder.pack.id
  type     = "tmod:@turbot/aws-ec2#/policy/types/ec2Enabled"
  value    = "Enabled"
}
