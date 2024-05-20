# AWS Logging Policies for various services
# More Info: https://turbot.com/v5/docs/concepts/guardrails/audit-logging

# Policy Settings:
# Skip
# Check: Disabled
# Check: Enabled
# Check: Enabled to Audit Logging > Bucket
# Enforce: Disabled
# Enforce: Enabled to Audit Logging > Bucket


# AWS > Redshift > Cluster > Audit Logging
# https://turbot.com/v5/mods/turbot/aws-redshift/inspect#/policy/types/clusterAuditLogging
resource "turbot_policy_setting" "aws_redshift_cluster_access_logging" {
  count    = var.enable_redshift_cluster_access_logging ? 1 : 0
  resource = turbot_smart_folder.aws_logging.id
  type     = "tmod:@turbot/aws-redshift#/policy/types/clusterAuditLogging"
  value    = "Check: Enabled"
}

# AWS > Redshift > Cluster > Audit Logging > User Activity Logging
# https://turbot.com/v5/mods/turbot/aws-redshift/inspect#/policy/types/clusterAuditLoggingUserActivityLogging
resource "turbot_policy_setting" "aws_redshift_cluster_user_activity_logging" {
  count    = var.enable_redshift_cluster_user_logging ? 1 : 0
  resource = turbot_smart_folder.aws_logging.id
  type     = "tmod:@turbot/aws-redshift#/policy/types/clusterAuditLoggingUserActivityLogging"
  value    = "Enabled"
}
