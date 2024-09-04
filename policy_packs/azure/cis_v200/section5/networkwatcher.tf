# Azure > Network Watcher > Flow Log > Approved
resource "turbot_policy_setting" "azure_networkwatcher_flowlog_approved" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/azure-networkwatcher#/policy/types/flowLogApproved"
  note     = "Azure CIS v2.0.0 - Control: 5.1.6"
  value    = "Check: Approved"
  # value    = "Enforce: Delete unapproved if new"
}

# Azure > Network Watcher > Flow Log > Approved > Custom
resource "turbot_policy_setting" "azure_networkwatcher_flowlog_approved_custom" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/azure-networkwatcher#/policy/types/flowLogApprovedCustom"
  note     = "Azure CIS v2.0.0 - Control: 5.1.6"

  template_input = <<-EOT
    {
      flowLog {
        logAnalyticsEnabled: get(path: "flowAnalyticsConfiguration.networkWatcherFlowAnalyticsConfiguration.enabled")
        targetResourceId: get(path: "targetResourceId")
      }
    }
  EOT
  template       = <<-EOT
    {%- if $.flowLog.logAnalyticsEnabled and "networkSecurityGroups" in $.flowLog.targetResourceId -%}

      {%- set data = {
          "title": "Flow Logging to Log Analytics",
          "result": "Approved",
          "message": "Flow logs are captured and sent to Log Analytics"
      } -%}

    {%- elif not $.flowLog.logAnalyticsEnabled or $.flowLog.targetResourceId == "" or $.flowLog.targetResourceId == null -%}

      {%- set data = {
          "title": "Flow Logging to Log Analytics",
          "result": "Not approved",
          "message": "Flow logs are not captured and sent to Log Analytics"
      } -%}

    {%- else -%}

      {%- set data = {
          "title": "Flow Logging to Log Analytics",
          "result": "Skip",
          "message": "No data for flow log yet"
      } -%}

    {%- endif -%}

    {{ data | json }}
  EOT
}
