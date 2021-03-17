# Approve / Reject Security Group Ingress Rules
# Can also apply to Egress rules, focus of baseline is on inbound
# Examples are just a starting point, 
# More Info: https://turbot.com/v5/docs/guides/managing-policies/OCL
# More Info on OCL: https://turbot.com/v5/docs/reference/ocl

# GCP > Network > Firewall > Ingress Rules > Approved
# https://turbot.com/v5/mods/turbot/gcp-network/inspect#/policy/types/firewallIngressRulesApproved
resource "turbot_policy_setting" "gcp_network_firewall_ingress_rules_approved" {
  count    = var.enable_network_policies ? 1 : 0
  resource = turbot_smart_folder.gcp_public_access.id
  type     = "tmod:@turbot/gcp-network#/policy/types/firewallIngressRulesApproved"
  value    = "Check: Approved"
  # "Skip"
  # "Check: Approved"
  # "Enforce: Delete unapproved"
}

# GCP > Network > Firewall > Ingress Rules > Approved > Rules
# https://turbot.com/v5/mods/turbot/gcp-network/inspect#/policy/types/firewallIngressRulesApprovedRules
resource "turbot_policy_setting" "gcp_network_firewall_ingress_rules_approved_rules" {
  count    = var.enable_network_policies ? 1 : 0
  resource = turbot_smart_folder.gcp_public_access.id
  type     = "tmod:@turbot/gcp-network#/policy/types/firewallIngressRulesApprovedRules"
  value    = <<EOT
  REJECT $.sourceRanges:0.0.0.0/0,::/0
  APPROVE *
EOT
}
