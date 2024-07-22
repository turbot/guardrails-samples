# AWS > RDS > DB Instance > Publicly Accessible
resource "turbot_policy_setting" "aws_rds_db_instance_publicly_accessible" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/aws-rds#/policy/types/dbInstancePubliclyAccessible"
  value    = "Check: DB Instance is not publicly accessible"
  # value    = "Enforce: DB Instance is not publicly accessible"
}
