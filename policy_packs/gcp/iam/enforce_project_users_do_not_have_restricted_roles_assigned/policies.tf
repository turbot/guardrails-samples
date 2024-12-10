# GCP > IAM > Project User > Approved
resource "turbot_policy_setting" "gcp_iam_project_user_approved" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/gcp-iam#/policy/types/projectUserApproved"
  value    = "Check: Approved"
  # value    = "Enforce: Delete unapproved if new"
}

# GCP > IAM > Project User > Approved > Custom
resource "turbot_policy_setting" "gcp_iam_project_user_approved_custom" {
  resource       = turbot_policy_pack.main.id
  type           = "tmod:@turbot/gcp-iam#/policy/types/projectUserApprovedCustom"
  template_input = <<-EOT
    {
      resource {
        data
      }
    }
    EOT
  template       = <<-EOT
    {%- set restrictedRoles = [
        "roles/editor", 
        "roles/owner", 
        "roles/viewer", 
        "roles/resourcemanager.tagUser", 
        "roles/resourcemanager.tagAdmin",  
        "roles/iam.serviceAccountTokenCreator", 
        "roles/iam.serviceAccountUser"
    ] -%}

    {%- set email = $.resource.data.userId -%}
    {%- set assignedRestrictedRoles = [] -%}

    {%- for role in $.resource.data.roles -%}
      {%- if role in restrictedRoles -%}
        {%- set assignedRestrictedRoles = assignedRestrictedRoles.concat([role]) -%}
      {%- endif -%}
    {%- endfor -%}

    {%- if assignedRestrictedRoles | length > 0 -%}
    - "title": "Role Assignments"
      "result": "Not approved"
      "message": "The user {{ email }} has restricted role(s): {{ assignedRestrictedRoles | join(", ") }} assigned."
    {%- else -%}
    - "title": "Role Assignments"
      "result": "Approved"
      "message": "The user {{ email }} does not have any restricted roles assigned."
    {%- endif -%}
    EOT
}
