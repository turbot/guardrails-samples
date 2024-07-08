# RDS DB Instance Approved

resource "turbot_smart_folder" "rds_engine_instance_type_approved" {
  title         = var.smart_folder_title
  description   = "Create a smart folder to apply the RDS policy settings"
  parent        = "tmod:@turbot/turbot#/"
}

# AWS > RDS > DB Instance > Approved 
 resource "turbot_policy_setting" "rds_db_approved" {
  resource = turbot_smart_folder.rds_engine_instance_type_approved.id
  type = "tmod:@turbot/aws-rds#/policy/types/dbInstanceApproved"
  value = "Check: Approved"

}

#RDS Engines approved (Define engines, aurora, mariaDB, postgreSQL here as examples). ENGINES MUST BE LOWER CASE
# AWS > RDS > DB Instance > Approved > Database Engines

 resource "turbot_policy_setting" "rds_db_approved_engine" {
  resource = turbot_smart_folder.rds_engine_instance_type_approved.id
  type = "tmod:@turbot/aws-rds#/policy/types/dbInstanceApprovedDatabaseEngines"
  value = yamlencode(["aurora","mariadb","postgresql"])
}

#RDS Instance Classes (Define instances, db.t3.* and db.m5.2xlarge as examples)
# AWS > RDS > DB Instance > Approved > Instance Classes
 resource "turbot_policy_setting" "rds_db_approved_instancetypes" {
  resource = turbot_smart_folder.rds_engine_instance_type_approved.id
  type = "tmod:@turbot/aws-rds#/policy/types/dbInstanceApprovedInstanceClasses"
  value = yamlencode(["db.t3.*","db.m5.2xlarge"])
}