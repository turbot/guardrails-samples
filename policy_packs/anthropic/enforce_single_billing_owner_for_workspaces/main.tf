resource "turbot_policy_pack" "main" {
  title       = "Enforce a Single Billing Owner for Anthropic Workspaces"
  description = "Keep billing accountability clear by requiring each Anthropic workspace to have at most one workspace_billing member."
  akas        = ["anthropic_enforce_single_billing_owner_for_workspaces"]
}
