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
    {% if $.resource.direction == "EGRESS" and not $.resource.allowed -%}

      {%- set data = {
          "title": "Egress Rules",
          "result": "Approved",
          "message": "Firewall does not allow any egress rules"
      } -%}

    {% elif $.resource.direction == "EGRESS" and $.resource.allowed -%}

      {%- set data = {
          "title": "Egress Rules",
          "result": "Not approved",
          "message": "Firewall allows egress rules"
      } -%}

    {% else -%}

      {%- set data = {
          "title": "Egress Rules",
          "result": "Skip",
          "message": "No data for firewall yet"
      } -%}

    {%- endif -%}
    {{ data | json }}
  EOT
}
