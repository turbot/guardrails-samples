resource "turbot_policy_pack" "enforce_backup_retention_period_for_db_instances" {
  title       = "Enforce Backup Retention Period for DB Instances"
  description = "Enforces minimum backup retention period for AWS RDS DB Instances."
  akas        = ["aws_rds_enforce_backup_retention_period_for_db_instances"]
}

# To test this policy pack by attaching it to a specific resource, uncomment the block below and provide a valid resource ID.
# For production, it is recommended to attach the policy pack manually in the Guardrails UI or via Terraform as needed.
#
resource "turbot_policy_pack_attachment" "test" {
  count       = var.test_resource_id != "" ? 1 : 0
  policy_pack = turbot_policy_pack.enforce_backup_retention_period_for_db_instances.id
  resource    = var.test_resource_id
}
