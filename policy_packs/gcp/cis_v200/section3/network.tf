# GCP > Network > Network > Approved
resource "turbot_policy_setting" "gcp_network_approved" {
  resource = turbot_smart_folder.main.id
  type     = "tmod:@turbot/gcp-network#/policy/types/networkApproved"
  note     = "GCP CIS v2.0.0 - Control: 3.1 and 3.2"
  value    = "Check: Approved"
  # value    = "Enforce: Delete unapproved if new"
}

# GCP > Network > Network > Approved > Custom
resource "turbot_policy_setting" "gcp_network_approved_custom" {
  resource       = turbot_smart_folder.main.id
  type           = "tmod:@turbot/gcp-network#/policy/types/networkApprovedCustom"
  note           = "Azure CIS v2.0.0 - Control: 3.1 and 3.2"
  template_input = <<-EOT
    {
      network {
        name: get(path: "name")
        autoCreateSubnetworks: get(path: "autoCreateSubnetworks")
      }
    }
  EOT
  template       = <<-EOT
    {%- set results = [] -%}

    {%- if $.network.name == "default" -%}

      {%- set data = {
          "title": "Default Network",
          "result": "Not approved",
          "message": "This is a default network"
      } -%}

    {%- elif $.network.name != "default" -%}

      {%- set data = {
          "title": "Default Network",
          "result": "Approved",
          "message": "This is not a default network"
      } -%}

    {%- else -%}

      {%- set data = {
          "title": "Default Network",
          "result": "Skip",
          "message": "No data for network yet"
      } -%}

    {%- endif -%}

    {%- set results = results.concat(data) -%}

    {%- if $.network.autoCreateSubnetworks == null -%}

      {%- set data = {
          "title": "Legacy Network",
          "result": "Not approved",
          "message": "This is a legacy network"
      } -%}

    {%- elif $.network.autoCreateSubnetworks != null -%}

      {%- set data = {
          "title": "Legacy Network",
          "result": "Approved",
          "message": "This is not a legacy network"
      } -%}

    {%- else -%}

      {%- set data = {
          "title": "Legacy Network",
          "result": "Skip",
          "message": "No data for legacy network yet"
      } -%}

    {% endif -%}

    {% set results = results.concat(data) -%}

    {{ results | json }}
  EOT
}

# GCP > Network > Firewall > Ingress Rules > Approved
resource "turbot_policy_setting" "gcp_network_firewall_ingress_rules_approved" {
  resource = turbot_smart_folder.main.id
  type     = "tmod:@turbot/gcp-network#/policy/types/firewallIngressRulesApproved"
  note     = "GCP CIS v2.0.0 - Control: 3.6 and 3.7"
  value    = "Check: Approved"
  # value    = "Enforce: Delete unapproved"
}

# GCP > Network > Firewall > Ingress Rules > Approved Rules
resource "turbot_policy_setting" "gcp_network_firewall_ingress_rules_approved_rules" {
  resource = turbot_smart_folder.main.id
  type     = "tmod:@turbot/gcp-network#/policy/types/firewallIngressRulesApprovedRules"
  note     = "GCP CIS v2.0.0 - Control: 3.6 and 3.7"
  value    = <<EOT
    REJECT $.turbot.cidr:0.0.0.0/0 $.turbot.ports=22,3389

    APPROVE *
  EOT
}

# GCP > Network > SSL Policy > Minimum TLS Version
resource "turbot_policy_setting" "gcp_network_ssl_policy_minimum_tls_version" {
  resource = turbot_smart_folder.main.id
  type     = "tmod:@turbot/gcp-network#/policy/types/sslPolicyMinimumTlsVersion"
  note     = "GCP CIS v2.0.0 - Control: 3.9"
  value    = "Check: TLS 1.2"
  # value    = "Enforce: TLS 1.2"
}

# GCP > Network > SSL Policy > Profile
resource "turbot_policy_setting" "gcp_network_ssl_policy_profile" {
  resource = turbot_smart_folder.main.id
  type     = "tmod:@turbot/gcp-network#/policy/types/sslPolicyProfile"
  note     = "GCP CIS v2.0.0 - Control: 3.9"
  value    = "Check: Restricted"
  # value    = "Enforce: Restricted"
}

# GCP > Network > Firewall > Approved
resource "turbot_policy_setting" "gcp_network_firewall_approved" {
  resource = turbot_smart_folder.main.id
  type     = "tmod:@turbot/gcp-network#/policy/types/firewallApproved"
  note     = "GCP CIS v2.0.0 - Control: 3.10"
  value    = "Check: Approved"
  # value    = "Enforce: Delete unapproved if new"
}

# GCP > Network > Firewall > Approved > Custom
resource "turbot_policy_setting" "gcp_network_firewall_approved_custom" {
  resource       = turbot_smart_folder.main.id
  type           = "tmod:@turbot/gcp-network#/policy/types/firewallApprovedCustom"
  note           = "Azure CIS v2.0.0 - Control: 3.10"
  template_input = <<-EOT
    {
      firewall {
        sourceRanges: get(path: "sourceRanges")
        allowed: get(path: "allowed")
      }
    }
  EOT
  template       = <<-EOT
    {%- set results = [] -%}

    {%- if $.firewall.sourceRanges != null -%}

      {%- set allowedSourceIPRanges = ["35.235.240.0/20", "130.211.0.0/22", "35.191.0.0/16"] -%}

      {%- set allRequiredIpExist = true -%}

      {%- for ip in allowedSourceIPRanges -%}

        {%- if ip not in $.firewall.sourceRanges -%}

          {%- set allRequiredIpExist = false -%}

        {%- endif -%}

      {%- endfor -%}

      {%- if allRequiredIpExist -%}

        {%- set data = {
            "title": "Source Ranges",
            "result": "Approved",
            "message": "All required source ranges are defined"
        } -%}

      {%- else -%}

        {%- set data = {
            "title": "Source Ranges",
            "result": "Not approved",
            "message": "All required source ranges are not defined"
        } -%}

      {%- endif -%}

      {% set results = results.concat(data) -%}

    {%- else -%}

      {%- set data = {
          "title": "Source Ranges",
          "result": "Skip",
          "message": "No data for source ranges yet"
      } -%}

      {% set results = results.concat(data) -%}

    {%- endif -%}

    {%- if $.firewall.allowed != null -%}

      {%- set desiredPorts = ["22", "80", "443", "3389"] -%}

      {%- set allowProtocolsAndPorts = false -%}

      {%- for allow in $.firewall.allowed -%}

        {%- if allow.IPProtocol == "tcp" and allow.ports is defined -%}

          {%- for port in allow.ports -%}

            {%- if port in desiredPorts -%}

              {%- set allowProtocolsAndPorts = true -%}

            {%- endif -%}

          {%- endfor -%}

        {%- endif -%}

      {%- endfor -%}

      {%- if allowProtocolsAndPorts -%}

        {%- set data = {
            "title": "Allowed Ports",
            "result": "Approved",
            "message": "Required ports are allowed"
        } -%}

      {%- else -%}

        {%- set data = {
            "title": "Allowed Ports",
            "result": "Not approved",
            "message": "Required ports are not allowed"
        } -%}

      {%- endif -%}

      {% set results = results.concat(data) -%}

    {%- else -%}

      {%- set data = {
          "title": "Allowed Ports",
          "result": "Skip",
          "message": "No data for allowed ports yet"
      } -%}

      {% set results = results.concat(data) -%}

    {%- endif -%}

    {{ results | json }}
  EOT
}
