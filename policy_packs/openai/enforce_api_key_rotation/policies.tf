# OpenAI > Project > API Key > Active
resource "turbot_policy_setting" "openai_api_key_active" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/openai#/policy/types/apiKeyActive"
  value    = "Check: Active"
  # value    = "Enforce: Delete inactive with 90 days warning"
}

# OpenAI > Project > API Key > Active > Recently Used
resource "turbot_policy_setting" "openai_api_key_active_recently_used" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/openai#/policy/types/apiKeyActiveRecentlyUsed"
  value    = "Active if recently used <= 90 days"
}
