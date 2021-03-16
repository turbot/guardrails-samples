# Check for GCP Address Network Service tiers for cost savings
# Note: GCP Address Approved may already be set by another baseline
# Since the baselines are set in seperate Smart Folders there will not be a conflict

# GCP > Network > Address > Approved
# https://turbot.com/v5/mods/turbot/gcp-network/inspect#/policy/types/addressApproved
resource "turbot_policy_setting" "gcp_network_address_approved" {
  count    = var.enable_network_policies ? 1 : 0
  resource = turbot_smart_folder.gcp_cost_controls.id
  type     = "tmod:@turbot/gcp-network#/policy/types/addressApproved"
  value    = "Check: Approved"
  # Skip
  # Check: Approved
  # Enforce: Delete unapproved if new
}

# GCP > Network > Address > Approved > Network Tier
# https://turbot.com/v5/mods/turbot/gcp-network/inspect#/policy/types/addressApprovedNetworkTier
resource "turbot_policy_setting" "gcp_address_approved_network_tier" {
  count    = var.enable_network_policies ? 1 : 0
  resource = turbot_smart_folder.gcp_cost_controls.id
  type     = "tmod:@turbot/gcp-network#/policy/types/addressApprovedNetworkTier"
  value    = "Approved if standard"
  # Skip
  # Approved if standard
  # Approved if premium
}
