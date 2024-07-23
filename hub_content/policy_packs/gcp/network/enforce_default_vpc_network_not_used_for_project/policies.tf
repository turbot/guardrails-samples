# GCP > Network > Network > Approved
resource "turbot_policy_setting" "gcp_network_network_approved" {
  resource = turbot_smart_folder.pack.id
  type     = "tmod:@turbot/gcp-network#/policy/types/networkApproved"
  value    = "Check: Approved"
  # value    = "Enforce: Delete unapproved if new"
}

# GCP > Network > Network > Approved > Custom
resource "turbot_policy_setting" "gcp_network_network_approved_custom" {
  resource       = turbot_smart_folder.pack.id
  type           = "tmod:@turbot/gcp-network#/policy/types/networkApprovedCustom"
  template_input = <<-EOT
    {
      network {
        name: get(path: "name")
      }
    }
    EOT
  template       = <<-EOT
    title: "Default Network"
    {%- if $.network.name == "default" -%}
      result: "Not approved"
      message: "Default network is not approved for use in the project"
    {%- else -%}
      result: "Approved"
      message: "Network is approved for use in the project"
    {%- endif -%}
    EOT
}
