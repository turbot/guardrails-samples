# AWS > Account > Stack Native
resource "turbot_policy_setting" "aws_account_stack_native" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/aws#/policy/types/accountStackNative"
  value    = "Check: Configured"
  # value    = "Enforce: Configured"
}


# AWS > Account > Stack Native > Source
resource "turbot_policy_setting" "aws_account_stack_native_source" {
  resource       = turbot_policy_pack.main.id
  type           = "tmod:@turbot/aws#/policy/types/accountStackNativeSource"
  template_input = <<-EOT
- |
  {
    account {
      name: get(path: "Name")
      accountAlias: get(path: "AccountAlias")
    }
  }
EOT
  template       = <<-EOT
{%- set org_name = $.account.name -%}
{%- set existing_alias = $.account.accountAlias -%}

{%- if existing_alias -%}
  {# account already has an alias → do nothing #}

{%- elif org_name -%}
  {# --- sanitize org_name into an AWS-valid alias (lowercase, [a-z0-9-], no edge/dup '-') --- #}
  {%- set s = (org_name | lower) -%}
  {%- set out = '' -%}
  {%- set just_dashed = false -%}
  {%- for i in range(0, s.length) -%}
    {%- set c = s[i] -%}
    {%- if ('a' <= c and c <= 'z') or ('0' <= c and c <= '9') -%}
      {%- set out = out ~ c -%}
      {%- set just_dashed = false -%}
    {%- elif out and not just_dashed -%}
      {%- set out = out ~ '-' -%}
      {%- set just_dashed = true -%}
    {%- endif -%}
  {%- endfor -%}
  {%- if out and out[out.length - 1] == '-' -%}
    {%- set out = out | truncate(out.length - 1, true, '') -%}
  {%- endif -%}
  {%- set alias = out | truncate(63, true, '') -%}
  {# Only create alias if it meets AWS requirements (3-63 chars) #}
  {%- if (alias | length) >= 3 -%}

|
resource "aws_iam_account_alias" "alias" {
  account_alias = "{{ alias }}"
}
  {%- endif -%}
{%- endif -%}
  EOT
}
