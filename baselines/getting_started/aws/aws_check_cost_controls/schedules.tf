# Setting Resource Schedules to start/stop based on schedule
# Set to Skip to avoid accidently Enforcement.
# More Info: https://turbot.com/v5/docs/concepts/guardrails/scheduling


# Policy Setting Options:
# Skip
# Enforce: Business hours (8:00am - 6:00pm on weekdays)
# Enforce: Extended business hours (7:00am - 11:00pm on weekdays)
# Enforce: Stop for night (stop at 10:00pm every day)
# Enforce: Stop for weekend (stop at 10:00pm on Friday)

# AWS EC2 Instance Schedule
# AWS > EC2 > Instance > Schedule
# https://turbot.com/v5/mods/turbot/aws-ec2/inspect#/policy/types/instanceSchedule
resource "turbot_policy_setting" "ec2_instance_schedule" {
  resource = turbot_smart_folder.aws_cost_controls.id
  type     = "tmod:@turbot/aws-ec2#/policy/types/instanceSchedule"
  value    = "Skip"
}

# AWS EC2 Instance Schedule Tag
# AWS > EC2 > Instance > Schedule
# https://turbot.com/v5/docs/concepts/guardrails/scheduling#scheduling-with-a-tag
resource "turbot_policy_setting" "aws_ec2_instance_schedule_tag" {
resource = turbot_smart_folder.aws_cost_controls.id
 type     = "tmod:@turbot/aws-ec2#/policy/types/instanceScheduleTag"
 value    = "Skip" 
}

## Commented out the following since these services are not in the initial mod installed baseline

# # AWS RDS DB Cluster Schedule
# # AWS > RDS > DB Cluster > Schedule
# # https://turbot.com/v5/mods/turbot/aws-rds/inspect#/policy/types/dbClusterSchedule
# resource "turbot_policy_setting" "aws_rds_db_cluster_schedule" {
#   resource = turbot_smart_folder.aws_cost_controls.id
#   type     = "tmod:@turbot/aws-rds#/policy/types/dbClusterSchedule"
#   value    = "Skip"
# }

# # AWS RDS DB Cluster Schedule Tag
# # AWS > RDS > DB Cluster > Schedule Tag
# # https://turbot.com/v5/mods/turbot/aws-rds/inspect#/policy/types/dbClusterScheduleTag
# resource "turbot_policy_setting" "aws_rds_cluster_schedule_tag" {
# resource = turbot_smart_folder.aws_cost_controls.id
#  type     = "tmod:@turbot/aws-rds#/policy/types/dbClusterScheduleTag"
#  value    = "Skip"
# }

# # AWS RDS DB Instance Schedule
# AWS > RDS > DB Instance > Schedule
# https://turbot.com/v5/mods/turbot/aws-rds/inspect#/policy/types/instanceSchedule
# resource "turbot_policy_setting" "aws_rds_db_instance_schedule" {
#   resource = turbot_smart_folder.aws_cost_controls.id
#   type     = "tmod:@turbot/aws-rds#/policy/types/instanceSchedule"
#   value    = "Skip"
# }

# # AWS RDS DB Instance Schedule Tag
# # AWS > RDS > DB Cluster > Schedule Tag
# # https://turbot.com/v5/mods/turbot/aws-rds/inspect#/policy/types/instanceScheduleTag
# resource "turbot_policy_setting" "aws_rds_cluster_schedule_tag" {
# resource = turbot_smart_folder.aws_cost_controls.id
#  type     = "tmod:@turbot/aws-rds#/policy/types/instanceScheduleTag"
#  value    = "Skip"
# }

# # AWS Redshift Cluster Schedule
# # AWS > Redshift > Cluster > Schedule
# # https://turbot.com/v5/mods/turbot/aws-redshift/inspect#/policy/types/clusterSchedule
# resource "turbot_policy_setting" "aws_redshift_cluster_schedule" {
#   resource = turbot_smart_folder.aws_cost_controls.id
#   type     = "tmod:@turbot/aws-redshift#/policy/types/clusterSchedule"
#   value    = "Skip"
# }

# # AWS Redshift Cluster Schedule Tag
# # AWS > Redshift > Cluster > Schedule Tag
# # https://turbot.com/v5/mods/turbot/aws-redshift/inspect#/policy/types/clusterScheduleTag
# resource "turbot_policy_setting" "aws_redshift_cluster_schedule_tag" {
#   resource = turbot_smart_folder.aws_cost_controls.id
#   type     = "tmod:@turbot/aws-redshift#/policy/types/clusterScheduleTag"
#   value    = "Skip"
# }

# # AWS Workspace Schedule
# # AWS > WorkSpaces > WorkSpace > Schedule
# # https://turbot.com/v5/mods/turbot/aws-workspaces/inspect#/policy/types/workspaceSchedule
# resource "turbot_policy_setting" "aws_workspace_schedule" {
#   resource = turbot_smart_folder.aws_cost_controls.id
#   type     = "tmod:@turbot/aws-workspaces#/policy/types/workspaceSchedule"
#   value    = "Skip"
# }

# # AWS Workspace Schedule Tag
# # AWS > WorkSpaces > WorkSpace > Schedule Tag
# # https://turbot.com/v5/mods/turbot/aws-workspaces/inspect#/policy/types/workspaceScheduleTag
# resource "turbot_policy_setting" "aws_workspace_schedule_tag" {
#   resource = turbot_smart_folder.aws_cost_controls.id
#   type     = "tmod:@turbot/aws-workspaces#/policy/types/workspaceScheduleTag"
#   value    = "Skip"
# }