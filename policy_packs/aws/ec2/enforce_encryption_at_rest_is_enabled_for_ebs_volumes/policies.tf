# AWS > EC2 > Volume > Approved
resource "turbot_policy_setting" "aws_ec2_volume_approved" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/aws-ec2#/policy/types/volumeApproved"
  value    = "Check: Approved"
  # value    =  "Enforce: Detach unapproved if new"
  # value    =  "Enforce: Detach, snapshot and delete unapproved if new"
}

# AWS > EC2 > Volume > Approved > Encryption at Rest
resource "turbot_policy_setting" "aws_ec2_volume_approved_encryption_at_rest" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/aws-ec2#/policy/types/volumeEncryptionAtRest"
  value    = "AWS managed key or higher"
  # value    = "Customer managed key"
  # value    = "Encryption at Rest > Customer Managed Key"
}

# AWS > EC2 > Volume > Approved > Encryption at Rest > Customer Managed Key
resource "turbot_policy_setting" "aws_ec2_volume_approved_encryption_at_rest_customer_managed_key" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/aws-ec2#/policy/types/volumeEncryptionAtRestCustomerManagedKey"
  # Enter your CMK id/arn/alias below
  value = "alias/turbot/default"
}
