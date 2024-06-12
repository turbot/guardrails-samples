# Policy Pack
resource "turbot_smart_folder" "pack" {
  title       = "Enforce Encryption at Rest is Enabled for AWS EBS Volumes Attached to AWS EC2 Instances"
  description = "Detach/Snapshot and delete attached AWS EBS volumes that do not have encryption at rest enabled."
  parent      = "tmod:@turbot/turbot#/"
}

# AWS > EC2 > Enabled
resource "turbot_policy_setting" "aws_ec2_enabled" {
  resource = turbot_smart_folder.pack.id
  type     = "tmod:@turbot/aws-ec2#/policy/types/ec2Enabled"
  value    = "Enabled"
}
