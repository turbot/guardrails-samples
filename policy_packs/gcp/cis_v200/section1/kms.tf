# GCP > KMS > Crypto Key > Policy > Trusted Access
resource "turbot_policy_setting" "gcp_kms_crypto_key_policy_trusted_access" {
  resource = turbot_smart_folder.main.id
  type     = "tmod:@turbot/gcp-kms#/policy/types/cryptoKeyPolicyTrustedAccess"
  note     = "GCP CIS v2.0.0 - Control: 1.9"
  value    = "Check: Trusted Access > *"
  # value    = "Enforce: Trusted Access > *"
}

# GCP > KMS > Crypto Key > Policy > Trusted Access > All Users
resource "turbot_policy_setting" "gcp_kms_crypto_key_policy_trusted_access_all_users" {
  resource = turbot_smart_folder.main.id
  type     = "tmod:@turbot/gcp-kms#/policy/types/cryptoKeyPolicyTrustedAllUsers"
  note     = "GCP CIS v2.0.0 - Control: 1.9"
  value    = "Do not allow allUsers"
  # value    = "Allow allUsers (Anonymous Access)"
}

# GCP > KMS > Crypto Key > Policy > Trusted Access > All Authenticated
resource "turbot_policy_setting" "gcp_kms_crypto_key_policy_trusted_access_all_authenticated" {
  resource = turbot_smart_folder.main.id
  type     = "tmod:@turbot/gcp-kms#/policy/types/cryptoKeyPolicyTrustedAllAuthenticated"
  note     = "GCP CIS v2.0.0 - Control: 1.9"
  value    = "Do not allow allAuthenticatedUsers"
  # value    = "Allow allAuthenticatedUsers (Public Access)"
}

# GCP > KMS > Crypto Key > Approved
resource "turbot_policy_setting" "gcp_kms_crypto_key_approved" {
  resource = turbot_smart_folder.main.id
  type     = "tmod:@turbot/gcp-kms#/policy/types/cryptoKeyApproved"
  note     = "GCP CIS v2.0.0 - Control: 1.10"
  value    = "Check: Approved"
}

# GCP > KMS > Crypto Key > Approved > Custom
resource "turbot_policy_setting" "gcp_kms_crypto_key_approved_custom" {
  resource       = turbot_smart_folder.main.id
  type           = "tmod:@turbot/gcp-kms#/policy/types/cryptoKeyApprovedCustom"
  note           = "GCP CIS v2.0.0 - Control: 1.10"
  template_input = <<-EOT
    {
      cryptoKey {
        rotationPeriod: get(path: "rotationPeriod")
        keyState: get(path: "primary.state")
      }
    }
    EOT
  template       = <<-EOT
    {%- if $.cryptoKey.keyState == "DISABLED" or $.cryptoKey.keyState == "DESTROY_SCHEDULED" or $.cryptoKey.keyState == "DESTROYED" -%}

        {%- set data = {
            "title": "Rotation",
            "result": "Skip",
            "message": "Crypto key is not ENABLED"
        } -%}

    {%- else -%}

        {%- set rotationPeriodWithoutSeconds = $.cryptoKey.rotationPeriod.slice(0, -1) -%}
        {%- set rotationPeriodInDays = rotationPeriodWithoutSeconds / 86400 -%}

        {%- if rotationPeriodInDays <= 90 -%}

            {%- set data = {
                "title": "Rotation",
                "result": "Approved",
                "message": "Crypto key is rotated every 90 days"
            } -%}

        {%- elif rotationPeriodInDays > 90 -%}

            {%- set data = {
                "title": "Rotation",
                "result": "Not approved",
                "message": "Crypto key is not rotated every 90 days"
            } -%}

        {%- else -%}

            {%- set data = {
                "title": "Rotation",
                "result": "Skip",
                "message": "No data for crypto key yet"
            } -%}

        {%- endif %}

    {%- endif -%}
    {{ data | json }}
    EOT
}
