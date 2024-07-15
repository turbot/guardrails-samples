# GCP > IAM > Service Account > Approved
resource "turbot_policy_setting" "gcp_iam_service_account_approved" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/gcp-iam#/policy/types/serviceAccountApproved"
  value    = "Check: Approved"
  # value    =  "Enforce: Delete unapproved if new"
}

# GCP > IAM > Service Account > Approved > Custom
resource "turbot_policy_setting" "gcp_iam_service_account_approved_custom" {
  resource       = turbot_policy_pack.main.id
  type           = "tmod:@turbot/gcp-iam#/policy/types/serviceAccountApprovedCustom"
  template_input = <<-EOT
  - |
    {
      project: project {
        id: get(path: "projectId")
      }
    }
  - |
    {
      iamPolicy: resource(id:"gcp://cloudresourcemanager.googleapis.com/projects/{{ $.project.id }}/iamPolicy") {
        bindings: get(path: "bindings")
      }
      item: serviceAccount {
        email: get(path: "email")
      }
    }
    EOT
  template       = <<-EOT
    {%- set userServiceAccount = "serviceAccount:" + $.item.email -%}
    {%- set role = '' -%}

    {%- if userServiceAccount.endsWith("iam.gserviceaccount.com") -%}

      {%- for binding in $.iamPolicy.bindings -%}

        {%- for member in binding.members -%}

          {%- if member == userServiceAccount -%}

            {%- set role = binding.role -%}

          {%- endif -%}

        {%- endfor -%}

      {%- endfor -%}

      {%- if role == "roles/owner" or role == "roles/admin" or role == "roles/editor" -%}

        {%- set data = {
            "title": "Admin Privileges",
            "result": "Not approved",
            "message": "Service Account has admin privileges"
        } -%}

      {%- elif role != "roles/owner" and role != "roles/admin" and role != "roles/editor" -%}

        {%- set data = {
            "title": "Admin Privileges",
            "result": "Approved",
            "message": "Service Account does not have admin privileges"
        } -%}

      {%- else -%}

        {%- set data = {
            "title": "Admin Privileges",
            "result": "Skip",
            "message": "No data for admin privileges yet"
        } -%}

      {%- endif -%}

    {%- endif -%}
    {{ data | json }}
    EOT
}
