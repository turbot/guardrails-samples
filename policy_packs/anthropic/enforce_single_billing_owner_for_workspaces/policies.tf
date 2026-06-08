# Anthropic > Workspace > Excess Billing
resource "turbot_policy_setting" "anthropic_workspace_excess_billing" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/anthropic#/policy/types/workspaceExcessBilling"
  value    = "Check: Enabled"
  # value    = "Enforce: Demote excess to workspace_user"
}

# Anthropic > Workspace > Excess Billing > Target Role
resource "turbot_policy_setting" "anthropic_workspace_excess_billing_target_role" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/anthropic#/policy/types/workspaceExcessBillingTargetRole"
  value    = "workspace_user"
}
