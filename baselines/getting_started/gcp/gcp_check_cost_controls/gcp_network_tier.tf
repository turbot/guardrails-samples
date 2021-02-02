# Check for GCP Address Network Service tiers for cost savings
# Note: GCP Address Approved may already be set by another baseline
# Since the baselines are set in seperate Smart Folders there will not be a conflict


resource "turbot_policy_setting" "gcp_address_approved" {
  resource = turbot_smart_folder.gcp_cost_controls.id
  type     = "tmod:@turbot/gcp-network#/policy/types/addressApproved"
  value    = "Check: Approved"
          # Skip
          # Check: Approved
          # Enforce: Delete unapproved if new
}

resource "turbot_policy_setting" "gcp_address_approved_network_tier" {
  resource = turbot_smart_folder.gcp_cost_controls.id
  type     = "tmod:@turbot/gcp-network#/policy/types/addressApprovedNetworkTier"
  value    = "Approved if standard"
          # Skip
          # Approved if standard
          # Approved if premium
}
