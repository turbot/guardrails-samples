# RDS Encryption at Rest

resource "turbot_smart_folder" "rds_storage_alarms" {
  title         = var.smart_folder_title
  description   = "Create a smart folder to set the RDS storage alarms policy"
  parent        = "tmod:@turbot/turbot#/"
}

# RDS DB Free Storage Space Alarms
# AWS > RDS > DB Instance > DB Free Storage Space Alarm

 resource "turbot_policy_setting" "rds_db_freespace" {
  resource = turbot_smart_folder.rds_storage_alarms.id
  type = "tmod:@turbot/aws-rds#/policy/types/dBInstanceFreeStorageSpaceAlarm"
  value = "Check: No alarm"
}