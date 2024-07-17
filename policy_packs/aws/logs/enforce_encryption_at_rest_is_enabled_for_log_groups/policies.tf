# AWS > Logs > Log Group > Encryption at Rest
resource "turbot_policy_setting" "aws_logs_log_group_encryption_at_rest" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/aws-logs#/policy/types/logGroupEncryptionAtRest"
  value    = "Check: AWS SSE or higher"
  # value    = "Check: Customer managed key"
  # value    = "Check: Encryption at Rest > Customer Managed Key"
  # value    = "Enforce: AWS SSE or higher"
  # value    = "Enforce: Customer managed key"
  # value    = "Enforce: Encryption at Rest > Customer Managed Key"

}

# AWS > Logs > Log Group > Encryption at Rest > Customer Managed Key
resource "turbot_policy_setting" "aws_logs_log_group_encryption_at_rest_customer_managed_key" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/aws-logs#/policy/types/logGroupEncryptionAtRestCustomerManagedKey"
  # The KMS key ID for encryption at rest
  value = "alias/aws/ebs"
  # value    = "ddc06e04-ce5f-4995-c758-c2b6c510e8fd"
  # value    = "arn:aws:kms:us-east-1:123456789012:key/ddc06e04-ce5f-4995-c758-c2b6c510e8fd"
  # value    = "arn:aws:kms:us-east-1:123456789012:alias/aws/ebs"
}





