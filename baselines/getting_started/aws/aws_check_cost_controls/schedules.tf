# Setting Resource Schedules to start/stop based on schedule
# Set to Skip to avoid accidently Enforcement.
# More Info: https://turbot.com/v5/docs/concepts/guardrails/scheduling


# Policy Setting Options:
# Skip
# Enforce: Business hours (8:00am - 6:00pm on weekdays)
# Enforce: Extended business hours (7:00am - 11:00pm on weekdays)
# Enforce: Stop for night (stop at 10:00pm every day)
# Enforce: Stop for weekend (stop at 10:00pm on Friday)


## EC2 Instances
resource "turbot_policy_setting" "ec2_instance_schedule" {
  resource = turbot_smart_folder.aws_cost_controls.id
  type     = "tmod:@turbot/aws-ec2#/policy/types/instanceSchedule"
  value    = "Skip"
}

# # Schedule Tag Option, more information https://turbot.com/v5/docs/concepts/guardrails/scheduling#scheduling-with-a-tag
# resource "turbot_policy_setting" "aws_ec2_instance_schedule_tag" {
# resource = turbot_smart_folder.aws_cost_controls.id
#  type     = "tmod:@turbot/aws-ec2#/policy/types/instanceScheduleTag"
#  value    = "Skip" 
            # "Enforce: Schedule per turbot_custom_schedule tag"


## Commented out the following since these services are not in the initial mod installed baseline

# # AWS RDS DB Cluster Schedule
# resource "turbot_policy_setting" "aws_rds_db_cluster_schedule" {
#   resource = turbot_smart_folder.aws_cost_controls.id
#   type     = "tmod:@turbot/aws-rds#/policy/types/dbClusterSchedule"
#   value    = "Skip"
# }

# # AWS RDS DB Instance Schedule
# resource "turbot_policy_setting" "aws_rds_db_instance_schedule" {
#   resource = turbot_smart_folder.aws_cost_controls.id
#   type     = "tmod:@turbot/aws-rds#/policy/types/instanceSchedule"
#   value    = "Skip"
# }

# # AWS Redshift Cluster Schedule
# resource "turbot_policy_setting" "aws_redshift_cluster_schedule" {
#   resource = turbot_smart_folder.aws_cost_controls.id
#   type     = "tmod:@turbot/aws-redshift#/policy/types/clusterSchedule"
#   value    = "Skip"
# }

# # AWS Workspace Schedule
# resource "turbot_policy_setting" "aws_workspace_schedule" {
#   resource = turbot_smart_folder.aws_cost_controls.id
#   type     = "tmod:@turbot/aws-workspaces#/policy/types/workspaceSchedule"
#   value    = "Skip"
# }