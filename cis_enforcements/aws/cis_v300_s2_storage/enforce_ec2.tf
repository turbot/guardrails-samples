# AWS > EC2 > Account Attributes > EBS Encryption by Default
resource "turbot_policy_setting" "aws_ec2_ec2_account_attributes_ebs_encryption_by_default" {
  resource = turbot_smart_folder.aws_cis_v300_s2_storage.id
  type     = "tmod:@turbot/aws-ec2#/policy/types/ec2AccountAttributesEbsEncryptionByDefault"
  note     = "AWS CIS v3.0.0 - Control: 2.2.1"
  value    = "Check: AWS managed key or higher"
  # value    = "Enforce: AWS managed key or higher"
}

# AWS > EC2 > Volume > Approved
resource "turbot_policy_setting" "aws_ec2_volume_approved" {
  resource = turbot_smart_folder.aws_cis_v300_s2_storage.id
  type     = "tmod:@turbot/aws-ec2#/policy/types/volumeApproved"
  note     = "AWS CIS v3.0.0 - Control: 2.2.1"
  value    = "Check: Approved"
  # value    = "Enforce: Detach unapproved if new"
  # value    = "Enforce: Detach, snapshot and delete unapproved if new"
}

# AWS > EC2 > Volume > Approved > Usage
resource "turbot_policy_setting" "aws_ec2_volume_approved_usage" {
  resource = turbot_smart_folder.aws_cis_v_300_s_2_storage.id
  type     = "tmod:@turbot/aws-ec2#/policy/types/volumeApprovedUsage"
  value    = "Approved"
}

# AWS > EC2 > Volume > Approved > Encryption at Rest
resource "turbot_policy_setting" "aws_ec2_volume_encryption_at_rest" {
  resource = turbot_smart_folder.aws_cis_v300_s2_storage.id
  type     = "tmod:@turbot/aws-ec2#/policy/types/volumeEncryptionAtRest"
  note     = "AWS CIS v3.0.0 - Control: 2.2.1"
  value    = "AWS managed key or higher"
}

# AWS > EC2 > Instance > Approved
resource "turbot_policy_setting" "aws_ec2_instance_approved" {
  resource = turbot_smart_folder.aws_cis_v300_s2_storage.id
  type     = "tmod:@turbot/aws-ec2#/policy/types/instanceApproved"
  note     = "AWS CIS v3.0.0 - Control: 2.2.1"
  value    = "Check: Approved"
  # value    = "Enforce: Stop unapproved"
  # value    = "Enforce: Stop unapproved if new"
  # value    = "Enforce: Delete unapproved if new"
}

# AWS > EC2 > Instance > Approved > Usage
resource "turbot_policy_setting" "aws_ec2_instance_approved_usage" {
  resource = turbot_smart_folder.aws_cis_v300_s2_storage.id
  type     = "tmod:@turbot/aws-ec2#/policy/types/instanceApprovedUsage"
  note     = "AWS CIS v3.0.0 - Control: 2.2.1"
  value    = "Approved"
}

# AWS > EC2 > Instance > Approved > Root Volume Encryption at Rest
resource "turbot_policy_setting" "aws_ec2_root_volume_encryption_at_rest" {
  resource = turbot_smart_folder.aws_cis_v300_s2_storage.id
  type     = "tmod:@turbot/aws-ec2#/policy/types/rootVolumeEncryptionAtRest"
  note     = "AWS CIS v3.0.0 - Control: 2.2.1"
  value    = "AWS managed key or higher"
}