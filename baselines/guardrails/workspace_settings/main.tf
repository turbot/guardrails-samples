# https://hub.guardrails.turbot.com/mods/turbot/policies/turbot/quickActionsEnabled
resource "turbot_policy_setting" "turbot_quick_actions_enabled" {
  resource = "tmod:@turbot/turbot#/"
  type     = "tmod:@turbot/turbot#/policy/types/quickActionsEnabled"
  value    = "Enabled"
  # Enabled
  # Disabled
}

# https://hub.guardrails.turbot.com/mods/turbot/policies/turbot/retention
resource "turbot_policy_setting" "turbot_retention" {
  resource = "tmod:@turbot/turbot#/"
  type     = "tmod:@turbot/turbot#/policy/types/retention"
  value    = "Enforce: Enable purging via Smart Retention"
  # Skip
  # Check: Preview purging via Smart Retention
  # Enforce: Enable purging via Smart Retention
}

# https://hub.guardrails.turbot.com/mods/turbot/policies/turbot/maximumRetention
resource "turbot_policy_setting" "turbot_maximum_retention" {
  resource = "tmod:@turbot/turbot#/"
  type     = "tmod:@turbot/turbot#/policy/types/maximumRetention"
  value    = 90
  # Minimum: 1
  # Default: 365
}

# https://hub.guardrails.turbot.com/mods/turbot/policies/turbot/resourcePurgeLimit
resource "turbot_policy_setting" "turbot_resource_purge_limit" {
  resource = "tmod:@turbot/turbot#/"
  type     = "tmod:@turbot/turbot#/policy/types/resourcePurgeLimit"
  value    = 500
  # Minimum: 1
  # Default: 30
}

# https://hub.guardrails.turbot.com/mods/turbot/policies/turbot/activityRetention
resource "turbot_policy_setting" "turbot_activity_retention" {
  resource = "tmod:@turbot/turbot#/"
  type     = "tmod:@turbot/turbot#/policy/types/activityRetention"
  value    = "90 days"
  # Minimum: "30 days"
  # Default: None
}

# https://hub.guardrails.turbot.com/mods/turbot/policies/turbot/activityPurgeLimit
resource "turbot_policy_setting" "turbot_activity_purge_limit" {
  resource = "tmod:@turbot/turbot#/"
  type     = "tmod:@turbot/turbot#/policy/types/activityPurgeLimit"
  value    = 100
  # Minimum: 1
  # Default: 100
}

# https://hub.guardrails.turbot.com/mods/turbot/policies/turbot/accountStatisticsRetention
resource "turbot_policy_setting" "account_statistics_retention" {
  resource = "tmod:@turbot/turbot#/"
  type     = "tmod:@turbot/turbot#/policy/types/accountStatisticsRetention"
  value    = "90 days"
  # Minimum: "30 days"
  # Default: "30 days"
}

# https://hub.guardrails.turbot.com/mods/turbot/policies/turbot/accountStatisticsRetentionPurgeLimit
resource "turbot_policy_setting" "account_statistics_retention_purge_limit" {
  resource = "tmod:@turbot/turbot#/"
  type     = "tmod:@turbot/turbot#/policy/types/accountStatisticsRetentionPurgeLimit"
  value    = 100
  # Minimum: 1
  # Default: 100
}

# https://hub.guardrails.turbot.com/mods/turbot/policies/turbot/stackTerraformVersion
resource "turbot_policy_setting" "turbot_stack_terraform_version" {
  resource = "tmod:@turbot/turbot#/"
  type     = "tmod:@turbot/turbot#/policy/types/stackTerraformVersion"
  value    = "0.15.*"
}

# https://hub.guardrails.turbot.com/mods/turbot/policies/turbot/modAutoUpdate
resource "turbot_policy_setting" "turbot_mod_auto_update" {
  resource = "tmod:@turbot/turbot#/"
  type     = "tmod:@turbot/turbot#/policy/types/modAutoUpdate"
  value    = "Enforce within Mod Change Window"
}

# https://hub.guardrails.turbot.com/mods/turbot/policies/turbot/modChangeWindowSchedule
resource "turbot_policy_setting" "turbot_mod_change_window_schedule" {
  resource = "tmod:@turbot/turbot#/"
  type     = "tmod:@turbot/turbot#/policy/types/modChangeWindowSchedule"
  value    = <<-EOT
    - name: Weekly
      description: 'Weekly, Saturday 09:00 AM to Saturday 09:00 PM UTC'
      cron: '0 9 * * SAT'
      duration: 12
    EOT
}
