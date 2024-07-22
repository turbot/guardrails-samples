# AWS > DynamoDB > Table > Point-in-Time Recovery
resource "turbot_policy_setting" "dynamodb_point_in_time_recovery_enabled" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/aws-dynamodb#/policy/types/tablePointInTimeRecovery"
  value    = "Check: Enabled"
  # value    = "Enforce: Enabled"
}