# GCP > Network > URL Map > Approved
resource "turbot_policy_setting" "gcp_network_url_map_approved" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/gcp-network#/policy/types/urlMapApproved"
  value    = "Check: Approved"
}

# GCP > Network > URL Map > Approved > Custom
resource "turbot_policy_setting" "gcp_network_url_map_approved_custom" {
  resource       = turbot_policy_pack.main.id
  type           = "tmod:@turbot/gcp-network#/policy/types/urlMapApprovedCustom"
  template_input = <<-EOT
  - |
    {
      item: urlMap {
        Name: get(path: "Name")
        SelfLink: get(path: "SelfLink")
      }
      project: project {
        turbot {
          id
      }
    }
  - |
    {
      resources(filter: "resourceTypeId:'tmod:@turbot/gcp-network#/resource/types/targetHttpsProxy' resourceId:{{ $.project.turbot.id }} $.urlMap:'{{ $.item.SelfLink }}' resourceTypeLevel:self ") {
        items {
          Data
        }
      }
    }
  EOT
  template       = <<-EOT
  {%- if $.resources.items -%}

    {%- set data = {
        "title": "HTTPS Enforced",
        "result": "Approved",
        "message": "HTTPS is enforced for load balancer"
    } -%}

  {%- elif not $.resources.items -%}

    {%- set data = {
        "title": "HTTPS Enforced",
        "result": "Not approved",
        "message": "HTTPS is not enforced for load balancer"
    } -%}

  {%- else  -%}

    {%- set data = {
        "title": "HTTPS Enforced",
        "result": "Skip",
        "message": "No data for load balancer yet"
    } -%}

  {%- endif -%}
  {{ data | json }}
  EOT
}
