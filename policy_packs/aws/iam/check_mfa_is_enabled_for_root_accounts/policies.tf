# AWS > IAM > Root > Approved
resource "turbot_policy_setting" "aws_iam_root_approved" {
  resource = turbot_smart_folder.pack.id
  type     = "tmod:@turbot/aws-iam#/policy/types/rootApproved"
  value    = "Check: Approved"
}

# AWS > IAM > Root > Approved > Custom
resource "turbot_policy_setting" "aws_iam_root_approved_custom" {
  resource       = turbot_smart_folder.pack.id
  type           = "tmod:@turbot/aws-iam#/policy/types/rootApprovedCustom"
  template_input = <<-EOT
    {
      root {
        mfaActive: get(path: "mfa_active")
      }
    }
    EOT
  template       = <<-EOT
    {%- if $.root.mfaActive == "true" -%}

      {%- set data = { 
          "title": "MFA Enabled",
          "result": "Approved",
          "message": "MFA is enabled on root account"
      } -%} 

    {%- elif $.root.mfaActive == "false" -%}

      {%- set data = { 
          "title": "MFA Enabled",
          "result": "Not approved",
          "message": "MFA is not enabled on root account"
      } -%} 

    {%- else -%}

      {%- set data = { 
          "title": "MFA Enabled",
          "result": "Skip",
          "message": "No data for MFA yet"
      } -%} 

    {%- endif -%}
    {{ data | json }}
    EOT
}
