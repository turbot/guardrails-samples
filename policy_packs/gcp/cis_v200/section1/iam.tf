
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
  note     = "GCP CIS v2.0.0 - Control: 1.6, 1.8 and 1.11"
  value    = "Check: Approved"
  # value    =  "Enforce: Delete unapproved if new"
}

# GCP > IAM > Project User > Approved > Custom
resource "turbot_policy_setting" "gcp_iam_project_user_approved_custom" {
  resource       = turbot_smart_folder.main.id
  type           = "tmod:@turbot/gcp-iam#/policy/types/projectUserApprovedCustom"
  note           = "GCP CIS v2.0.0 - Control: 1.6, 1.8 and 1.11"
  template_input = <<-EOT
    {
      projectUser: projectUser {
        roles: get(path: "roles")
        userId: get(path: "userId")
      }
    }
    EOT
  template       = <<-EOT
    {%- set results = [] -%}
    {%- set userRoles = $.projectUser.roles -%}

    {%- set hasSAUserRole = "roles/iam.serviceAccountUser" in userRoles -%}
    {%- set hasSATokenCreator = "roles/iam.serviceAccountTokenCreator" in userRoles -%}

    {%- if hasSAUserRole or hasSATokenCreator -%}

      {%- set data = {
          "title": "SA User or Token Creator Role",
          "result": "Not approved",
          "message": "User is assigned with service account user or token creator role"
      } -%}

    {%- elif not hasSAUserRole or not hasSATokenCreator -%}

      {%- set data = {
          "title": "SA User or Token Creator Role",
          "result": "Approved",
          "message": "User is not assigned with service account user or token creator role"
      } -%}

    {%- else -%}

      {%- set data = {
          "title": "SA User or Token Creator Role",
          "result": "Skip",
          "message": "No data for user yet"
      } -%}

    {%- endif -%}

    {%- set results = results.concat(data) -%}

    {%- set hasKmsAdminRole = false -%}
    {%- set hasCryptoKeyRole = false -%}

    {%- for role in userRoles -%}

      {%- if role == "roles/cloudkms.admin" -%}

        {%- set hasKmsAdminRole = true -%}

      {%- elif role == "roles/cloudkms.cryptoKeyDecrypter" or role == "roles/cloudkms.cryptoKeyEncrypter" or role == "roles/cloudkms.cryptoKeyEncrypterDecrypter" -%}

        {%- set hasCryptoKeyRole = true -%}

      {%- endif -%}

    {%- endfor -%}

    {%- if not hasKmsAdminRole and not hasCryptoKeyRole -%}

      {%- set data = {
          "title": "KMS Admin and Crypto Key Roles",
          "result": "Approved",
          "message": "User does not have KMS admin and crypto key roles"
      } -%}

    {%- elif hasKmsAdminRole and hasCryptoKeyRole -%}

      {%- set data = {
          "title": "KMS Admin and Crypto Key Roles",
          "result": "Not approved",
          "message": "User has KMS admin and crypto key roles"
      } -%}

    {%- else -%}

     {%- set data = {
          "title": "KMS Admin and Crypto Key Roles",
          "result": "Skip",
          "message": "No data available for KMS admin and crypto key roles yet"
      } -%}

    {%- endif -%}

    {%- set results = results.concat(data) -%}

    {%- set hasServiceAccountAdminRole = "roles/iam.serviceAccountAdmin" in userRoles -%}
    {%- set hasServiceAccountUserRole = "roles/iam.serviceAccountUser" in userRoles -%}

    {%- if not hasServiceAccountAdminRole and not hasServiceAccountUserRole -%}

      {%- set data = {
          "title": "SA Admin and User Roles",
          "result": "Approved",
          "message": "User does not have service account admin and user roles"
      } -%}

    {%- elif hasServiceAccountAdminRole and hasServiceAccountUserRole -%}

      {%- set data = {
          "title": "SA Admin and User Roles",
          "result": "Not approved",
          "message": "User has service account admin and user roles"
      } -%}

    {%- else -%}

     {%- set data = {
          "title": "SA Admin and User Roles",
          "result": "Skip",
          "message": "No data available for service account admin and user roles yet"
      } -%}

    {%- endif -%}

    {%- set results = results.concat(data) -%}

    {{ results | json }}
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
