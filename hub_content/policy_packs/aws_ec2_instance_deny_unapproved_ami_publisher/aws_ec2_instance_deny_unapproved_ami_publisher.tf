# AWS > EC2 > Instance > Approved
resource "turbot_policy_setting" "aws_ec2_instance_deny_unapproved_ami_publisher" {
  resource = turbot_smart_folder.aws_ec2_instance_deny_unapproved_ami_publisher.id
  type     = "tmod:@turbot/aws-ec2#/policy/types/instanceApproved"
  value    = "Check: Approved"
  # value    = "Enforce: Stop unapproved"
  # value    = "Enforce: Stop unapproved if new"
  # value    = "Enforce: Delete unapproved if new"
}

# AWS > EC2 > Instance > Approved > Image
resource "turbot_policy_setting" "aws_ec2_instance_deny_unapproved_ami_publisher_image" {
  resource = turbot_smart_folder.aws_ec2_instance_deny_unapproved_ami_publisher.id
  type     = "tmod:@turbot/aws-ec2#/policy/types/instanceApprovedImage"
  value    = "Approved if ImageId in Image > AMI IDs and Owner in Image > Publishers"
  # value    = "Approved if ImageId in Image > AMI IDs"
  # value    = "Approved if Owner in Image > Publishers"
  # value    = "Approved if ImageId in Image > AMI IDs or Owner in Image > Publisher"
}

# AWS > EC2 > Instance > Approved > Image > AMI IDs
resource "turbot_policy_setting" "aws_ec2_instance_deny_unapproved_ami_publisher_image_ami_ids" {
  resource = turbot_smart_folder.aws_ec2_instance_deny_unapproved_ami_publisher.id
  type     = "tmod:@turbot/aws-ec2#/policy/types/instanceApprovedImageAmiIds"
  # Insert your AMI IDs below
  value    = yamlencode(["ami-12345678", "ami-87654321"])
}

# AWS > EC2 > Instance > Approved > Image > Publishers
resource "turbot_policy_setting" "aws_ec2_instance_deny_unapproved_ami_publisher_image_ami_publishers" {
  resource = turbot_smart_folder.aws_ec2_instance_deny_unapproved_ami_publisher.id
  type     = "tmod:@turbot/aws-ec2#/policy/types/instanceApprovedImagePublishers"
  # Insert your Publisher Account IDs below
  value    = yamlencode(["123456789012", "987654321098"])
}
