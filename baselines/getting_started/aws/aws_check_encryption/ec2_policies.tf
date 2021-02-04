# Encryption at Rest Guardrails - https://turbot.com/v5/docs/concepts/guardrails/encryption-at-rest

# AWS > EC2 > Instance > Approved 
# https://turbot.com/v5/mods/turbot/aws-ec2/inspect#/policy/types/instanceApproved
resource "turbot_policy_setting" "ec2_instance_approved" {
  resource = turbot_smart_folder.aws_encryption.id
  type     = "tmod:@turbot/aws-ec2#/policy/types/instanceApproved"
  value    = "Check: Approved"
}
# AWS > EC2 > Instance > Approved > Root Volume Encryption at Rest
# https://turbot.com/v5/mods/turbot/aws-ec2/inspect#/policy/types/rootVolumeEncryptionAtRest
resource "turbot_policy_setting" "ec2_instance_root_volume_encryption" {
  resource = turbot_smart_folder.aws_encryption.id
  type     = "tmod:@turbot/aws-ec2#/policy/types/rootVolumeEncryptionAtRest"
  value    = "AWS managed key or higher"
}

# Enable if you want to check for existence of a specific KMS key

# resource "turbot_policy_setting" "ec2_root_volume_encryption_kms_key" {
#     resource        = turbot_smart_folder.aws_encryption.id
#     type            = "tmod:@turbot/aws-ec2#/policy/types/rootVolumeEncryptionAtRestCustomerManagedKey"
#     value           = "arn:aws:kms:us-east-1:000000000000:alias/aws/ebs"  ### key id, alias name or full ARN of alias/key
# }

# AWS > EC2 > Volume > Approved 
# https://turbot.com/v5/mods/turbot/aws-ec2/inspect#/policy/types/volumeApproved
resource "turbot_policy_setting" "ec2_volume_approved" {
  resource = turbot_smart_folder.aws_encryption.id
  type     = "tmod:@turbot/aws-ec2#/policy/types/volumeApproved"
  value    = "Check: Approved"
}

# AWS > EC2 > Volume > Approved > Encryption at Rest
# https://turbot.com/v5/mods/turbot/aws-ec2/inspect#/policy/types/volumeEncryptionAtRest
resource "turbot_policy_setting" "ec2_volume_encryption" {
  resource = turbot_smart_folder.aws_encryption.id
  type     = "tmod:@turbot/aws-ec2#/policy/types/volumeEncryptionAtRest"
  value    = "AWS managed key or higher"
}

# Enable if you want to check for existence of a specific kms key

# resource "turbot_policy_setting" "ec2_volume_encryption_kms_key" {
#     resource        = turbot_smart_folder.aws_encryption.id
#     type            = "tmod:@turbot/aws-ec2#/policy/types/volumeEncryptionAtRestCustomerManagedKey"
#     value           = "arn:aws:kms:us-east-1:000000000000:alias/aws/ebs"  ### key id, alias name or full ARN of alias/key
# }

# AWS > EC2 > Snapshot > Approved 
# https://turbot.com/v5/mods/turbot/aws-ec2/inspect#/policy/types/snapshotApproved
resource "turbot_policy_setting" "ec2_snapshot_approved" {
  resource = turbot_smart_folder.aws_encryption.id
  type     = "tmod:@turbot/aws-ec2#/policy/types/snapshotApproved"
  value    = "Check: Approved"
}

# AWS > EC2 > Snapshot > Approved > Encryption at Rest
# https://turbot.com/v5/mods/turbot/aws-ec2/inspect#/policy/types/snapshotEncryptionAtRest
resource "turbot_policy_setting" "ec2_snapshot_approved_encryption" {
  resource = turbot_smart_folder.aws_encryption.id
  type     = "tmod:@turbot/aws-ec2#/policy/types/snapshotEncryptionAtRest"
  value    = "AWS managed key or higher"
}

# Enable if you want to check for existance of a specific kms key

# resource "turbot_policy_setting" "ec2_snapshot_encryption_kms_key" {
#     resource        = turbot_smart_folder.aws_encryption.id
#     type            = "tmod:@turbot/aws-ec2#/policy/types/snapshotEncryptionAtRestCustomerManagedKey"
#     value           = "arn:aws:kms:us-east-1:000000000000:alias/aws/ebs"  ### key id, alias name or full ARN of alias/key
# }
