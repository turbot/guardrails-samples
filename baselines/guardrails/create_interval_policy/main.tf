# https://hub.guardrails.turbot.com/mods/turbot/policies/turbot/interval
resource "turbot_policy_setting" "turbot_interval_snapshot_cmdb" {
  resource = "tmod:@turbot/azure-compute#/control/types/snapshotCmdb"
  type     = "tmod:@turbot/turbot#/policy/types/interval"
  value    = "days: 1"
}

# https://hub.guardrails.turbot.com/mods/turbot/policies/turbot/interval
resource "turbot_policy_setting" "turbot_interval_snapshot_cmdb" {
  resource = "tmod:@turbot/azure-compute#/control/types/snapshotDiscovery"
  type     = "tmod:@turbot/turbot#/policy/types/interval"
  value    = "days: 1"
}