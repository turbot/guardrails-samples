# This is an example of IAM Lockdown Permissions and Turbot AWS RBAC that can be set
# Assumes your use of Turbot AWS RBAC; setting these policies will only set conditions, nothing will action or check.
# If you are not using Turbot AWS RBAC controls you can ignore this part of the baseline

resource "turbot_policy_setting" "aws_s3_s3_permissions_levels" {
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

resource "turbot_policy_setting" "aws_s3_s3_permissions_levels_cross_replication_administration" {
  resource = turbot_smart_folder.aws_all_s3.id
  type     = "tmod:@turbot/aws-s3#/policy/types/s3PermissionsLevelsCrossReplicationAdministration"
  value    = "None"
}

resource "turbot_policy_setting" "aws_s3_s3_permissions_levels_cors_administration" {
  resource = turbot_smart_folder.aws_all_s3.id
  type     = "tmod:@turbot/aws-s3#/policy/types/s3PermissionsLevelsCorsAdministration"
  value    = "None"
}

resource "turbot_policy_setting" "aws_s3_s3_permissions_levels_acl_administration" {
  resource = turbot_smart_folder.aws_all_s3.id
  type     = "tmod:@turbot/aws-s3#/policy/types/s3PermissionsLevelsAclAdministration"
  value    = "None"
}

resource "turbot_policy_setting" "aws_s3_s3_permissions_levels_access_logging_administration" {
  resource = turbot_smart_folder.aws_all_s3.id
  type     = "tmod:@turbot/aws-s3#/policy/types/s3PermissionsLevelsAccessLoggingAdministration"
  value    = "None"
}

resource "turbot_policy_setting" "aws_s3_s3_api_enabled" {
  resource = turbot_smart_folder.aws_all_s3.id
  type     = "tmod:@turbot/aws-s3#/policy/types/s3ApiEnabled"
  value    = "Enabled"
}

resource "turbot_policy_setting" "aws_s3_s3_enabled" {
  resource = turbot_smart_folder.aws_all_s3.id
  type     = "tmod:@turbot/aws-s3#/policy/types/s3Enabled"
  value    = "Enabled"
}