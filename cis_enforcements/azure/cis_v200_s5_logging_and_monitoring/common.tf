# Smart Folder
resource "turbot_smart_folder" "azure_cis_v200_s5_monitoring" {
  parent      = "tmod:@turbot/turbot#/"
  title       = "Azure CIS v2.0.0 - Section 5 - Logging and Monitoring"
  description = "This section contains recommendations for configuring Azure logging and monitoring features."
}

# Azure > Monitor > Enabled
resource "turbot_policy_setting" "azure_monitor_enabled" {
  resource = turbot_smart_folder.azure_cis_v200_s5_monitoring.id
  type     = "tmod:@turbot/azure-monitor#/policy/types/monitorEnabled"
  value    = "Enabled"
}
