# AWS > EC2 > Account Attributes > EBS Encryption by Default
resource "turbot_policy_setting" "aws_ec2_account_attribute_encryption_by_default" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/aws-ec2#/policy/types/ec2AccountAttributesEbsEncryptionByDefault"
  value    = "Check: AWS managed key or higher"
  # value    = "Check: Encryption at Rest > Customer Managed Key"
  # value    = "Enforce: AWS managed key"
  # value    = "Enforce: Encryption at Rest > Customer Managed Key"
}

# AWS > EC2 > Account Attributes > EBS Encryption by Default > Customer Managed Key
resource "turbot_policy_setting" "aws_ec2_account_attribute_encryption_by_default_customer_managed_key" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/aws-ec2#/policy/types/ec2AccountAttributesEbsEncryptionByDefaultCustomerManagedKey"
  # Your customer managed key alias, id, or ARN
  value    = "alias/aws/acmekey"
  # value    = "ddc06e04-ce5f-4995-c758-c2b6c510ef4d"
  # value    = "arn:aws:kms:us-east-1:123456789012:key/ddc06e04-ce5f-4995-c758-c2b6c510ef4d"
}
