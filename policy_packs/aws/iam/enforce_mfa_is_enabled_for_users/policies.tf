# AWS > IAM > User > Approved
resource "turbot_policy_setting" "aws_iam_user_approved" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/aws-iam#/policy/types/userApproved"
  value    = "Check: Approved"
  # value   = "Enforce: Delete unapproved"
  # value   = "Enforce: Delete unapproved if new"
}

# AWS > IAM > User > Approved > Custom
resource "turbot_policy_setting" "aws_iam_user_approved_custom" {
  resource       = turbot_policy_pack.main.id
  type           = "tmod:@turbot/aws-iam#/policy/types/userApprovedCustom"
  template_input = <<-EOT
    - |
      {
        account {
          turbot {
            id
          }
        }
      }
    - |
      {
        user {
          UserName: get(path: "UserName")
        }
        resources(filter:"resourceTypeId:'tmod:@turbot/aws-iam#/resource/types/mfaVirtual' resourceId: {{ $.account.turbot.id }} resourceTypeLevel:self") {
          items {
            userName: get(path:"User.UserName")
          }
        }
      }
  EOT
  template       = <<-EOT
    {%- set hasMfa = false -%}

    {%- for mfa in $.resources.items -%}

      {%- if mfa.userName == $.user.UserName -%}

      {%- set hasMfa = true -%}

      {%- endif -%}

    {%- endfor -%}

    {%- if hasMfa -%}

      {%- set data = {
          "title": "MFA",
          "result": "Approved",
          "message": "User has MFA enabled"
      } -%}

    {%- elif not hasMfa and $.resources.items | length > 0 -%}

      {%- set data = {
          "title": "MFA",
          "result": "Not approved",
          "message": "User does not have MFA enabled"
      } -%}

    {%- else -%}

      {%- set data = {
          "title": "MFA",
          "result": "Skip",
          "message": "No data for MFA yet"
      } -%}

    {%- endif -%}
    {{ data | json }}
  EOT
}
