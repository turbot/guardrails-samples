# Azure > Network > Virtual Network > Approved
resource "turbot_policy_setting" "azure_network_virtual_network_approved" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/azure-network#/policy/types/virtualNetworkApproved"
  value    = "Check: Approved"
}

# Azure > Network > Virtual Network > Approved > Usage
resource "turbot_policy_setting" "azure_network_virtual_network_approved_usage" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/azure-network#/policy/types/virtualNetworkApprovedUsage"
  value    = "Approved"
}

# Azure > Network > Virtual Network > Approved > Custom
resource "turbot_policy_setting" "azure_network_virtual_network_approved_custom" {
  resource       = turbot_policy_pack.main.id
  type           = "tmod:@turbot/azure-network#/policy/types/virtualNetworkApprovedCustom"
  template_input = <<-EOT
    - |
      {
        resource {
          name:get(path:"name")
          flowLogs:get(path:"flowLogs")
        }
      }
    - |
      {
        resource {
          name:get(path:"name")
          flowLogs:get(path:"flowLogs")
        }
        resources(filter:"resourceTypeId:tmod:@turbot/azure-networkwatcher#/resource/types/flowLog $.id:'{{ $.resource.flowLogs[0].id }}'"){
          items {
            enabled:get(path:"enabled")
            id:get(path:"id")
            name:get(path:"name")
          }
        }
      }
    EOT
  template       = <<-EOT
    {%- set virtualNetworkFlowLogs = $.resource.flowLogs %}
    {%- set subscriptionFlowLogs = $.resources.items %}

    {%- if virtualNetworkFlowLogs and virtualNetworkFlowLogs | length > 0 %}
      {%- for vnetFlowLog in virtualNetworkFlowLogs %}
        {%- set matchedFlowLog = null %}
        {%- for subscriptionFlowLog in subscriptionFlowLogs %}
          {%- if subscriptionFlowLog.id == vnetFlowLog.id %}
            {%- set matchedFlowLog = subscriptionFlowLog %}
          {%- endif %}
        {%- endfor %}
        
        {%- if matchedFlowLog %}
          {%- if matchedFlowLog.enabled %}
            - title: Flow Log
              result: Approved
              message: "Flow log '{{ matchedFlowLog.name }}' is configured"
          {%- else %}
            - title: Flow Log
              result: Not approved
              message: "Flow log '{{ matchedFlowLog.name }}' is configured but currently disabled"
          {%- endif %}
        {%- else %}
          - title: Flow Log
            result: Not approved
            message: "Flow log is configured, but the resource '{{ vnetFlowLog.id.split('/').pop() }}' is not in CMDB. Please run the Flow Log Discovery controls within the Subscription"
        {%- endif %}
      {%- endfor %}
    {%- else %}
      - title: Flow Log
        result: Not approved
        message: "Flow log is not configured"
    {%- endif %}
    EOT
}
