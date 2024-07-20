# AWS > EC2 > Account Attributes > EBS Encryption by Default
resource "turbot_policy_setting" "aws_ec2_account_attribute_encryption_by_default" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/aws-ec2#/policy/types/ec2AccountAttributesEbsEncryptionByDefault"
  value    = "Check: AWS managed key or higher"
  # value    = "Check: AWS managed key"
  # value    = "Check: AWS managed key or higher"
  # value    = "Check: Customer managed key"
  # value    = "Check: Encryption at Rest > Customer Managed Key"
  # value    = "Enforce: AWS managed key"
  # value    = "Enforce: AWS managed key or higher"
  # value    = "Enforce: Customer managed key"
  # value    = "Enforce: Encryption at Rest > Customer Managed Key"
}
