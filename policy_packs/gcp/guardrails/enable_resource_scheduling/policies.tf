# GCP > Compute Engine > Instance > Schedule
resource "turbot_policy_setting" "gcp_compute_engine_instance_schedule" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/gcp-computeengine#/policy/types/instanceSchedule"
  value    = "Skip"
  # value    = "Enforce: Business hours (8:00am - 6:00pm on weekdays)"
  # value    = "Enforce: Extended business hours (7:00am - 11:00pm on weekdays)"
  # value    = "Enforce: Stop for night (stop at 10:00pm every day)"
  # value    = "Enforce: Stop for weekend (stop at 10:00pm on Friday)"
}
