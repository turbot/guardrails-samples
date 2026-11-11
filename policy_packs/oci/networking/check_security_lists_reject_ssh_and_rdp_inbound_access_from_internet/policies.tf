# OCI > Networking > Security List > Allowed > Custom
resource "turbot_policy_setting" "oci_networking_security_list_allowed_custom" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/oci-networking#/policy/types/securityListAllowedCustom"
  value    = "Check: Allowed"
}

# OCI > Networking > Security List > Allowed > Custom > Rules
resource "turbot_policy_setting" "oci_networking_security_list_allowed_custom_rules" {
  resource       = turbot_policy_pack.main.id
  type           = "tmod:@turbot/oci-networking#/policy/types/securityListAllowedCustomRules"
  template_input = <<-EOT
    {
      securityList {
        ingressSecurityRules: get(path: "ingressSecurityRules")
      }
    }
    EOT
  template       = <<-EOT
    {#- Mark each ingress rule from the internet that covers port 22 or 3389 -#}
    {%- set exposed -%}
      {%- for rule in $.securityList.ingressSecurityRules -%}
        {%- if rule.source == "0.0.0.0/0" or rule.source == "::/0" -%}
          {%- if rule.protocol == "all" -%}
            x
          {%- elif rule.protocol == "6" or rule.protocol == "17" -%}
            {%- set options = rule.tcpOptions if rule.protocol == "6" else rule.udpOptions -%}
            {%- if not options or not options.destinationPortRange -%}
              x
            {%- else -%}
              {%- set ports = options.destinationPortRange -%}
              {%- if (ports.min <= 22 and ports.max >= 22) or (ports.min <= 3389 and ports.max >= 3389) -%}
                x
              {%- endif -%}
            {%- endif -%}
          {%- endif -%}
        {%- endif -%}
      {%- endfor -%}
    {%- endset -%}

    {%- if $.securityList.ingressSecurityRules == null -%}

      {%- set data = {
          "title": "SSH and RDP",
          "result": "Skip",
          "message": "No data for security list yet"
      } -%}

    {%- elif exposed | trim -%}

      {%- set data = {
          "title": "SSH and RDP",
          "result": "Not allowed",
          "message": "Security list allows SSH or RDP ingress from the internet"
      } -%}

    {%- else -%}

      {%- set data = {
          "title": "SSH and RDP",
          "result": "Allowed",
          "message": "Security list does not allow SSH or RDP ingress from the internet"
      } -%}

    {%- endif -%}
    {{ data | json }}
    EOT
}
