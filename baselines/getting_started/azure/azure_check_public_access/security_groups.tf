# Approve / Reject Security Group Ingress Rules
# Can also apply to Egress rules, focus of baseline is on inbound
# Examples are just a starting point, 
# More Info: https://turbot.com/v5/docs/guides/managing-policies/OCL
# More Info on OCL: https://turbot.com/v5/docs/reference/ocl

## Azure Network Security Group Ingress Rules
resource "turbot_policy_setting" "azure_network_network_security_group_ingress_rules_approved" {
  resource = turbot_smart_folder.azure_public_access.id
  type     = "tmod:@turbot/azure-network#/policy/types/networkSecurityGroupIngressRulesApproved"
  value    = "Check: Approved"
                    # "Skip"
                    # "Check: Approved"
                    # "Enforce: Delete unapproved"
}

resource "turbot_policy_setting" "azure_network_network_security_group_ingress_rules_approved_rules" {
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