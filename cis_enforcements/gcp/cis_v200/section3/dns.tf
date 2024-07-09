# GCP > DNS > Managed Zone > DNSSEC Configuration
resource "turbot_policy_setting" "gcp_dns_managed_zone_dnssec_configuration" {
  resource = turbot_smart_folder.main.id
  type     = "tmod:@turbot/gcp-dns#/policy/types/managedZoneDnssecConfiguration"
  note     = "GCP CIS v2.0.0 - Control: 3.3"
  value    = "Check: Enabled"
  # value    = "Enforce: Enabled"
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

      {%- set zoneSigningRsasha1 = false -%}

      {%- set keySigningRsasha1 = false -%}

      {%- for keySpec in dnssecConfigDefaultKeySpecs -%}

        {%- if keySpec.keyType == 'zoneSigning' and keySpec.algorithm == 'rsasha1' -%}

          {%- set zoneSigningRsasha1 = true -%}

        {%- elif keySpec.keyType == 'keySigning' and keySpec.algorithm == 'rsasha1' -%}

          {%- set keySigningRsasha1 = true -%}

        {%- endif -%}

      {%- endfor -%}

      {%- if zoneSigningRsasha1 -%}

        {%- set data = {
            "title": "Zone-Signing Key",
            "result": "Not approved",
            "message": "RSASHA1 is used for the Zone-Signing key"
        } -%}

      {%- else -%}

        {%- set data = {
            "title": "Zone-Signing Key",
            "result": "Approved",
            "message": "RSASHA1 is not used for the Zone-Signing key"
        } -%}

      {%- endif -%}

      {% set results = results.concat(data) -%}

      {%- if keySigningRsasha1 -%}

        {%- set data = {
            "title": "Key-Signing Key",
            "result": "Not approved",
            "message": "RSASHA1 is used for the Key-Signing key"
        } -%}

      {%- else -%}

        {%- set data = {
            "title": "Key-Signing Key",
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


