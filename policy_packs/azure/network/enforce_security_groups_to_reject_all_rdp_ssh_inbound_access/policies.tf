# Azure > Network > Network Security Group > Approved
resource "turbot_policy_setting" "azure_network_security_group_ingress_rules_approved" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/azure-network#/policy/types/networkSecurityGroupIngressRulesApproved"
  value    = "Check: Approved"
  # value    = "Enforce: Delete unapproved"
}

# Azure > Network > Network Security Group > Ingress Rules > Approved > Custom
resource "turbot_policy_setting" "azure_network_security_group_ingress_rules_approved_rules" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/azure-network#/policy/types/networkSecurityGroupIngressRulesApprovedRules"
  template = <<-EOT
    {#- Reject ports 22, 3389 -#}
    REJECT $.turbot.ports.+:*,22,3389 $.access:Allow

    {#- Reject any inbound from internet -#}
    REJECT $.turbot.cidr:=0.0.0.0/0

    {#- Approve unmatched rules -#}
    APPROVE *
  EOT
}
