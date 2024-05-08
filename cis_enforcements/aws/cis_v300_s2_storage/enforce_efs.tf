# # AWS > EFS > Ensure Encryption
# resource "turbot_policy_setting" "aws_efs_encryption" {
#   resource = turbot_smart_folder.aws_cis_v300_s2_storage.id
#   type     = "tmod:@turbot/aws-efs#/policy/types/encryption"
#   value    = "Enforce: Enabled"
#   note     = "AWS CIS v3.0.0 - Control: 2.4.1"
# }