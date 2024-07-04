# Azure > Network Watcher > Flow Log > Retention Policy
resource "turbot_policy_setting" "azure_networkwatcher_flow_log_retention_policy" {
  resource = turbot_smart_folder.main.id
  type     = "tmod:@turbot/azure-networkwatcher#/policy/types/flowLogRetentionPolicy"
  note     = "Azure CIS v2.0.0 - Controls: 6.5"
  value    = "Check: Enabled per `Retention Policy > Days`"
  # value    = "Enforce: Enabled per `Retention Policy > Days`"
}

# Azure > Network Watcher > Flow Log > Retention Policy > Days
resource "turbot_policy_setting" "azure_networkwatcher_flow_log_retention_policy_days" {
  resource = turbot_smart_folder.main.id
  type     = "tmod:@turbot/azure-networkwatcher#/policy/types/flowLogRetentionPolicyDays"
  note     = "Azure CIS v2.0.0 - Controls: 6.5"
  value    = 90
}

# Azure > Network Watcher > Network Watcher > Approved
resource "turbot_policy_setting" "azure_network_watcher_approved" {
  resource = turbot_smart_folder.main.id
  type     = "tmod:@turbot/azure-networkwatcher#/policy/types/networkWatcherApproved"
  note     = "Azure CIS v2.0.0 - Controls: 6.6"
  value    = "Check: Approved"
  # value    = "Enforce: Delete unapproved if new"
}

# Azure > Network Watcher > Network Watcher > Approved > Custom
resource "turbot_policy_setting" "azure_network_watcher_approved_custom" {
  resource       = turbot_smart_folder.main.id
  type           = "tmod:@turbot/azure-networkwatcher#/policy/types/networkWatcherApprovedCustom"
  note           = "Azure CIS v2.0.0 - Controls: 6.6"
  template_input = <<-EOT
    {
      networkWatcher {
        provisioningState: get(path: "provisioningState")
      }
    }
    EOT
  template       = <<-EOT
    {%- if $.networkWatcher.provisioningState == "Succeeded" -%}

      {%- set data = { 
          "title": "Enabled",
          "result": "Approved",
          "message": "Network Watcher is enabled"
      } -%} 

    {%- elif $.networkWatcher.provisioningState and $.networkWatcher.provisioningState != "Succeeded" -%}

      {%- set data = { 
          "title": "Enabled",
          "result": "Not approved",
          "message": "Network Watcher is not enabled"
      } -%} 

    {%- else -%}

      {%- set data = { 
          "title": "Enabled",
          "result": "Skip",
          "message": "No data for Network Watcher yet"
      } -%}

    {%- endif -%}
    {{ data | json }}
  EOT
}
