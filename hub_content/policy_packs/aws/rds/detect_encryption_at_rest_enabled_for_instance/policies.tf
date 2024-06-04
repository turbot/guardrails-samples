# AWS > RDS > DB Instance > Approved
resource "turbot_policy_setting" "aws_rds_db_instance_approved" {
  resource = turbot_smart_folder.pack.id
  type     = "tmod:@turbot/aws-rds#/policy/types/dbInstanceApproved"
  value    = "Check: Approved"
  # value    = "Enforce: Stop unapproved"
  # value    = "Enforce: Stop unapproved if new"
  # value    = "Enforce: Delete unapproved if new"
}

# AWS > RDS > DB Instance > Approved > Encryption at Rest
resource "turbot_policy_setting" "aws_rds_db_instance_approved_dbInstanceEncryptionAtRest" {
  resource = turbot_smart_folder.pack.id
  type     = "tmod:@turbot/aws-rds#/policy/types/dbInstanceEncryptionAtRest"
  value    = "AWS managed key or higher"
  # value         = "None"
  # value         = "None or higher"
  # value         = "AWS managed key"
  # value         = "AWS managed key or higher"
  # value         = "Customer managed key"
  # value         = "Encryption at Rest > Customer Managed Key"
}

# AWS > RDS > DB Instance > Approved > Encryption at Rest > Customer Managed Key
resource "turbot_policy_setting" "aws_rds_db_instance_approved_dbInstanceEncryptionAtRestCustomerManagedKey" {
  resource = turbot_smart_folder.pack.id
  type     = "tmod:@turbot/aws-rds#/policy/types/dbInstanceEncryptionAtRestCustomerManagedKey"
  # Update with default encryption key/alias below
  value = "alias/turbot/default"
}

