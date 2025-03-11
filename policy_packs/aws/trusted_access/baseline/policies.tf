# Create policy settings for Trusted Access policies
# Change action (Skip, Check, Enforce in terraform.tfvars)
resource "turbot_policy_setting" "trusted_access_policy" {
  for_each = var.trusted_access_controls
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/${var.policy_map[each.key].service}#/policy/types/${var.policy_map[each.key].resourceName}TrustedAccess"
  value    = var.policy_map[each.key][each.value]
}

# Create policy settings for Trusted Access > Accounts policies with calculated values
resource "turbot_policy_setting" "trusted_access_accounts_policy" {
  for_each = var.trusted_access_controls
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/${var.policy_map[each.key].service}#/policy/types/${var.policy_map[each.key].resourceName}${var.policy_map[each.key].acctPolicy}"
  
  template = <<-EOT
    {%- set approved_accounts = $.exceptions_config.data.baseline | default([]) -%}
    {%- if $.account.Id in $.exceptions_config.data -%}
      {%- for approved_acct in $.exceptions_config.data[$.account.Id] -%}
        {%- if approved_acct not in approved_accounts -%}
          {%- set approved_accounts = (approved_accounts.push(approved_acct), approved_accounts) -%}
        {%- endif -%}
      {%- endfor -%}
    {%- endif -%}
    {{ approved_accounts | json }}
  EOT
  
  template_input = <<-EOT
    {
      exceptions_config: resource(id:"aws_trusted_access_exceptions_config"){
        data
      }
      account {
        Id
      }
    }
  EOT
}