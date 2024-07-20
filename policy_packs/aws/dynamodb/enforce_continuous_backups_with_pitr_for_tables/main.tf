resource "turbot_policy_pack" "main" {
  title       = "Enforce AWS DynamoDB Table Continuous Backup with Point-In-Time Recovery"
  description = "This measure ensures data resilience and minimizes data loss by allowing the restoration of DynamoDB tables to any point in time within the last 35 days, protecting against accidental deletions, corruption, or other data mishaps."
  akas        = ["aws_dynamodb_enforce_continuous_backups_with_pitr_for_tables"]
}
