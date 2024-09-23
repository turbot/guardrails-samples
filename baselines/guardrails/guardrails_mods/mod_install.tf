# https://hub.guardrails.turbot.com/mods/turbot/mods/cis
resource "turbot_mod" "cis" {
  parent  = "tmod:@turbot/turbot#/"
  org     = "turbot"
  mod     = "cis"
  version = ">=5.0.0"
}
