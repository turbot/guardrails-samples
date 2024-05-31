# Smart Folder Definition
resource "turbot_smart_folder" "gcp_firewall_logging" {
  title       = var.smart_folder_title
  description = var.smart_folder_description
  parent      = var.smart_folder_parent_resource
}

# To get started, the baseline assumes a Check: mode to start
# Edit the template below to meet your requirements.
 
# GCP > Network > Firewall > Logging
# https://turbot.com/v5/mods/turbot/gcp-network/inspect#/policy/types/firewallLogging
resource "turbot_policy_setting" "gcp_firewall_logging_enable" {
  resource = turbot_smart_folder.gcp_firewall_logging.id
  type     = "tmod:@turbot/gcp-network#/policy/types/firewallLogging"
  value    = "Check: Enabled"
  # "Skip"
  # "Check: Disabled"
  # "Check: Enabled"
  # "Enforce: Disabled"
  # "Enforce: Enabled"
}