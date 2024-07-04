# Azure > Network > Network Security Group > Ingress Rules > Approved
resource "turbot_policy_setting" "azure_network_network_security_group_ingress_rules_approved" {
  resource = turbot_smart_folder.main.id
  type     = "tmod:@turbot/azure-network#/policy/types/networkSecurityGroupIngressRulesApproved"
  note     = "Azure CIS v2.0.0 - Controls: 6.1, 6.2, 6.3, 6.4"
  value    = "Check: Approved"
  # value    = "Enforce: Delete unapproved"
}

# Azure > Network > Network Security Group > Ingress Rules > Approved > Rules
resource "turbot_policy_setting" "azure_network_network_security_group_ingress_rules_approved_rules" {
  resource = turbot_smart_folder.main.id
  type     = "tmod:@turbot/azure-network#/policy/types/networkSecurityGroupIngressRulesApprovedRules"
  note     = "Azure CIS v2.0.0 - Controls: 6.1, 6.2, 6.3, 6.4"
  value    = <<-EOT
    REJECT $.turbot.cidr:0.0.0.0/0 $.turbot.ports=22,3389,443,80
    REJECT $.turbot.cidr:0.0.0.0/0 $.turbot.protocol:udp
    APPROVE *
  EOT
}
