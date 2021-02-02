## Ensure encryption on EC2 Resources

###  EC2 Instances with Unencrypted Root Volume 
resource "turbot_policy_setting" "ec2_instance_approved" {
    resource        = turbot_smart_folder.aws_encryption.id
    type            = "tmod:@turbot/aws-ec2#/policy/types/instanceApproved"
    value           = "Check: Approved"
}

resource "turbot_policy_setting" "ec2_instance_root_volume_encryption" {
    resource        = turbot_smart_folder.aws_encryption.id
    type            = "tmod:@turbot/aws-ec2#/policy/types/rootVolumeEncryptionAtRest"
    value           = "AWS managed key or higher"
}

# Enable if you want to check for existence of a specific KMS key

# resource "turbot_policy_setting" "ec2_root_volume_encryption_kms_key" {
#     resource        = turbot_smart_folder.aws_encryption.id
#     type            = "tmod:@turbot/aws-ec2#/policy/types/rootVolumeEncryptionAtRestCustomerManagedKey"
#     value           = "arn:aws:kms:us-east-1:000000000000:alias/aws/ebs"  ### key id, alias name or full ARN of alias/key
# }

## EBS Volumes
resource "turbot_policy_setting" "ec2_volume_approved" {
    resource        = turbot_smart_folder.aws_encryption.id
    type            = "tmod:@turbot/aws-ec2#/policy/types/volumeApproved"
    value           = "Check: Approved"
}

resource "turbot_policy_setting" "ec2_volume_encryption" {
    resource        = turbot_smart_folder.aws_encryption.id
    type            = "tmod:@turbot/aws-ec2#/policy/types/volumeEncryptionAtRest"
    value           = "AWS managed key or higher"
}

# Enable if you want to check for existence of a specific kms key

# resource "turbot_policy_setting" "ec2_volume_encryption_kms_key" {
#     resource        = turbot_smart_folder.aws_encryption.id
#     type            = "tmod:@turbot/aws-ec2#/policy/types/volumeEncryptionAtRestCustomerManagedKey"
#     value           = "arn:aws:kms:us-east-1:000000000000:alias/aws/ebs"  ### key id, alias name or full ARN of alias/key
# }

# Snapshots
resource "turbot_policy_setting" "ec2_snapshot_approved" {
    resource        = turbot_smart_folder.aws_encryption.id
    type            = "tmod:@turbot/aws-ec2#/policy/types/snapshotApproved"
    value           = "Check: Approved"
}

resource "turbot_policy_setting" "ec2_snapshot_approved_encryption" {
    resource        = turbot_smart_folder.aws_encryption.id
    type            = "tmod:@turbot/aws-ec2#/policy/types/snapshotEncryptionAtRest"
    value           = "AWS managed key or higher"
}

# Enable if you want to check for existance of a specific kms key

# resource "turbot_policy_setting" "ec2_snapshot_encryption_kms_key" {
#     resource        = turbot_smart_folder.aws_encryption.id
#     type            = "tmod:@turbot/aws-ec2#/policy/types/snapshotEncryptionAtRestCustomerManagedKey"
#     value           = "arn:aws:kms:us-east-1:000000000000:alias/aws/ebs"  ### key id, alias name or full ARN of alias/key
# }
