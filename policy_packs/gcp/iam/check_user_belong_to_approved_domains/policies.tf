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
    }
    EOT
  template       = <<-EOT
    {% set approved_domains = [ "northfieldit.com", "nfl.com" ] -%}

    {% if $.resource.userId.split('@').pop() in approved_domains -%}

    - title: "Trusted Domain Users"
      result: Approved
      message: "{{ $.resource.userId }} is in trusted domains list: {{ approved_domains }}."

    {%- else -%}

    - title: "Trusted Domain Users"
      result: Not approved
      message: "{{ $.resource.userId }} is not in trusted domains list: {{ approved_domains }}."

    {%- endif %}
    EOT
}
