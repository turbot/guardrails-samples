# GCP > Compute Engine > Instance > Active
resource "turbot_policy_setting" "gcp_computeengine_instance_active" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/gcp-computeengine#/policy/types/instanceActive"
  value    = "Check: Active"
  # value    = "Enforce: Delete inactive with 7 days warning"
}

# GCP > Compute Engine > Instance > Active > Age
resource "turbot_policy_setting" "gcp_computeengine_instance_active_age" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/gcp-computeengine#/policy/types/instanceActiveAge"
  value    = "Force inactive if age > 7 days"
}