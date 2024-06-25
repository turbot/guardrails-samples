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
    {%- if $.network.name != "default" -%}

      {%- set data = { 
          "title": "Default Network",
          "result": "Approved",
          "message": "Project does not use a default network"
      } -%}

    {%- elif $.network.name == "default" -%}

      {%- set data = { 
          "title": "Default Network",
          "result": "Not approved",
          "message": "Project uses a default network"
      } -%}

    {%- else -%}

      {%- set data = { 
          "title": "Default Network",
          "result": "Skip",
          "message": "No data for default network yet"
      } -%}

    {%- endif -%}
    {{ data | json }}
    EOT
}
