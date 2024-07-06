# GCP > Network > Approved
resource "turbot_policy_setting" "gcp_network_approved" {
  resource = turbot_smart_folder.main.id
  type     = "tmod:@turbot/gcp-network#/policy/types/networkApproved"
  note     = "GCP CIS v2.0.0 - Control: 3.1"
  value    = "Check: Approved"
  # value    = "Enforce: Delete unapproved if new"
}

# GCP > Network > Approved > Custom
resource "turbot_policy_setting" "gcp_network_approved_custom" {
  resource       = turbot_smart_folder.main.id
  type           = "tmod:@turbot/gcp-network#/policy/types/networkApprovedCustom"
  note           = "Azure CIS v2.0.0 - Control: 3.1 and 3.2"
  template_input = <<-EOT
    {
      network {
        name
        autoCreateSubnetworks: get(path: "autoCreateSubnetworks")
      }
    }
  EOT
  template       = <<-EOT
    {% set results = [] -%}

    {%- if $.network -%}

      {%- if $.network.name == "default" -%}

        {%- set data = {
            "title": "Default Network",
            "result": "Not approved",
            "message": "Default network"
        } -%}

      {%- else -%}

        {%- set data = {
            "title": "Default Network",
            "result": "Approved",
            "message": "Not a default network"
        } -%}

      {%- endif -%}

      {% set results = results.concat(data) -%}

      {%- if $.network.autoCreateSubnetworks == null -%}

        {%- set data = {
            "title": "Legacy Network",
            "result": "Not approved",
            "message": "Legacy network"
        } -%}

      {%- else -%}

        {%- set data = {
            "title": "Legacy Network",
            "result": "Approved",
            "message": "Not a legacy network"
        } -%}

      {% endif -%}

      {% set results = results.concat(data) -%}

    {%- else -%}

      {%- set data = {
          "title": "Network",
          "result": "Skip",
          "message": "No data for network yet"
      } -%}

      {% set results = results.concat(data) -%}

    {% endif -%}

    {{ results | json }}
  EOT
}

# GCP > DNS > Managed Zone > Approved
resource "turbot_policy_setting" "gcp_dns_managed_zone_approved" {
  resource = turbot_smart_folder.main.id
  type     = "tmod:@turbot/gcp-dns#/policy/types/managedZoneApproved"
  note     = "GCP CIS v2.0.0 - Control: 3.4 and 3.5"
  value    = "Check: Approved"
  # value    = "Enforce: Delete unapproved if new"
}

# GCP > DNS > Managed Zone > Approved > Custom
resource "turbot_policy_setting" "gcp_dns_managed_zone_approved_custom" {
  resource       = turbot_smart_folder.main.id
  type           = "tmod:@turbot/gcp-dns#/policy/types/managedZoneApprovedCustom"
  note           = "Azure CIS v2.0.0 - Control: 3.4 and 3.5"
  template_input = <<-EOT
    {
      managedZone {
        dnssecConfigDefaultKeySpecs: get(path: "dnssecConfig.defaultKeySpecs")
      }
    }
  EOT
  template       = <<-EOT
    {% set results = [] -%}

    {%- if $.managedZone.dnssecConfigDefaultKeySpecs -%}

      {%- set dnssecConfigDefaultKeySpecs = $.managedZone.dnssecConfigDefaultKeySpecs -%}
      {%- set zoneSigningWithRsasha1 = dnssecConfigDefaultKeySpecs | selectattr('keyType', 'equalto', 'zoneSigning') | selectattr('algorithm', 'equalto', 'rsasha1') | list -%}
      {%- set keySigningWithRsasha1 = dnssecConfigDefaultKeySpecs | selectattr('keyType', 'equalto', 'keySigning') | selectattr('algorithm', 'equalto', 'rsasha1') | list -%}

      {%- if zoneSigningWithRsasha1 | length > 0 -%}

        {%- set data = {
            "title": "DNSSEC Configuration",
            "result": "Not approved",
            "message": "RSASHA1 is used for the Zone-Signing key"
        } -%}

      {%- else -%}

        {%- set data = {
            "title": "DNSSEC Configuration",
            "result": "Approved",
            "message": "RSASHA1 is not used for the Zone-Signing key"
        } -%}

      {%- endif -%}

      {% set results = results.concat(data) -%}

      {%- if keySigningWithRsasha1 | length > 0 -%}

        {%- set data = {
            "title": "DNSSEC Configuration",
            "result": "Not approved",
            "message": "RSASHA1 is used for the Key-Signing key"
        } -%}

      {%- else -%}

        {%- set data = {
            "title": "DNSSEC Configuration",
            "result": "Approved",
            "message": "RSASHA1 is not used for the Key-Signing key"
        } -%}

      {%- endif -%}

      {% set results = results.concat(data) -%}

    {%- else -%}

      {%- set data = {
            "title": "DNSSEC Configuration",
            "result": "Skip",
            "message": "No data for DNSSEC configuration yet"
        } -%}

      {% set results = results.concat(data) -%}

    {%- endif -%}

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
    REJECT $.turbot.cidr:0.0.0.0/0

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
