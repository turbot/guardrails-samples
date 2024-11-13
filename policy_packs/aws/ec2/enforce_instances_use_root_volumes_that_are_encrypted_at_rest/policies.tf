# AWS > EC2 > Instance > Approved > Root Volume Encryption at Rest
resource "turbot_policy_setting" "aws_ec2_instance_approved_root_volume_encryption_at_rest" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/aws-ec2#/policy/types/instanceApprovedRootVolumeEncryptionAtRest"
  value    = "Check: Approved encryption level"
  # value    =  "Enforce: Stop if unapproved encryption level"
  # value    =  "Enforce: Stop if unapproved encryption level and new"
  # value    =  "Enforce: Delete if unapproved encryption level and new"
}

# AWS > EC2 > Instance > Approved > Root Volume Encryption at Rest > Level
resource "turbot_policy_setting" "aws_ec2_instance_approved_root_volume_encryption_at_rest_level" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/aws-ec2#/policy/types/instanceApprovedRootVolumeEncryptionAtRestLevel"
  value    = "AWS managed key or higher"
  # value    = "Customer managed key"
  # value    = "Encryption at Rest > Customer Managed Key"
}

# AWS > EC2 > Instance > Approved > Root Volume Encryption at Rest > Customer Managed Key
resource "turbot_policy_setting" "aws_ec2_instance_approved_root_volume_encryption_at_rest_customer_managed_key" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/aws-ec2#/policy/types/instanceApprovedRootVolumeEncryptionAtRestCustomerManagedKey"
  # Enter your CMK id/arn/alias below
  value = "alias/turbot/default"
}
