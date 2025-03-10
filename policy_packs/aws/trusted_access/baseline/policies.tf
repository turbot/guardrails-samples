# Create policy settings for Trusted Access policies
resource "turbot_policy_setting" "trusted_access_policy" {
  for_each = var.trusted_access_policies
  
  resource = var.target_resource
  type     = each.key
  value    = each.value
  precedence = "REQUIRED"
  
  # Uncomment to enforce rather than just check
  # template_input = jsonencode({
  #   mode = var.policy_setting
  # })
}

# Create policy settings for Trusted Access > Accounts policies with calculated values
resource "turbot_policy_setting" "trusted_access_accounts_policy" {
  for_each = var.trusted_access_policies

  resource = var.target_resource
  type     = var.trusted_access_accounts_policies[each.key]
  
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
  
  precedence = "REQUIRED"
}