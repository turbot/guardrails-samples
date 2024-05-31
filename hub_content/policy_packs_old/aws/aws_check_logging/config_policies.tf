# AWS Config Recording setup by Turbot
# Commented out since it will always error without Turbot Enforcing its own configs
# 2.05 Ensure AWS Config is enabled in all regions (Scored)

# AWS > Config > Configuration Recording
# https://turbot.com/v5/mods/turbot/aws-config/inspect#/policy/types/configurationRecording
resource "turbot_policy_setting" "configurationRecording" {
  count = var.enable_configuration_recording ? 1 : 0
  resource = turbot_smart_folder.aws_logging.id
  type     = "tmod:@turbot/aws-config#/policy/types/configurationRecording"
  value    = "Check: Configured"
  #   Skip
  #   Check: Configured
  #   Check: Not Configured
  #   Enforce: Configured
  #   Enforce: Not Configured
}

