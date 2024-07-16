# AWS > IAM > User > Approved
resource "turbot_policy_setting" "aws_iam_user_approved" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/aws-iam#/policy/types/userApproved"
  value    = "Check: Approved"
  # value   = "Enforce: Delete unapproved"
  # value   = "Enforce: Delete unapproved if new"
}

# AWS > IAM > User > Approved > Usage
resource "turbot_policy_setting" "aws_iam_user_approved_usage" {
  resource       = turbot_smart_folder.aws_iam.id
  type           = "tmod:@turbot/aws-iam#/policy/types/userApprovedUsage"
  template_input = <<EOT
  {
    user{
      Arn
      UserName
    }
  resources(filter:"resourceType:'tmod:@turbot/aws-iam#/resource/types/mfaVirtual'") {
    items {
      usertest: get(path:"User.UserName")
        trunk {
          title
        }
      }
    }
  }
EOT
  template       = <<EOT
  {%- set matches = false -%}

  {%- for v in $.resources.items -%}

    {%- if v.usertest == $.user.UserName -%}

    {%- set matches = true -%}

    {%- endif -%}

  {%- endfor -%}

  {%- if matches -%}

  "Approved"

  {%- else -%}

  "Not approved"

  {%- endif -%}
EOT
}
