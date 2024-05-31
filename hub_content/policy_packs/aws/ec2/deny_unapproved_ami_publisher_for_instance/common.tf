# Policy Pack
resource "turbot_smart_folder" "pack" {
  title       = "Deny AWS EC2 instances with unapproved AMIs and/or publisher accounts"
  description = "Deny launch of EC2 instances that do not approved AMIs and Publisher Accounts"
  parent      = "tmod:@turbot/turbot#/"
}

# AWS > EC2 > Enabled
resource "turbot_policy_setting" "aws_ec2_enabled" {
  resource = turbot_smart_folder.pack.id
  type     = "tmod:@turbot/aws-ec2#/policy/types/ec2Enabled"
  value    = "Enabled"
}
