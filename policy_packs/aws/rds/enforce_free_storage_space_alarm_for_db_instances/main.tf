resource "turbot_policy_pack" "main" {
  title       = "Enforce Free Storage Space Alarm for DB Instances"
  description = "Ensure that RDS instances have a configured alarm for free storage space to monitor and manage storage utilization effectively."
  akas        = ["aws_rds_enforce_free_storage_space_alarm_for_db_instances"]
}
