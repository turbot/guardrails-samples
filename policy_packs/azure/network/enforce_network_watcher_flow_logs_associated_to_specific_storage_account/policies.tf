# Azure > Network Watcher > Flow Log > Approved
resource "turbot_policy_setting" "azure_networkwatcherservice_flowlog_approved" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/azure-networkwatcher#/policy/types/flowLogApproved"
  value    = "Check: Approved"
  # value    = "Enforce: Delete unapproved if new"
}

# Azure > Network Watcher > Flow Log > Approved > Custom
resource "turbot_policy_setting" "azure_networkwatcherservice_flowlog_approved_custom" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/azure-networkwatcher#/policy/types/flowLogApprovedCustom"
  template_input = <<-EOT
    {
      resource {
        storageId: get(path: "storageId")
      }
    }
  EOT
  template = <<-EOT
    {%- set approvedAccounts = [
      "/subscriptions/3510ae4d-530b-497d-8f30-53b9616fc6c1/resourceGroups/test_madhushree/providers/Microsoft.Storage/storageAccounts/testeastus2storageacc",
      "/subscriptions/3510ae4d-530b-497d-8f30-53b9616fc6c1/resourceGroups/test_madhushree/providers/Microsoft.Storage/storageAccounts/anotherapprovedstorageacc"
    ] -%}

    {%- set data = {
        "title": "Storage Account",
        "result": "Skip",
        "message": "No storage account data available"
    } -%}

    {%- if $.resource.storageId in approvedAccounts -%}

      {%- set data = {
          "title": "Storage Account",
          "result": "Approved",
          "message": "Flow log is using an approved storage account"
      } -%}

    {%- elif $.resource.storageId != null -%}

      {%- set data = {
          "title": "Storage Account",
          "result": "Not approved",
          "message": "Flow log is using an unapproved storage account"
      } -%}

    {%- endif -%}

    {{ data | json }}
  EOT
}
