# GCP > KMS > Crypto Key > Approved
resource "turbot_policy_setting" "gcp_kms_crypto_key_approved" {
  resource = turbot_smart_folder.pack.id
  type     = "tmod:@turbot/gcp-kms#/policy/types/cryptoKeyApproved"
  value    = "Check: Approved"
}

# GCP > KMS > Crypto Key > Approved > Custom
resource "turbot_policy_setting" "gcp_kms_crypto_key_approved_custom" {
  resource       = turbot_smart_folder.pack.id
  type           = "tmod:@turbot/gcp-kms#/policy/types/cryptoKeyApprovedCustom"
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
                "message": "Crypto key rotated regularly"
            } -%} 

        {%- elif rotationPeriodInDays > 90 -%}
            
            {%- set data = { 
                "title": "Rotation",
                "result": "Not approved",
                "message": "Crypto key not rotated regularly"
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
