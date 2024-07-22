resource "turbot_policy_pack" "main" {
  title       = "Enforce Point-In-Time Recovery Is Enabled For AWS DynamoDB Tables"
  description = "This measure allows you to restore DynamoDB tables to any point within the last 35 days, enhancing data recovery capabilities and ensuring compliance with data protection best practices and regulatory requirements."
  akas        = ["aws_dynamodb_enforce_point_in_time_recovery_is_enabled_for_tables"]
}
