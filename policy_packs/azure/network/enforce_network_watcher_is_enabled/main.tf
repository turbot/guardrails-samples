resource "turbot_policy_pack" "main" {
  title       = "Azure Network Enforce Network Watcher Is Enabled"
  description = "Enforce that Azure Network Watcher is enabled for locations."
  akas        = ["azure_network_enforce_network_watcher_is_enabled"]
}
