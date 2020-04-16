# EC2 encryption enforcement folder

resource "turbot_smart_folder" "ec2_encryption" {
  title         = var.smart_folder_title
  description   = "Create a smart folder and set snapshot encryption and volume encryption policies"
  parent        = "tmod:@turbot/turbot#/"
}

# AWS > EC2 > Snapshot > Approved
resource "turbot_policy_setting" "ec2_snapshot_approved" {
  resource = turbot_smart_folder.ec2_encryption.id
  type = "tmod:@turbot/aws-ec2#/policy/types/snapshotApproved"
  value = "Check: Approved"
}

# AWS > EC2 > Snapshot > Approved
resource "turbot_policy_setting" "ec2_volume_approved" {
  resource = turbot_smart_folder.ec2_encryption.id
  type = "tmod:@turbot/aws-ec2#/policy/types/volumeApproved"
  value = "Check: Approved"
}

# Enforce Block Storage Encryption
# AWS > EC2 > Volume > Approved > Encryption at Rest
resource "turbot_policy_setting" "ec2_volume_approved_encryption" {
  resource = turbot_smart_folder.ec2_encryption.id
  type = "tmod:@turbot/aws-ec2#/policy/types/volumeEncryptionAtRest"
  value = "AWS managed key or higher"
}

# Enforce Snapshot/Backup Encryption
# AWS > EC2 > Snapshot > Approved > Encryption at Rest
resource "turbot_policy_setting" "ec2_snapshot_approved_encryption" {
  resource = turbot_smart_folder.ec2_encryption.id
  type = "tmod:@turbot/aws-ec2#/policy/types/snapshotEncryptionAtRest"
  value = "AWS managed key or higher"
}