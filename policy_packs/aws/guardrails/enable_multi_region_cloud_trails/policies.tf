# AWS > Turbot > Audit Trail
resource "turbot_policy_setting" "turbot_trail_configured" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/aws#/policy/types/auditTrail"
  value    = "Check: Configured"
  # value    = "Enforce: Configured"
}

# AWS > Turbot > Audit Trail > CloudTrail > Trail > Enabled
resource "turbot_policy_setting" "turbot_trail_enabled" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/aws#/policy/types/trailEnabled"
  value    = "Enabled"
}

# AWS > Turbot > Audit Trail > CloudTrail > Trail > Global Region
resource "turbot_policy_setting" "turbot_trail_configured_globalregion" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/aws#/policy/types/trailGlobalRegion"
  value    = "us-east-1"
}