# AWS > IAM > Account Password Policy > Settings
resource "turbot_policy_setting" "aws_iam_account_password_policy_settings" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/aws-iam#/policy/types/accountPasswordPolicySettings"
  note     = "AWS CIS v3.0.0 - Controls: 1.8 & 1.9"
  value    = "Check: Configured"
  # value    = "Enforce: Configured"
}

# AWS > IAM > Account Password Policy > Settings > Minimum Length
resource "turbot_policy_setting" "aws_iam_account_password_policy_settings_minimum_length" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/aws-iam#/policy/types/accountPasswordPolicySettingsMinimumLength"
  value    = 14
  note     = "AWS CIS v3.0.0 - Controls: 1.8"
}

# AWS > IAM > Account Password Policy > Settings > Reuse Prevention
resource "turbot_policy_setting" "aws_iam_account_password_policy_settings_reuse_prevention" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/aws-iam#/policy/types/accountPasswordPolicySettingsReusePrevention"
  value    = 24
  note     = "AWS CIS v3.0.0 - Controls: 1.9"
}

# AWS > IAM > User > Login Profile
resource "turbot_policy_setting" "aws_iam_user_login_profile" {
  resource       = turbot_policy_pack.main.id
  type           = "tmod:@turbot/aws-iam#/policy/types/userLoginProfile"
  note           = "AWS CIS v3.0.0 - Controls: 1.10 & 1.11"
  template_input = <<-EOT
    {
      value: constant(value: "Check: Login profile enabled")
      # value: constant(value: "Enforce: Delete login profile")
      user {
        children(filter:[
            "resourceTypeId:'tmod:@turbot/aws-iam#/resource/types/accessKey'",
            "level:self"
          ]){
          items {
            status: get(path:"Status")
          }
        }
        UserName
        parent {
          children(filter:[
            "resourceTypeId:'tmod:@turbot/aws-iam#/resource/types/mfaVirtual'",
            "level:self",
            "limit:2000"
          ]) {
            items {
              mfa_user: get(path:"User.UserName")
            }
          }
        }
      }
    }
    EOT
  template       = <<-EOT
    {%- set has_mfa = false -%}

    {%- set has_key = false -%}

    {# Check for MFA - AWS CIS 3.0.0 - 1.10 #}

    {%- for mfa in $.user.parent.children.items -%}

      {%- if mfa.mfa_user == $.user.UserName -%}

        {%- set has_mfa = true -%}

      {%- endif -%}

    {%- endfor -%}

    {# Check for Access Keys - AWS CIS 3.0.0 - 1.11 #}


    {%- for key in $.user.children.items -%}

      {%- if key.status == "Active" -%}

        {%- set has_key = true -%}

      {%- endif -%}

    {%- endfor -%}

    {# Result #}

    {%- if (not has_mfa) or has_key -%}

      {{ $.value | json }}

    {%- else -%}

      Skip

    {%- endif -%}
    EOT
}

# AWS > IAM > Access Key > Active
resource "turbot_policy_setting" "aws_iam_access_key_active" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/aws-iam#/policy/types/accessKeyActive"
  note     = "AWS CIS v3.0.0 - Controls: 1.12, 1.13 and 1.14"
  value    = "Check: Active"
  # value    = "Enforce: Deactivate inactive with 14 days warning"
}

# AWS > IAM > Access Key > Active > Last Modified
resource "turbot_policy_setting" "aws_iam_access_key_active_last_modified" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/aws-iam#/policy/types/accessKeyActiveLastModified"
  note     = "Prevents newly created access keys from being deleted for not having been used recently."
  value    = "Force active if last modified <= 7 days"
}

# AWS > IAM > Access Key > Active > Recently Used
resource "turbot_policy_setting" "aws_iam_access_key_active_recently_used" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/aws-iam#/policy/types/accessKeyActiveRecentlyUsed"
  note     = "AWS CIS v3.0.0 - Controls: 1.12"
  value    = "Force active if recently used <= 30 days"
}

# AWS > IAM > Access Key > Active > Latest
resource "turbot_policy_setting" "aws_iam_access_key_active_latest" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/aws-iam#/policy/types/accessKeyActiveLatest"
  note     = "AWS CIS v3.0.0 - Controls: 1.13"
  value    = "Force inactive if not latest"
}

# AWS > IAM > Access Key > Active > Age
resource "turbot_policy_setting" "aws_iam_access_key_active_age" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/aws-iam#/policy/types/accessKeyActiveAge"
  note     = "AWS CIS v3.0.0 - Controls: 1.14"
  value    = "Force inactive if age > 90 days"
}

# AWS > IAM > User > Policy Attachments > Approved
resource "turbot_policy_setting" "aws_iam_user_policy_attachments_approved" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/aws-iam#/policy/types/userPolicyAttachmentsApproved"
  note     = "AWS CIS v3.0.0 - Controls: 1.15"
  value    = "Check: Approved"
  # value    = "Enforce: Delete unapproved"
}

# AWS > IAM > User > Policy Attachments > Approved > Rules
resource "turbot_policy_setting" "aws_iam_user_policy_attachments_approved_rules" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/aws-iam#/policy/types/userPolicyAttachmentsApprovedRules"
  note     = "AWS CIS v3.0.0 - Controls: 1.15"
  value    = "REJECT *"
}

# AWS > IAM > User > Inline Policy > Approved
resource "turbot_policy_setting" "aws_iam_user_inline_policy_approved" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/aws-iam#/policy/types/userInlinePolicyApproved"
  note     = "AWS CIS v3.0.0 - Controls: 1.15"
  value    = "Check: Approved"
  # value    = "Enforce: Delete unapproved"
  # value    = "Enforce: Delete unapproved if new"
}

# AWS > IAM > User > Inline Policy > Approved > Usage
resource "turbot_policy_setting" "aws_iam_user_inline_policy_approved_usage" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/aws-iam#/policy/types/userInlinePolicyApprovedUsage"
  note     = "AWS CIS v3.0.0 - Controls: 1.15"
  value    = "Not approved"
}

# AWS > IAM > Policy > Statements > Approved
resource "turbot_policy_setting" "aws_iam_statements_approved" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/aws-iam#/policy/types/statementsApproved"
  note     = "AWS CIS v3.0.0 - Controls: 1.16"
  value    = "Check: Approved"
  # value    = "Enforce: Delete Unapproved"
}

# AWS > IAM > Policy > Statements > Approved > Rules
resource "turbot_policy_setting" "aws_iam_statements_approved_rules" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/aws-iam#/policy/types/statementsApprovedRules"
  note     = "AWS CIS v3.0.0 - Controls: 1.16"
  value    = <<-EOT
    REJECT $.Effect:"Allow" $.Action:"*"  $.Resource:"*"
    APPROVE *
    EOT
}

# AWS > IAM > Group > Inline Policy > Statements > Approved
resource "turbot_policy_setting" "aws_iam_group_inline_policy_statements_approved" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/aws-iam#/policy/types/groupInlinePolicyStatementsApproved"
  note     = "AWS CIS v3.0.0 - Controls: 1.16"
  value    = "Check: Approved"
  # value    = "Enforce: Delete Unapproved"
}

# AWS > IAM > Group > Inline Policy > Statements > Approved > Admin Access
resource "turbot_policy_setting" "aws_iam_group_inline_policy_statements_approved_admin_access" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/aws-iam#/policy/types/groupInlinePolicyStatementsApprovedAdminAccess"
  note     = "AWS CIS v3.0.0 - Controls: 1.16"
  value    = "Disabled: Disallow Administrator Access ('*:*') policies"
}

# AWS > IAM > User > Inline Policy > Statements > Approved
resource "turbot_policy_setting" "aws_iam_user_inline_policy_statements_approved" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/aws-iam#/policy/types/userInlinePolicyStatementsApproved"
  note     = "AWS CIS v3.0.0 - Controls: 1.16"
  value    = "Check: Approved"
  # value    = "Enforce: Delete Unapproved"
}

# AWS > IAM > User > Inline Policy > Statements > Approved > Admin Access
resource "turbot_policy_setting" "aws_iam_user_inline_policy_statements_approved_admin_access" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/aws-iam#/policy/types/userInlinePolicyStatementsApprovedAdminAccess"
  note     = "AWS CIS v3.0.0 - Controls: 1.16"
  value    = "Disabled: Disallow Administrator Access ('*:*') policies"
}

# AWS > IAM > Role > Inline Policy > Statements > Approved
resource "turbot_policy_setting" "aws_iam_role_inline_policy_statements_approved" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/aws-iam#/policy/types/roleInlinePolicyStatementsApproved"
  note     = "AWS CIS v3.0.0 - Controls: 1.16"
  value    = "Check: Approved"
  # value    = "Enforce: Delete Unapproved"
}

# AWS > IAM > Role > Inline Policy > Statements > Approved > Admin Access
resource "turbot_policy_setting" "aws_iam_role_inline_policy_statements_approved_admin_access" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/aws-iam#/policy/types/roleInlinePolicyStatementsApprovedAdminAccess"
  note     = "AWS CIS v3.0.0 - Controls: 1.16"
  value    = "Disabled: Disallow Administrator Access ('*:*') policies"
}

# AWS > IAM > Stack
resource "turbot_policy_setting" "aws_iam_stack" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/aws-iam#/policy/types/iamStack"
  note     = "AWS CIS v3.0.0 - Controls:  1.17"
  value    = "Check: Configured"
  # value    = "Enforce: Configured"
}

# AWS > IAM > Stack > Source
resource "turbot_policy_setting" "aws_iam_stack_source" {
  resource       = turbot_policy_pack.main.id
  type           = "tmod:@turbot/aws-iam#/policy/types/iamStackSource"
  note           = "AWS CIS v3.0.0 - Controls:  1.17"
  template_input = <<-EOT
    {
      account  {
        Id
        metadata
      }
    }
    EOT
  template       = <<-EOT
    |
    resource "aws_iam_role" "aws_support_role" {
      name = "AWSSupportRole"
      managed_policy_arns = [
        "arn:aws:iam::aws:policy/AWSSupportAccess"
      ]
      assume_role_policy = jsonencode({
        Version = "2012-10-17"
        Statement = [
          {
            Action = "sts:AssumeRole"
            Effect = "Allow"
            Principal = {
                "AWS": "arn:{{ $.account.metadata.aws.partition }}:::{{ $.account.Id }}:root"
            }
          },
        ]
      })
    }
    EOT
}

# AWS > IAM > Stack > Terraform Version
resource "turbot_policy_setting" "aws_iam_iam_stack_terraform_version" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/aws-iam#/policy/types/iamStackTerraformVersion"
  note     = "AWS CIS v3.0.0 - Controls:  1.17"
  value    = "0.15.*"
}

# AWS > EC2 > Instance > Instance Profile
resource "turbot_policy_setting" "aws_ec2_instance_instance_profile" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/aws-ec2#/policy/types/instanceProfile"
  note     = "AWS CIS v3.0.0 - Controls: 1.18"
  value    = "Check: Instance profile attached"
  # value    = "Check: Instance Profile > Name attached"
  # value    = "Enforce: Attach Instance Profile > Name"
}

# AWS > EC2 > Instance > Instance Profile > Name
resource "turbot_policy_setting" "aws_ec2_instance_instance_profile_role_name" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/aws-ec2#/policy/types/instanceProfileName"
  note     = "AWS CIS v3.0.0 - Controls: 1.18"
  # EC2 Instance Profile name. Just the name not the full ARN.
  value = "orgDefaultInstanceProfile"
}

# AWS > IAM > Server Certificate > Active
resource "turbot_policy_setting" "aws_iam_server_certificate_active" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/aws-iam#/policy/types/serverCertificateActive"
  note     = "AWS CIS v3.0.0 - Controls: 1.19"
  value    = "Check: Active"
  # value    = "Enforce: Delete inactive with 1 day warning"
}

# AWS > IAM > Server Certificate > Active > Expired
resource "turbot_policy_setting" "aws_iam_server_certificate_active_expired" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/aws-iam#/policy/types/serverCertificateActiveExpired"
  note     = "AWS CIS v3.0.0 - Controls: 1.19"
  value    = "Force inactive if expired"
}

# AWS > Region > Stack > Source
resource "turbot_policy_setting" "aws_iam_regional_access_analyzer" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/aws#/policy/types/regionStack"
  note     = "AWS CIS v3.0.0 - Controls: 1.20"
  value    = "Check: Configured"
  # value    = "Enforce: Configured"
}

# AWS > Region > Stack > Source
resource "turbot_policy_setting" "aws_iam_regional_access_analyzer_source" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/aws#/policy/types/regionStackSource"
  note     = "AWS CIS v3.0.0 - Controls: 1.20"
  value    = <<-EOT
    resource "aws_accessanalyzer_analyzer" "cis_access_analyzer" {
      analyzer_name = "access_analyzer"
      type          = "ACCOUNT"
    }
    EOT
}
