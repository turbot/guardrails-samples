
# Azure > Network > Network Security Group > Ingress Rules > Approved
resource "turbot_policy_setting" "azure_network_network_security_group_ingress_rules_approved_corrective" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/azure-network#/policy/types/networkSecurityGroupIngressRulesApproved"
  value    = "Enforce: Delete unapproved"
}

# Azure > Network > Network Security Group > Ingress Rules > Approved > Rules
resource "turbot_policy_setting" "azure_network_network_security_group_ingress_rules_approved_rules_corrective" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/azure-network#/policy/types/networkSecurityGroupIngressRulesApprovedRules"
  value    = <<-EOT
    # Allow ports 22,443,3389 from individual IP addresses (bitmask = 32)
    APPROVE $.turbot.fromPort:="22" $.turbot.toPort:="22" $.turbot.bitmaskLength:>=32
    APPROVE $.turbot.fromPort:="443" $.turbot.toPort:="443" $.turbot.bitmaskLength:>=32
    APPROVE $.turbot.fromPort:="3389" $.turbot.toPort:="3389" $.turbot.bitmaskLength:>=32

    # Approve allowed CIDR ranges
    APPROVE $.turbot.cidr:<=15.46.12.0/22
    APPROVE $.turbot.cidr:<=104.29.0.0/20
    APPROVE $.turbot.cidr:<=10.0.0.0/8
    APPROVE $.turbot.cidr:<=172.16.0.0/12
    APPROVE $.turbot.cidr:<=192.168.0.0/16

    # Reject unmatched rules
    REJECT *
    EOT
}
