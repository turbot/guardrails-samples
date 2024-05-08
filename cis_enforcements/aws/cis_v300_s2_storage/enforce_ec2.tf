# # AWS > EC2 > EBS > Ensure Volume Encryption
# resource "turbot_policy_setting" "aws_ec2_ebs_encryption" {
#   resource = turbot_smart_folder.aws_cis_v300_s2_storage.id
#   type     = "tmod:@turbot/aws-ec2#/policy/types/volumeEncryption"
#   value    = "Enforce: Enabled"
#   note     = "AWS CIS v3.0.0 - Control: 2.2.1"
# }