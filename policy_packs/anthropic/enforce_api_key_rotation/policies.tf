# Anthropic > API Key > Active
resource "turbot_policy_setting" "anthropic_api_key_active" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/anthropic#/policy/types/apiKeyActive"
  value    = "Check: Active"
  # value    = "Enforce: Disable inactive with 90 days warning"
}

# Anthropic > API Key > Active > Age
resource "turbot_policy_setting" "anthropic_api_key_active_age" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/anthropic#/policy/types/apiKeyActiveAge"
  value    = "Force inactive if age > 90 days"
}
