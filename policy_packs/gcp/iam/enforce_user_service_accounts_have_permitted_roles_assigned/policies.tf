# GCP > IAM > Service Account > Approved
resource "turbot_policy_setting" "gcp_iam_service_account_approved" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/gcp-iam#/policy/types/serviceAccountApproved"
  value    = "Check: Approved"
  # value = "Enforce: Delete unapproved if new"
  # value = "Enforce: Disable unapproved"
}

# GCP > IAM > Service Account > Approved > Custom
resource "turbot_policy_setting" "gcp_iam_service_account_approved_custom" {
  resource       = turbot_policy_pack.main.id
  type           = "tmod:@turbot/gcp-iam#/policy/types/serviceAccountApprovedCustom"
  template_input = <<-EOT
    {
      resources(
        filter: "resourceTypeId:tmod:@turbot/gcp-iam#/resource/types/projectIamPolicy resourceId:{{ $.resource.parent.turbot.id }}"
      ) {
        items {
          projectBindings: get(path: "bindings")
        }
      }
      resource {
        email: get(path:"email")
        disabled: get(path:"disabled")
      }
    }
    EOT
  template       = <<-EOT
    {%- set disallowedRoles = [
        "roles/editor", 
        "roles/owner", 
        "roles/viewer", 
        "roles/resourcemanager.tagUser", 
        "roles/resourcemanager.tagAdmin",  
        "roles/iam.serviceAccountTokenCreator", 
        "roles/iam.serviceAccountUser"
    ] -%}

    {%- set email = $.resource.email -%}
    {%- set isDisabled = $.resource.disabled == true -%}
    {%- set assignedDisallowedRoles = [] -%}

    {%- if not isDisabled -%} {# If the service account is not disabled, check for disallowed roles #}
      {%- for binding in $.resources.items[0].projectBindings -%}
        {%- if binding.role in disallowedRoles -%}
          {%- for member in binding.members -%}
            {%- if member == "serviceAccount:" + email -%}
              {%- set assignedDisallowedRoles = assignedDisallowedRoles.concat([binding.role]) -%}
            {%- endif -%}
          {%- endfor -%}
        {%- endif -%}
      {%- endfor -%}
    {%- endif -%}

    {%- if isDisabled -%}
    - "title": "Role Bindings"
      "result": "Approved"
      "message": "The service account is disabled."
    {%- elif assignedDisallowedRoles | length > 0 -%}
    - "title": "Role Bindings"
      "result": "Not approved"
      "message": "The service account has disallowed role(s): {{ assignedDisallowedRoles | join(", ") }} assigned."
    {%- else -%}
    - "title": "Role Bindings"
      "result": "Approved"
      "message": "The service account does not have any disallowed roles assigned."
    {%- endif -%}
    EOT
}
