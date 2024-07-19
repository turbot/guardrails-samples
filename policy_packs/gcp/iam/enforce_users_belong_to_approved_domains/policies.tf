# GCP > IAM > Project User > Approved
resource "turbot_policy_setting" "gcp_iam_project_user_approved" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/gcp-iam#/policy/types/projectUserApproved"
  value    = "Check: Approved"
  # value = "Enforce: Delete unapproved if new"
}

# GCP > IAM > Project User > Approved > Custom
resource "turbot_policy_setting" "gcp_iam_project_user_approved_custom" {
  resource       = turbot_policy_pack.main.id
  type           = "tmod:@turbot/gcp-iam#/policy/types/projectUserApprovedCustom"
  template_input = <<-EOT
    {
      resource {
        userId: get(path: "userId")
      }
      approvedDomains: constant(value: "['example.com', 'acme.com']")
    }
    EOT
  template       = <<-EOT
    {% if $.resource.userId and $.resource.userId.split('@').pop() in $.approvedDomains -%}

      {%- set data = {
          "title": "Trusted Domain",
          "result": "Approved",
          "message": "User belongs to a trusted domain"
      } -%}

    {% elif $.resource.userId and $.resource.userId.split('@').pop() in $.approvedDomains -%}

      {%- set data = {
          "title": "Trusted Domain",
          "result": "Not approved",
          "message": "User does not belong to a trusted domain"
      } -%}

    {%- else -%}

      {%- set data = {
          "title": "Trusted Domain",
          "result": "Skip",
          "message": "No data for trusted domain yet"
      } -%}

    {%- endif %}
    {{ data | json }}
    EOT
}
