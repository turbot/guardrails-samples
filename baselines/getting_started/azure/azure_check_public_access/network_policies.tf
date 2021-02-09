# Approve / Reject Security Group Ingress Rules
# Can also apply to Egress rules, focus of baseline is on inbound
# More Info: https://turbot.com/v5/docs/guides/managing-policies/OCL
# More Info on OCL: https://turbot.com/v5/docs/reference/ocl

# Azure > Network > Network Security Group > Ingress Rules > Approved
# https://turbot.com/v5/mods/turbot/azure-network/inspect#/policy/types/networkSecurityGroupIngressRulesApproved
resource "turbot_policy_setting" "azure_network_network_security_group_ingress_rules_approved" {
  count    = var.enable_network_security_group_ingress_rules_approved_policies ? 1 : 0
  resource = turbot_smart_folder.azure_public_access.id
  type     = "tmod:@turbot/azure-network#/policy/types/networkSecurityGroupIngressRulesApproved"
  value    = "Check: Approved"
              # "Skip"
              # "Check: Approved"
              # "Enforce: Delete unapproved"
}

# Azure > Network > Network Security Group > Ingress Rules > Approved > Rules
# https://turbot.com/v5/mods/turbot/azure-network/inspect#/policy/types/networkSecurityGroupIngressRulesApprovedRules
resource "turbot_policy_setting" "azure_network_network_security_group_ingress_rules_approved_rules" {
  count    = var.enable_network_security_group_ingress_rules_approved_rules_policies ? 1 : 0
  resource = turbot_smart_folder.azure_public_access.id
  type     = "tmod:@turbot/azure-network#/policy/types/networkSecurityGroupIngressRulesApprovedRules"
  value    = <<EOT
  REJECT $.turbot.ports.+:*,22,3389 $.sourceAddressPrefix:*,0.0.0.0/0,::/0
  $.access:Allow

  APPROVE $.turbot.ports.+:*,22,3389 $.sourceAddressPrefix:*,0.0.0.0/0,::/0
  $.access:Deny

  APPROVE $.turbot.ports.+:22,3389 $.sourceAddressPrefix:<=10.0.0.0/8,::/0
  $.access:Allow

  REJECT *
EOT
}

# Azure > Network > Public IP Address > Approved > Usage
# https://turbot.com/v5/mods/turbot/azure-network/inspect#/policy/types/publicIpAddressApprovedUsage
resource "turbot_policy_setting" "azure_network_public_ip_address_approved_usage" {
  count    = var.enable_network_public_ip_address_approved_usage_policies ? 1 : 0
  resource = turbot_smart_folder.azure_public_access.id
  type     = "tmod:@turbot/azure-network#/policy/types/publicIpAddressApprovedUsage"
  value    = "Not approved"
}
