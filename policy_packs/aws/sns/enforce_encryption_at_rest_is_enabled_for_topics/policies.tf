# AWS > SNS > Topic > Encryption at Rest
resource "turbot_policy_setting" "aws_sns_topic_encryption_at_rest" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/aws-sns#/policy/types/topicEncryptionAtRest"
  value    = "Check: AWS managed key or higher"
  # value    = "Enforce: AWS managed key"
  # value    = "Enforce: Encryption at Rest > Customer Managed Key"
}

# AWS > SNS > Topic > Encryption at Rest > Customer Managed Key
resource "turbot_policy_setting" "aws_sns_topic_encryption_at_rest_customer_managed_key" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/aws-sns#/policy/types/topicEncryptionAtRestCustomerManagedKey"
  # Add your CMK id/arn/alias below
  value = "alias/turbot/default"
}
