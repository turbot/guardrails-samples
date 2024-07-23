# AWS > EC2 > Instance > Schedule
resource "turbot_policy_setting" "aws_ec2_instance_schedule" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/aws-ec2#/policy/types/instanceSchedule"
  value    = "Skip"
  # value    = "Enforce: Business hours (8:00am - 6:00pm on weekdays)"
  # value    = "Enforce: Extended business hours (7:00am - 11:00pm on weekdays)"
  # value    = "Enforce: Stop for night (stop at 10:00pm every day)"
  # value    = "Enforce: Stop for weekend (stop at 10:00pm on Friday)"
}

# AWS > RDS > DB Cluster > Schedule
resource "turbot_policy_setting" "aws_rds_db_cluster_schedule" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/aws-rds#/policy/types/dbClusterSchedule"
  value    = "Skip"
  # value    = "Enforce: Business hours (8:00am - 6:00pm on weekdays)"
  # value    = "Enforce: Extended business hours (7:00am - 11:00pm on weekdays)"
  # value    = "Enforce: Stop for night (stop at 10:00pm every day)"
  # value    = "Enforce: Stop for weekend (stop at 10:00pm on Friday)"
}

# AWS > RDS > DB Instance > Schedule
resource "turbot_policy_setting" "aws_rds_db_instance_schedule" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/aws-rds#/policy/types/instanceSchedule"
  value    = "Skip"
  # value    = "Enforce: Business hours (8:00am - 6:00pm on weekdays)"
  # value    = "Enforce: Extended business hours (7:00am - 11:00pm on weekdays)"
  # value    = "Enforce: Stop for night (stop at 10:00pm every day)"
  # value    = "Enforce: Stop for weekend (stop at 10:00pm on Friday)"
}

# AWS > Redshift > Cluster > Schedule
resource "turbot_policy_setting" "aws_redshift_cluster_schedule" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/aws-redshift#/policy/types/clusterSchedule"
  value    = "Skip"
  # value    = "Enforce: Business hours (8:00am - 6:00pm on weekdays)"
  # value    = "Enforce: Extended business hours (7:00am - 11:00pm on weekdays)"
  # value    = "Enforce: Stop for night (stop at 10:00pm every day)"
  # value    = "Enforce: Stop for weekend (stop at 10:00pm on Friday)"
}
