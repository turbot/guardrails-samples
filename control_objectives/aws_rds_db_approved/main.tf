# RDS DB Instance Approved

# AWS > RDS > DB Instance > Approved 
 resource "turbot_policy_setting" "rds_db_approved" {
  resource = turbot_smart_folder.va_rds.id
  type = "tmod:@turbot/aws-rds#/policy/types/dbInstanceApproved"
  value = "Check: Approved"

}

#RDS Engines approved (Define engines, aurora, mariaDB, postgreSQL here as examples)
# AWS > RDS > DB Instance > Approved > Database Engines
 resource "turbot_policy_setting" "rds_db_approved_engine" {
  resource = turbot_smart_folder.va_rds.id
  type = "tmod:@turbot/aws-rds#/policy/types/dbInstanceApprovedDatabaseEngines"
  value = yamlencode(["aurora","mariaDB","postgreSQL"])
}

#RDS Instance Classes (Define instances, db.t3.* and db.m5.2xlarge as examples)
# AWS > RDS > DB Instance > Approved > Instance Classes
 resource "turbot_policy_setting" "rds_db_approved_instancetypes" {
  resource = turbot_smart_folder.va_rds.id
  type = "tmod:@turbot/aws-rds#/policy/types/dbInstanceApprovedInstanceClasses"
  value = yamlencode(["db.t3.*","db.m5.2xlarge"])
}