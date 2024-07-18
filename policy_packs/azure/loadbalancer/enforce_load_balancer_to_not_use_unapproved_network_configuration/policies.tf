# Azure > Load Balancer > Load Balancer > Approved
resource "turbot_policy_setting" "gcp_loadbalancerservice_loadbalancer_approved" {
  resource = turbot_smart_folder.main.id
  type     = "tmod:@turbot/azure-loadbalancer#/policy/types/loadBalancerApproved"
  value    = "Check: Approved"
  # value    = "Enforce: Delete unapproved if new"
}

# Azure > Load Balancer > Load Balancer > Approved > Usage
resource "turbot_policy_setting" "gcp_loadbalancerservice_loadbalancer_approved_custom" {
  resource = turbot_smart_folder.main.id
  type     = "tmod:@turbot/azure-loadbalancer#/policy/types/loadBalancerApprovedCustom"
  template_input = <<EOT
  {
    resource {
      natrules: get(path: "inboundNatRules")
      lbrules: get(path: "loadBalancingRules")
    }
    # Your list of bad ports
    badPorts: constant(value: "['80', '21', '25']")
  }
  EOT
  template = <<EOT
  {% set badPortFound = "False" %}

  {%- for item in $.resource.natrules%}
    {% if item.backendPort in $.badPorts or item.frontendPort in $.badPorts%}
      {% set badPortFound = "True" %}
    {% endif %}
  {% endfor %}

  {%- for item in $.resource.lbrules%}
    {% if item.backendPort in $.badPorts or item.frontendPort in $.badPorts%}
      {% set badPortFound = "True" %}
    {% endif %}
  {% endfor %}

  {% if badPortFound == "True" %}

    {%- set data = {
        "title": "Network Configuration"
        "result": "Not approved"
        "message": "Network Configuration is not approved"
    } -%}

  {% else %}

    {%- set data = {
        "title": "Network Configuration"
        "result": "Approved"
        "message": "Network Configuration is approved"
    } -%}

  {% endif %}

  {{ data | json }}
  EOT
}
