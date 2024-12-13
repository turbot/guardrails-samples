# AWS > EMR > Block Public Access Configuration > Settings
resource "turbot_policy_setting" "aws_emr_block_public_access_configuration_settings" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/aws-emr#/policy/types/blockPublicAccessConfigurationSettings"
  value    = "Check: Enabled"
  # value    = "Enforce: Enabled"
}
