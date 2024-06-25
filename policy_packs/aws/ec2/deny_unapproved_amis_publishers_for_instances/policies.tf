# AWS > EC2 > Permissions > Lockdown > Instance > Image
resource "turbot_policy_setting" "aws_ec2_permissions_lockdown_instance_image" {
  resource = turbot_smart_folder.main.id
  type     = "tmod:@turbot/aws-ec2#/policy/types/ec2PermissionsLockdownInstanceImage"
  value    = "Lockdown Disabled"
  # value    = "Lockdown Enabled: Allow Image > AMI IDs only"
  # value    = "Lockdown Enabled: Allow Image > Publishers only"
  # value    = "Lockdown Enabled: Allow Image > AMI IDs or Image > Publishers"
  # value    = "Lockdown Enabled: Allow Image > AMI IDs from Image > Publishers"
}

# AWS > EC2 > Permissions > Lockdown > Instance > Image > AMI IDs
resource "turbot_policy_setting" "aws_ec2_permissions_lockdown_instance_image_ami_ids" {
  resource = turbot_smart_folder.main.id
  type     = "tmod:@turbot/aws-ec2#/policy/types/ec2PermissionsLockdownInstanceImageAmiIds"
  # Insert your AMI IDs below
  value    = <<-EOT
    - "ami-12345678"
    - "ami-87654321"
    EOT
}


# AWS > EC2 > Permissions > Lockdown > Instance > Image > Publishers
resource "turbot_policy_setting" "aws_ec2_permissions_lockdown_instance_image_publishers" {
  resource = turbot_smart_folder.main.id
  type     = "tmod:@turbot/aws-ec2#/policy/types/ec2PermissionsLockdownInstanceImagePublishers"
  # Insert your Publisher Account IDs below
  value    = <<-EOT
    - "123456789012"
    - "987654321098"
    EOT
  # Allow all images with `amazon` ImageOwnerAlias and all local images
  # value    = <<-EOT
  #   - "amazon"
  #   - "local"
  #   EOT
}
