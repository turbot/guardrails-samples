// https://turbot.com/v5/mods/turbot/turbot/inspect#/policy/types/retention
resource "turbot_policy_setting" "turbot_smart_retention" {
  resource = "tmod:@turbot/turbot#/"
  type     = "tmod:@turbot/turbot#/policy/types/retention"
  value    = "Enforce: Enable purging via Smart Retention"
  //Skip
  //Check: Preview purging via Smart Retention
  //Enforce: Enable purging via Smart Retention
}

resource "turbot_policy_setting" "sr_debug_log_retention" {
  resource = "tmod:@turbot/turbot#/"
  type     = "tmod:@turbot/turbot#/policy/types/debugLogRetention"
  value    = var.debug_logs
  //Minimum value: 1
  //Default: 14
}

resource "turbot_policy_setting" "sr_max_retention" {
  resource = "tmod:@turbot/turbot#/"
  type     = "tmod:@turbot/turbot#/policy/types/maximumRetention"
  value    = var.max_retention
  //  minimum: 1,
  //  default: 365,
}

// https://turbot.com/v5/mods/turbot/turbot/inspect#/policy/types/minimumRetention
resource "turbot_policy_setting" "sr_min_retention" {
  resource = "tmod:@turbot/turbot#/"
  type     = "tmod:@turbot/turbot#/policy/types/minimumRetention"
  value    = var.min_retention
  //   minimum: 1,
  //  default: 7,
}

// https://turbot.com/v5/mods/turbot/turbot/inspect#/policy/types/resourcePurgeLimit
resource "turbot_policy_setting" "sr_purge_limit" {
  resource = "tmod:@turbot/turbot#/"
  type     = "tmod:@turbot/turbot#/policy/types/resourcePurgeLimit"
  value    = var.purge_limit
  //  minimum: 1
  //  default: 30
}
