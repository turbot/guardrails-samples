# GCP > SQL > Instance > Binary Log
# https://turbot.com/v5/mods/turbot/gcp-sql/inspect#/control/types/binaryLogEnabled
resource "turbot_policy_setting" "gcp_instance_binary_log" {
  count    = var.enable_instance_binary_log_policies ? 1 : 0
  resource = turbot_smart_folder.gcp_logging.id
  type     = "tmod:@turbot/gcp-sql#/policy/types/binaryLogEnabled"
  value    = "Check: Enabled"
            # "Skip"
            # "Check: Disabled"
            # "Check: Enabled"
            # "Enforce: Disabled"
            # "Enforce: Enabled"
}
