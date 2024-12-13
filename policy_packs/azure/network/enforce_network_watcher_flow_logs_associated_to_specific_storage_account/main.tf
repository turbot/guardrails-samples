resource "turbot_policy_pack" "main" {
  title       = "Enforce Azure Network Watcher Flow Logs Is Associated To Specific Storage Account"
  description = "Enforce network watcher flow logs is associated to specific storage account."
  akas        = ["azure_network_enforce_network_watcher_flow_logs_associated_to_specific_storage_account"]
}
