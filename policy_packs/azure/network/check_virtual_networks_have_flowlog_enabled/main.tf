resource "turbot_policy_pack" "main" {
  title       = "Check Flow Log Is Enabled for Azure Virtual Networks"
  description = "Ensure that logging is enabled for Azure Virtual Networks to monitor traffic and maintain security compliance."
  akas        = ["azure_network_check_virtual_networks_have_flowlog_enabled"]
}
