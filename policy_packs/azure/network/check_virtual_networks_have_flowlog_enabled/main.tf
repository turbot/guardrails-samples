resource "turbot_policy_pack" "main" {
  title       = "Check Azure Virtual Networks Have Flow Logs Enabled"
  description = "Ensure that logging is enabled for Azure Virtual Networks to monitor traffic and maintain security compliance."
  akas        = ["azure_network_check_virtual_networks_have_flowlog_enabled"]
}
