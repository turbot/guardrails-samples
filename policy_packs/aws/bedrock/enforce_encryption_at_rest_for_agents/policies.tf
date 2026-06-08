# AWS > Bedrock > Agent > Encryption at Rest
resource "turbot_policy_setting" "aws_bedrock_agent_encryption_at_rest" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/aws-bedrock#/policy/types/agentEncryptionAtRest"
  value    = "Check: Customer managed key"
  # value    = "Check: AWS owned key"
  # value    = "Enforce: Customer managed key"
  # value    = "Enforce: AWS owned key"
}

# AWS > Bedrock > Agent > Encryption at Rest > Customer Managed Key
#
# The KMS key is environment-specific. Uncomment and set this to the customer
# managed key you want agents encrypted with before switching the Encryption at
# Rest policy to Enforce: Customer managed key.
#
# resource "turbot_policy_setting" "aws_bedrock_agent_encryption_at_rest_customer_managed_key" {
#   resource = turbot_policy_pack.main.id
#   type     = "tmod:@turbot/aws-bedrock#/policy/types/agentEncryptionAtRestCustomerManagedKey"
#   value    = "<your-kms-key-arn>"
# }
