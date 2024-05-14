# AWS > Config > Configuration Recording
resource "turbot_policy_setting" "aws_config_configuration_recording" {
  resource = turbot_smart_folder.aws_cis_v300_s3_logging.id
  type     = "tmod:@turbot/aws-config#/policy/types/configurationRecording"
  note     = "AWS CIS v3.0.0 - Controls: 3.3"
  value    = "Check: Configured"
  # value    = "Enforce: Configured"
}
