# Azure > Network > Network Security Group > Approved
resource "turbot_policy_setting" "azure_network_security_group_ingress_rules_approved" {
  resource = turbot_smart_folder.pack.id
  type     = "tmod:@turbot/azure-network#/policy/types/networkSecurityGroupIngressRulesApproved"
  value    = "Check: Approved"
  # value    = "Enforce: Delete unapproved"
}

# Azure > Network > Network Security Group > Custom
resource "turbot_policy_setting" "azure_network_security_group_ingress_rules_approved_rules" {
  resource = turbot_smart_folder.pack.id
  type     = "tmod:@turbot/azure-network#/policy/types/networkSecurityGroupIngressRulesApprovedRules"
  template = <<-EOT
    APPROVE $.turbot.fromPort:=3389 $.turbot.toPort:=3389

    APPROVE $.turbot.fromPort:=22 $.turbot.toPort:=22

    APPROVE *
    EOT
}
