# Ensure encryption policies on KMS
# Related: KMS related to AWS CIS 2.08 Ensure rotation for customer created CMKs is enabled

resource "turbot_policy_setting" "keyRotation"{
  resource = turbot_smart_folder.aws_encryption.id
  type = "tmod:@turbot/aws-kms#/policy/types/keyRotation"
  value = "Check: Enabled"

}    

