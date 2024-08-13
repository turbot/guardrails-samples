# https://turbot.com/v5/mods/turbot/cis
resource "turbot_mod" "cis" {
  parent  = "tmod:@turbot/turbot#/"
  org     = "turbot"
  mod     = "cis"
  version = ">=5.0.0"
}
