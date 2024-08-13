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

# https://hub.guardrails.turbot.com/mods/turbot/policies/turbot/stackTerraformVersion
resource "turbot_policy_setting" "turbot_stack_terraform_version" {
  resource = "tmod:@turbot/turbot#/"
  type     = "tmod:@turbot/turbot#/policy/types/stackTerraformVersion"
  value    = "0.15.*"
}

# https://hub.guardrails.turbot.com/mods/turbot/policies/turbot-iam/turbotConsoleSessionTimeoutMins
resource "turbot_policy_setting" "turbot_iam_turbot_console_session_timeout_mins" {
  resource = "tmod:@turbot/turbot#/"
  type     = "tmod:@turbot/turbot-iam#/policy/types/turbotConsoleSessionTimeoutMins"
  value    = 540
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

# https://hub.guardrails.turbot.com/mods/turbot/policies/turbot/notifications
# # Turbot > Notifications
# resource "turbot_policy_setting" "turbot_notifications" {
#   resource = "tmod:@turbot/turbot#/"
#   type     = "tmod:@turbot/turbot#/policy/types/notifications"
#   value    = "Enabled"
# }
