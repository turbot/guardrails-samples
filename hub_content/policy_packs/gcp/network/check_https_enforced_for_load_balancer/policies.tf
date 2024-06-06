# GCP > Network > URL Map > Approved
resource "turbot_policy_setting" "gcp_network_url_map_approved" {
  resource = turbot_smart_folder.pack.id
  type     = "tmod:@turbot/gcp-network#/policy/types/urlMapApproved"
  value    = "Check: Approved"
}

# GCP > Network > URL Map > Approved > Custom
resource "turbot_policy_setting" "gcp_network_url_map_approved_custom" {
  resource       = turbot_smart_folder.pack.id
  type           = "tmod:@turbot/gcp-network#/policy/types/urlMapApprovedCustom"
  template_input = <<EOF
  - |
    {
      item: urlMap {
        Name
        SelfLink
      }
    }
  - |
    {
      resources(filter: "resourceTypeId:'tmod:@turbot/gcp-network#/resource/types/targetHttpsProxy' $.urlMap:'{{ $.item.SelfLink }}'"){
        items{
          Data
        }
      }
    }
  EOF
  template       = <<EOF
  {#- Default policy value -#}
  {%- set policyValue = "Approved" -%}

  {#- Check if there are no associated target HTTPS proxies -#}
  {%- if not $.resources.items -%}
    {%- set policyValue = "Not approved" -%}
  {%- endif -%}

  {{ policyValue }}
  EOF
  precedence     = "REQUIRED"
}
