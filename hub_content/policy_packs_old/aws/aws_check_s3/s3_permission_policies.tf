# This is an example of IAM Lockdown Permissions and Turbot AWS RBAC that can be set
# Assumes your use of Turbot AWS RBAC; setting these policies will only set conditions, nothing will action or check.
# If you are not using Turbot AWS RBAC controls you can ignore this part of the baseline

# AWS > S3 > Permissions > Levels
# https://turbot.com/v5/mods/turbot/aws-s3/inspect#/policy/types/s3PermissionsLevels
resource "turbot_policy_setting" "aws_s3_s3_permissions_levels" {
  count    = var.enable_s3_permission_policies ? 1 : 0
  resource = turbot_smart_folder.aws_all_s3.id
  type     = "tmod:@turbot/aws-s3#/policy/types/s3PermissionsLevels"
  value    = <<EOT
    - Metadata
    - ReadOnly
    - Operator
    - Admin
    - Owner
  EOT
}

# AWS > S3 > Permissions > Levels > Cross Replication Administration
# https://turbot.com/v5/mods/turbot/aws-s3/inspect#/policy/types/s3PermissionsLevelsCrossReplicationAdministration
resource "turbot_policy_setting" "aws_s3_s3_permissions_levels_cross_replication_administration" {
  count    = var.enable_s3_permission_policies ? 1 : 0
  resource = turbot_smart_folder.aws_all_s3.id
  type     = "tmod:@turbot/aws-s3#/policy/types/s3PermissionsLevelsCrossReplicationAdministration"
  value    = "None"
}

# AWS > S3 > Permissions > Levels > CORS Administration
# https://turbot.com/v5/mods/turbot/aws-s3/inspect#/policy/types/s3PermissionsLevelsCorsAdministration
resource "turbot_policy_setting" "aws_s3_s3_permissions_levels_cors_administration" {
  count    = var.enable_s3_permission_policies ? 1 : 0
  resource = turbot_smart_folder.aws_all_s3.id
  type     = "tmod:@turbot/aws-s3#/policy/types/s3PermissionsLevelsCorsAdministration"
  value    = "None"
}

# AWS > S3 > Permissions > Levels > ACL Administration
# https://turbot.com/v5/mods/turbot/aws-s3/inspect#/policy/types/s3PermissionsLevelsAclAdministration
resource "turbot_policy_setting" "aws_s3_s3_permissions_levels_acl_administration" {
  count    = var.enable_s3_permission_policies ? 1 : 0
  resource = turbot_smart_folder.aws_all_s3.id
  type     = "tmod:@turbot/aws-s3#/policy/types/s3PermissionsLevelsAclAdministration"
  value    = "None"
}

# AWS > S3 > Permissions > Levels > Access Logging Administration
# https://turbot.com/v5/mods/turbot/aws-s3/inspect#/policy/types/s3PermissionsLevelsAccessLoggingAdministration
resource "turbot_policy_setting" "aws_s3_s3_permissions_levels_access_logging_administration" {
  count    = var.enable_s3_permission_policies ? 1 : 0
  resource = turbot_smart_folder.aws_all_s3.id
  type     = "tmod:@turbot/aws-s3#/policy/types/s3PermissionsLevelsAccessLoggingAdministration"
  value    = "None"
}
