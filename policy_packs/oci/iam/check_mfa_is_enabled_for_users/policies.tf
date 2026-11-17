# OCI > IAM > User > Allowed > Custom
resource "turbot_policy_setting" "oci_iam_user_allowed_custom" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/oci-iam#/policy/types/userAllowedCustom"
  value    = "Check: Allowed"
}

# OCI > IAM > User > Allowed > Custom > Rules
resource "turbot_policy_setting" "oci_iam_user_allowed_custom_rules" {
  resource       = turbot_policy_pack.main.id
  type           = "tmod:@turbot/oci-iam#/policy/types/userAllowedCustomRules"
  template_input = <<-EOT
    {
      user {
        isMfaActivated: get(path: "isMfaActivated")
        canUseConsolePassword: get(path: "capabilities.canUseConsolePassword")
      }
    }
    EOT
  template       = <<-EOT
    {%- if $.user.isMfaActivated == null -%}

      {%- set data = {
          "title": "MFA",
          "result": "Skip",
          "message": "No data for user yet"
      } -%}

    {%- elif $.user.canUseConsolePassword == false -%}

      {%- set data = {
          "title": "MFA",
          "result": "Allowed",
          "message": "User cannot use a console password"
      } -%}

    {%- elif $.user.isMfaActivated -%}

      {%- set data = {
          "title": "MFA",
          "result": "Allowed",
          "message": "User has MFA activated"
      } -%}

    {%- else -%}

      {%- set data = {
          "title": "MFA",
          "result": "Not allowed",
          "message": "User can use a console password without MFA"
      } -%}

    {%- endif -%}
    {{ data | json }}
    EOT
}
