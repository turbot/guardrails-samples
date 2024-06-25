# GCP > Network > Firewall > Ingress Rules > Approved
resource "turbot_policy_setting" "gcp_network_firewall_ingress_rules_approved" {
  resource = turbot_smart_folder.main.id
  type     = "tmod:@turbot/gcp-network#/policy/types/firewallIngressRulesApproved"
  value    = "Check: Approved"
  # value  = "Enforce: Delete unapproved"
}

# GCP > Network > Firewall > Ingress Rules > Approved > Rules
resource "turbot_policy_setting" "gcp_network_firewall_ingress_rules_approved_rules" {
  resource = turbot_smart_folder.main.id
  type     = "tmod:@turbot/gcp-network#/policy/types/firewallIngressRulesApprovedRules"
  value    = <<-EOT
    # Reject ports 21(FTP), 22(SSH), 25(SMTP), 80(HTTP), 443(HTTPS), 3389(RDP)
    REJECT $.turbot.ports.+:21,22,25,80,443,3389 $.turbot.cidr:0.0.0.0/0,::/0

    # Reject if IP protocol is all
    REJECT $.turbot.protocol:all $.turbot.cidr:0.0.0.0/0,::/0

    # Reject port range sizes greater than 1
    REJECT $.turbot.portRangeSize:>1

    # Approve unmatched rules
    APPROVE *
    EOT
}
