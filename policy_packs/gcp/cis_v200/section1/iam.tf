
# GCP > IAM > Service Account Key > Approved
resource "turbot_policy_setting" "gcp_iam_service_account_key_approved" {
  resource = turbot_smart_folder.main.id
  type     = "tmod:@turbot/gcp-iam#/policy/types/serviceAccountKeyApproved"
  note     = "GCP CIS v2.0.0 - Control: 1.4"
  value    = "Check: Approved"
  # value    = "Enforce: Delete unapproved if new"
}

# GCP > IAM > Service Account Key > Approved > Custom
resource "turbot_policy_setting" "gcp_iam_service_account_key_approved_custom" {
  resource       = turbot_smart_folder.main.id
  type           = "tmod:@turbot/gcp-iam#/policy/types/serviceAccountKeyApprovedCustom"
  note           = "GCP CIS v2.0.0 - Control: 1.4"
  template_input = <<-EOT
    {
      serviceAccountKey: serviceAccountKey {
        name: get(path: "name")
        keyType: get(path: "keyType")
      }
    }
  EOT
  template       = <<-EOT
    {% set keyType = $.serviceAccountKey.keyType %}

    {%- if keyType == "USER_MANAGED" -%}

      {%- set data = {
          "title": "GCP Managed Service Account Key",
          "result": "Not approved",
          "message": "Service account key is user managed"
      } -%}

    {%- elif keyType == "SYSTEM_MANAGED" -%}

      {%- set data = {
          "title": "GCP Managed Service Account Key",
          "result": "Approved",
          "message": "Service account key is GCP managed"
      } -%}

    {%- else -%}

      {%- set data = {
          "title": "GCP Managed Service Account Key",
          "result": "Skip",
          "message": "No data for service account key yet"
      } -%}

    {%- endif -%}

    {{ data | json }}
  EOT
}

# GCP > IAM > Service Account > Approved
resource "turbot_policy_setting" "gcp_iam_service_account_approved" {
  resource = turbot_smart_folder.main.id
  type     = "tmod:@turbot/gcp-iam#/policy/types/serviceAccountApproved"
  note     = "GCP CIS v2.0.0 - Control: 1.5"
  value    = "Check: Approved"
  # value    =  "Enforce: Delete unapproved if new"
}

# GCP > IAM > Service Account > Approved > Custom
resource "turbot_policy_setting" "gcp_iam_service_account_approved_custom" {
  resource       = turbot_smart_folder.main.id
  type           = "tmod:@turbot/gcp-iam#/policy/types/serviceAccountApprovedCustom"
  note           = "GCP CIS v2.0.0 - Control: 1.5"
  template_input = <<-EOT
  - |
    {
      project: project {
        id: get(path: "projectId")
      }
    }
  - |
    {
      iamPolicy: resource(id: "gcp://cloudresourcemanager.googleapis.com/projects/{{ $.project.id }}/iamPolicy", options: {notFound: RETURN_NULL}) {
        bindings: get(path: "bindings")
      }
      serviceAccount: serviceAccount {
        email: get(path: "email")
      }
    }
    EOT
  template       = <<-EOT
    {%- set role = '' -%}
    {%- set userServiceAccount = "serviceAccount:" + $.serviceAccount.email -%}

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
            "message": "Service account has admin privileges"
        } -%}

      {%- elif role != "roles/owner" and role != "roles/admin" and role != "roles/editor" -%}

        {%- set data = {
            "title": "Admin Privileges",
            "result": "Approved",
            "message": "Service account does not have admin privileges"
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

# GCP > IAM > Project User > Approved
resource "turbot_policy_setting" "gcp_iam_project_user_approved" {
  resource = turbot_smart_folder.main.id
  type     = "tmod:@turbot/gcp-iam#/policy/types/projectUserApproved"
  note     = "GCP CIS v2.0.0 - Control: 1.6"
  value    = "Check: Approved"
  # value    =  "Enforce: Delete unapproved if new"
}

# GCP > IAM > Project User > Approved > Custom
resource "turbot_policy_setting" "gcp_iam_project_user_approved_custom" {
  resource       = turbot_smart_folder.main.id
  type           = "tmod:@turbot/gcp-iam#/policy/types/projectUserApprovedCustom"
  note           = "GCP CIS v2.0.0 - Control: 1.6"
  template_input = <<-EOT
  - |
    {
      project: project {
        id: get(path: "projectId")
      }
    }
  - |
    {
      iamPolicy: resource(id: "gcp://cloudresourcemanager.googleapis.com/projects/{{ $.project.id }}/iamPolicy", options: {notFound: RETURN_NULL}) {
        bindings: get(path: "bindings")
      }
      projectUser: projectUser {
        userId: get(path: "userId")
      }
    }
    EOT
  template       = <<-EOT
    {%- set role = '' -%}
    {%- set userId = "user:" + $.projectUser.userId -%}

    {%- if userId.startsWith("user:") -%}

      {%- for binding in $.iamPolicy.bindings -%}

        {%- for member in binding.members -%}

          {%- if member == userId -%}

            {%- set role = binding.role -%}

          {%- endif -%}

        {%- endfor -%}

      {%- endfor -%}

      {%- if role == "roles/iam.serviceAccountUser" or role == "roles/iam.serviceAccountTokenCreator" -%}

        {%- set data = {
            "title": "Service Account User or Token Creator Role",
            "result": "Not approved",
            "message": "User is assigned with service account user or token creator role"
        } -%}

      {%- elif role != "roles/iam.serviceAccountUser" and role != "roles/iam.serviceAccountTokenCreator" -%}

        {%- set data = {
            "title": "Service Account User or Token Creator Role",
            "result": "Approved",
            "message": "User is not assigned with service account user or token creator role"
        } -%}

      {%- else -%}

        {%- set data = {
            "title": "Service Account User or Token Creator Role",
            "result": "Skip",
            "message": "No data for user yet"
        } -%}

      {%- endif -%}

    {%- endif -%}

    {{ data | json }}
    EOT
}

# GCP > IAM > Service Account Key > Active
resource "turbot_policy_setting" "gcp_iam_service_account_key_active" {
  resource = turbot_smart_folder.main.id
  type     = "tmod:@turbot/gcp-iam#/policy/types/serviceAccountKeyActive"
  note     = "GCP CIS v2.0.0 - Control: 1.7"
  value    = "Check: Active"
  # value    =  "Enforce: Delete inactive with 90 days warning"
}

# GCP > IAM > Service Account Key > Active > Age
resource "turbot_policy_setting" "gcp_iam_service_account_active_age" {
  resource = turbot_smart_folder.main.id
  type     = "tmod:@turbot/gcp-iam#/policy/types/serviceAccountKeyActiveAge"
  note     = "GCP CIS v2.0.0 - Control: 1.7"
  value    = "Force inactive if age > 90 days"
}
