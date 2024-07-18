# GCP > Network > Firewall > Approved
resource "turbot_policy_setting" "gcp_network_firewall_approved" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/gcp-network#/policy/types/firewallApproved"
  value    = "Check: Approved"
  # value    = "Enforce: Delete unapproved if new"
}

# GCP > Network > Firewall > Approved > Custom
resource "turbot_policy_setting" "gcp_network_firewall_approved_custom" {
  resource       = turbot_policy_pack.main.id
  type           = "tmod:@turbot/gcp-network#/policy/types/firewallApprovedCustom"
  template_input = <<-EOT
    {
      resource {
        direction: get(path: "direction")
        allowed: get(path: "allowed")
        denied: get(path: "denied")
      }
    }
    EOT
  template       = <<-EOT
    {% if $.resource.direction == "EGRESS" and not $.resource.allowed  -%}
    - title: "Egress Rules"
      result: Approved
      message: "Does not contain any egress allowed rules"
    {%- else -%}
    - title: "Egress Rules"
      result: Not approved
      message: "Contains egress allowed rules"
    {%- endif %}
    EOT
}
