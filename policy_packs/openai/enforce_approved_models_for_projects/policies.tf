# OpenAI > Project > Approved Models
resource "turbot_policy_setting" "openai_project_rate_limit_approved_models" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/openai#/policy/types/projectRateLimitApprovedModels"
  value    = "Check: Approved"
  # value    = "Enforce: Set zero-RPM on disallowed models"
  # value    = "Enforce: Set zero-RPM on disallowed models if new"
}

# OpenAI > Project > Approved Models > Approved Models List
resource "turbot_policy_setting" "openai_project_rate_limit_approved_models_list" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/openai#/policy/types/projectRateLimitApprovedModelsList"
  value    = <<-EOT
    - "gpt-4o"
    - "gpt-4o-mini"
    - "text-embedding-3-large"
    EOT
}
