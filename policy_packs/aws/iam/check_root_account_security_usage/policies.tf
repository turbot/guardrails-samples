# AWS > IAM > Root > Approved
resource "turbot_policy_setting" "aws_iam_root_approved" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/aws-iam#/policy/types/rootApproved"
  value    = "Check: Approved"
}

# AWS > IAM > Root > Approved > Custom
resource "turbot_policy_setting" "aws_iam_root_approved_custom" {
  resource       = turbot_policy_pack.main.id
  type           = "tmod:@turbot/aws-iam#/policy/types/rootApprovedCustom"
  template_input = <<-EOT
  {
    root {
      mfaActive: get(path: "mfa_active")
      passwordEnabled: get(path: "password_enabled")
      passwordLastUsed: get(path: "password_last_used")
      accessKey1Active: get(path: "access_key_1_active")
      accessKey1LastUsed: get(path: "access_key_1_last_used")
      accessKey2Active: get(path: "access_key_2_active")
      accessKey2LastUsed: get(path: "access_key_2_last_used")
    }
  }
EOT
  template       = <<-EOT
{%- set now = "now" | date("constructor") -%}
{%- set nowMs = now | date("getTime") -%}
{%- set fourteenDaysMs = 14 * 24 * 60 * 60 * 1000 -%}
{%- set fourteenDaysAgo = nowMs - fourteenDaysMs -%}

[
  {# MFA Check #}
  {%- if $.root.mfaActive == "true" -%}
    {
      "title": "MFA",
      "result": "Approved",
      "message": "MFA is enabled"
    },
  {%- else -%}
    {
      "title": "MFA",
      "result": "Not approved",
      "message": "MFA is not enabled"
    },
  {%- endif -%}

  {# Password Usage Check #}
  {%- if $.root.passwordEnabled == "true" and $.root.passwordLastUsed -%}
    {%- set pwdMs = $.root.passwordLastUsed | date("getTime") -%}
    {%- if pwdMs > fourteenDaysAgo -%}
      {
        "title": "Password Usage",
        "result": "Not approved",
        "message": "Root password was used within the last 14 days"
      },
    {%- else -%}
      {
        "title": "Password Usage",
        "result": "Approved",
        "message": "Root password has not been used in the last 14 days"
      },
    {%- endif -%}
  {%- elif $.root.passwordEnabled == "false" -%}
    {
      "title": "Password Usage",
      "result": "Approved",
      "message": "Root password is disabled"
    },
  {%- else -%}
    {
      "title": "Password Usage",
      "result": "Approved",
      "message": "Password enabled but never used"
    },
  {%- endif -%}

  {# Access Key 1 Check #}
  {%- if $.root.accessKey1Active == "true" and $.root.accessKey1LastUsed -%}
    {%- set ak1Ms = $.root.accessKey1LastUsed | date("getTime") -%}
    {%- if ak1Ms > fourteenDaysAgo -%}
      {
        "title": "Access Key 1",
        "result": "Not approved",
        "message": "Access Key 1 was used within the last 14 days"
      },
    {%- else -%}
      {
        "title": "Access Key 1",
        "result": "Approved",
        "message": "Access Key 1 not used in last 14 days"
      },
    {%- endif -%}
  {%- else -%}
    {
      "title": "Access Key 1",
      "result": "Approved",
      "message": "Access Key 1 inactive or never used"
    },
  {%- endif -%}

  {# Access Key 2 Check #}
  {%- if $.root.accessKey2Active == "true" and $.root.accessKey2LastUsed -%}
    {%- set ak2Ms = $.root.accessKey2LastUsed | date("getTime") -%}
    {%- if ak2Ms > fourteenDaysAgo -%}
      {
        "title": "Access Key 2",
        "result": "Not approved",
        "message": "Access Key 2 was used within the last 14 days"
      }
    {%- else -%}
      {
        "title": "Access Key 2",
        "result": "Approved",
        "message": "Access Key 2 not used in last 14 days"
      }
    {%- endif -%}
  {%- else -%}
    {
      "title": "Access Key 2",
      "result": "Approved",
      "message": "Access Key 2 inactive or never used"
    }
  {%- endif -%}
]
EOT
}
