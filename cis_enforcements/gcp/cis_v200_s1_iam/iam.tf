
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
  - |
    {
      serviceAccount {
        turbot {
          id
        }
      }
    }
  - |
    {
      serviceAccountKeys: resources(filter: "resourceId:{{ $.serviceAccount.turbot.id }} resourceTypeId:'tmod:@turbot/gcp-iam#/resource/types/serviceAccountKey' resourceTypeLevel:self $.keyType:'USER_MANAGED' limit:5000") {
        items {
          name: get(path: "name")
          keyType: get(path: "keyType")
        }
      }
    }
  EOT
  template       = <<-EOT
    {% set userManagedKeys = $.serviceAccountKeys.items %}

    {%- if userManagedKeys and userManagedKeys | length > 0 -%}

      {%- set data = {
          "title": "GCP-Managed Service Account Keys Only",
          "result": "Not approved",
          "message": "Service Account contains both GCP-Managed and User-Managed keys"
      } -%}

    {%- elif userManagedKeys and userManagedKeys | length == 0 -%}

      {%- set data = {
          "title": "GCP-Managed Service Account Keys Only",
          "result": "Approved",
          "message": Service Account only contains GCP-Managed keys"
      } -%}

    {%- else -%}

      {%- set data = {
          "title": "GCP-Managed Service Account Keys Only",
          "result": "Skip",
          "message": "No data for Service Account yet"
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
      iamPolicy: resource(id:`gcp://cloudresourcemanager.googleapis.com/projects/{{ $.project.id }}/iamPolicy`) {
        bindings: get(path: "bindings")
      }
      serviceAccount: serviceAccount {
        email: get(path: "email")
      }
      projectUser: projectUser {
        userId: get(path: "userId")
      }
    }
    EOT
  template       = <<-EOT
    {% set results = [] -%}
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

    {% set results = results.concat(data) -%}

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
            "message": "User is assigned with service account user or token creator roles at project level"
        } -%}

      {%- elif role != "roles/iam.serviceAccountUser" and role != "roles/iam.serviceAccountTokenCreator" -%}

        {%- set data = {
            "title": Service Account User or Token Creator Role",
            "result": "Approved",
            "message": "User is not assigned with service account user or token creator roles at project level"
        } -%}

      {%- else -%}

        {%- set data = {
            "title": Service Account User or Token Creator Role",
            "result": "Skip",
            "message": "No data for user yet"
        } -%}

      {%- endif -%}

    {%- endif -%}

    {% set results = results.concat(data) -%}

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
