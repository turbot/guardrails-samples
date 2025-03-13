# AWS > Secrets Manager > Secret > Approved
resource "turbot_policy_setting" "secret_approved" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/aws-secretsmanager#/policy/types/secretApproved"
  value    = "Check: Approved"
  # value    = "Enforce: Delete unapproved if new"
}

# AWS > Secrets Manager > Secret > Approved > Custom
resource "turbot_policy_setting" "secret_approved_custom" {
  resource       = turbot_policy_pack.main.id
  type           = "tmod:@turbot/aws-secretsmanager#/policy/types/secretApprovedCustom"
  template_input = <<-EOT
    {
      secret: secret {
        rotationEnabled: get(path: "RotationEnabled")
        rotationRules: get(path: "RotationRules")
      }
    }
  EOT
  template = <<-EOT
    {%- set rotationEnabled = $.secret.rotationEnabled -%}
    {%- set rotationRules = $.secret.rotationRules -%}

    {%- if rotationEnabled == true -%}
      {%- set data = {
          "title": "Automatic Rotation",
          "result": "Approved",
          "message": "Secret has automatic rotation enabled"
      } -%}
    {%- elif rotationRules != null -%}
      {%- set data = {
          "title": "Automatic Rotation",
          "result": "Approved",
          "message": "Secret has rotation rules defined"
      } -%}
    {%- else -%}
      {%- set data = {
          "title": "Automatic Rotation",
          "result": "Not approved",
          "message": "Secret does not have automatic rotation enabled"
      } -%}
    {%- endif -%}
    {{ data | json }}
  EOT
}
