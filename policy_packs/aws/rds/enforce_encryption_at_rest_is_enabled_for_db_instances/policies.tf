# AWS > RDS > DB Instance > Approved
resource "turbot_policy_setting" "aws_rds_db_instance_approved" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/aws-rds#/policy/types/dbInstanceApproved"
  value    = "Check: Approved"
  # value    = "Enforce: Stop unapproved"
  # value    = "Enforce: Delete unapproved if new"
}

# AWS > RDS > DB Instance > Approved > Encryption at Rest
resource "turbot_policy_setting" "aws_rds_db_instance_approved_encryption_at_rest" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/aws-rds#/policy/types/dbInstanceEncryptionAtRest"
  value    = "AWS managed key or higher"
  # value    = "Customer managed key"
  # value    = "Encryption at Rest > Customer Managed Key"
}

# AWS > RDS > DB Instance > Approved > Encryption at Rest > Customer Managed Key
resource "turbot_policy_setting" "aws_rds_db_instance_approved_encryption_at_rest_customer_managed_key" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/aws-rds#/policy/types/dbInstanceEncryptionAtRestCustomerManagedKey"
  # You KMS key alias, id or ARN
  value    = "alias/turbot/default"
  # value    = "ddc06e04-ce5f-4995-c758-c2b6c510e8fd"
  # value    = "arn:aws:kms:us-west-2:123456789012:key/12345678-1234-1234-1234-123456789012"
}
