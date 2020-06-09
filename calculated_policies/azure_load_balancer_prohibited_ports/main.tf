# Smart Folder Definition
resource "turbot_smart_folder" "lb_prohibited_ports" {
  title       = var.smart_folder_title
  description = var.smart_folder_description
  parent      = var.smart_folder_parent_resource
}

# Azure > Load Balancer > Load Balancer > Approved
resource "turbot_policy_setting" "lb_approved" {
  resource = turbot_smart_folder.lb_prohibited_ports.id
  type     = "tmod:@turbot/azure-loadbalancer#/policy/types/loadBalancerApproved"
  value    = "Check: Approved"
}

# Azure > Load Balancer > Load Balancer > Approved > Usage
resource "turbot_policy_setting" "lb_prohibited_approved_usage" {
  resource = turbot_smart_folder.lb_prohibited_ports.id
  type     = "tmod:@turbot/azure-loadbalancer#/policy/types/loadBalancerApprovedUsage"
  # GraphQL to pull NAT and Load Balancer rules
  template_input = <<EOT
  {
    resource {
      natrules: get(path: "inboundNatRules")
      lbrules: get(path: "loadBalancingRules")
    }
  }
  EOT
  # Nunjucks template to set usage approval based on ports contained in the rules returned.
  # Edit the array in '{% set badPorts = [21,25] %}' to include the ports to be blocked.
  template = <<EOT
  {% set badPorts = [80,21,25] %}{# editable array of ports to be blocked #}
  {% set badPortFound = "False" %}
  {%- for item in $.resource.natrules%}
    {% if item.backendPort in badPorts or item.frontendPort in badPorts%}
      {% set badPortFound = "True" %}
    {% endif %}
  {% endfor %}
  {%- for item in $.resource.lbrules%}
    {% if item.backendPort in badPorts or item.frontendPort in badPorts%}
      {% set badPortFound = "True" %}
    {% endif %}
  {% endfor %}
  {% if badPortFound == "True" %}
    "Not approved"
  {% else %}
    "Approved"
  {% endif %}
  EOT
}
