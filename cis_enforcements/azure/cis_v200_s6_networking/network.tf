# Azure > Network > Network Security Group > Ingress Rules > Approved
resource "turbot_policy_setting" "azure_network_nsg_ingress_rules_approved" {
  resource = turbot_smart_folder.pack.id
  type     = "tmod:@turbot/azure-network#/policy/types/networkSecurityGroupIngressRulesApproved"
  note     = "Azure CIS v2.0.0 - Controls: 6.1"
  value    = "Check: Approved"
  # value    = "Enforce: Delete unapproved"
}

# Azure > Network > Network Security Group > Ingress Rules > Approved > Rules
resource "turbot_policy_setting" "azure_network_nsg_ingress_rules_approved" {
  resource = turbot_smart_folder.pack.id
  type     = "tmod:@turbot/azure-network#/policy/types/networkSecurityGroupIngressRulesApproved"
  note     = "Azure CIS v2.0.0 - Controls: 6.1"
  value    = <<EOT

    REJECT $.turbot.fromPort:=3389 

  EOT
}
