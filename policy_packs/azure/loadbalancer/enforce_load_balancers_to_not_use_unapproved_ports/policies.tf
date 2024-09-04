# Azure > Load Balancer > Load Balancer > Approved
resource "turbot_policy_setting" "azure_loadbalancerservice_loadbalancer_approved" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/azure-loadbalancer#/policy/types/loadBalancerApproved"
  value    = "Check: Approved"
  # value    = "Enforce: Delete unapproved if new"
}

# Azure > Load Balancer > Load Balancer > Approved > Custom
resource "turbot_policy_setting" "azure_loadbalancerservice_loadbalancer_approved_custom" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/azure-loadbalancer#/policy/types/loadBalancerApprovedCustom"
  template_input = <<-EOT
    {
      resource {
        inboundNatRules: get(path: "inboundNatRules")
        loadBalancingRules: get(path: "loadBalancingRules")
      }
      # Your list of unapproved ports
      unapprovedPorts: constant(value: "['80', '22', '25']")
    }
  EOT
  template = <<-EOT
    {%- set unapprovedPortFound = "" -%}

    {%- if $.resource.inboundNatRules or $.resource.loadBalancingRules -%}

      {%- set unapprovedPortFound = "N" -%}

    {%- endif -%}
    
    {%- for item in $.resource.inboundNatRules -%}

      {%- if item.backendPort in $.unapprovedPorts or item.frontendPort in $.unapprovedPorts -%}

        {%- set unapprovedPortFound = "Y" -%}

      {%- endif -%}

    {%- endfor -%}

    {%- for item in $.resource.loadBalancingRules -%}

      {%- if item.backendPort in $.unapprovedPorts or item.frontendPort in $.unapprovedPorts -%}

        {%- set unapprovedPortFound = "Y" -%}

      {% endif %}

    {% endfor %}

    {%- if unapprovedPortFound == "Y" -%}

      {%- set data = {
          "title": "Ports",
          "result": "Not approved",
          "message": "Load balancer uses unapproved ports"
      } -%}

    {%- elif unapprovedPortFound == "N" -%}

      {%- set data = {
          "title": "Ports",
          "result": "Approved",
          "message": "Load balancer does not use unapproved ports"
      } -%}

    {%- else -%}

      {%- set data = {
          "title": "Ports",
          "result": "Skip",
          "message": "No data for load balancer yet"
      } -%}

    {%- endif -%}

    {{ data | json }}
  EOT
}
