# Policy Pack
resource "turbot_smart_folder" "aws_ec2_instance_deny_unapproved_ami_publisher" {
  title       = "AWS EC2 instance deny unapproved AMIs"
  description = "Deny launch of EC2 instances that are not using approved AMIs and Publisher Accounts"
  parent      = "tmod:@turbot/turbot#/"
}

# AWS > EC2 > Enabled
resource "turbot_policy_setting" "aws_ec2_enabled" {
  resource = turbot_smart_folder.aws_ec2_instance_deny_unapproved_ami_publisher.id
  type     = "tmod:@turbot/aws-ec2#/policy/types/ec2Enabled"
  value    = "Enabled"
}
