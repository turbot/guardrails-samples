# Smart Folder Definition
resource "turbot_smart_folder" "resource_scheduling" {
  title       = var.smart_folder_title
  description = var.smart_folder_description
  parent      = var.smart_folder_parent_resource
}

# Below examples assumes all available resource scheduling across multi-cloud
# Edit the template below to meet your requirements.

# Possible Setting Values, assumed Skip for the template to avoid an Enforce mistake:
# Skip
# Enforce: Business hours (8:00am - 6:00pm on weekdays)
# Enforce: Extended business hours (7:00am - 11:00pm on weekdays)
# Enforce: Stop for night (stop at 10:00pm every day)
# Enforce: Stop for weekend (stop at 10:00pm on Friday)


### AWS ###
## AWS EC2 Instance
resource "turbot_policy_setting" "aws_ec2_instance_schedule" {
  resource = turbot_smart_folder.resource_scheduling.id
  type     = "tmod:@turbot/aws-ec2#/policy/types/instanceSchedule"
  value    = "Skip"
}

# # Schedule Tag Option, more information https://turbot.com/v5/docs/concepts/guardrails/scheduling#scheduling-with-a-tag
# resource "turbot_policy_setting" "aws_ec2_instance_schedule_tag" {
# resource = turbot_smart_folder.resource_scheduling.id
#  type     = "tmod:@turbot/aws-ec2#/policy/types/instanceScheduleTag"
#  value    = "Enforce: Schedule per turbot_custom_schedule tag"


# AWS RDS DB Cluster Schedule
resource "turbot_policy_setting" "aws_rds_db_cluster_schedule" {
  resource = turbot_smart_folder.resource_scheduling.id
  type     = "tmod:@turbot/aws-rds#/policy/types/dbClusterSchedule"
  value    = "Skip"
}

# AWS RDS DB Instance Schedule
resource "turbot_policy_setting" "aws_rds_db_instance_schedule" {
  resource = turbot_smart_folder.resource_scheduling.id
  type     = "tmod:@turbot/aws-rds#/policy/types/instanceSchedule"
  value    = "Skip"
}

# AWS Redshift Cluster Schedule
resource "turbot_policy_setting" "aws_redshift_cluster_schedule" {
  resource = turbot_smart_folder.resource_scheduling.id
  type     = "tmod:@turbot/aws-redshift#/policy/types/clusterSchedule"
  value    = "Skip"
}

# AWS Workspace Schedule
resource "turbot_policy_setting" "aws_workspace_schedule" {
  resource = turbot_smart_folder.resource_scheduling.id
  type     = "tmod:@turbot/aws-workspaces#/policy/types/workspaceSchedule"
  value    = "Skip"
}

### Azure ###
# Azure Virtual Machine Schedule
resource "turbot_policy_setting" "azure_compute_vm_schedule" {
  resource = turbot_smart_folder.resource_scheduling.id
  type     = "tmod:@turbot/azure-compute#/policy/types/virtualMachineSchedule"
  value    = "Skip"
}

### GCP ###
# GCP Compute Instance Schedule
resource "turbot_policy_setting" "gcp_compute_instance_schedule" {
  resource = turbot_smart_folder.resource_scheduling.id
  type     = "tmod:@turbot/gcp-computeengine#/policy/types/instanceSchedule"
  value    = "Skip"
}
