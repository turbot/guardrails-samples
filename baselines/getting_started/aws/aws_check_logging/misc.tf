# AWS Logging Policies for various services
# More Info: https://turbot.com/v5/docs/concepts/guardrails/audit-logging

# Policy Settings:
    # Skip
    # Check: Disabled
    # Check: Enabled
    # Check: Enabled to Access Logging > Bucket
    # Enforce: Disabled
    # Enforce: Enabled to Access Logging > Bucket


# # Commented out as Redshift is not included in the initial mod install baseline
# # Redshift Cluster Access Logging Check
# resource "turbot_policy_setting" "aws_redshift_cluster_access_logging" {
#   resource = turbot_smart_folder.aws_logging.id
#   type     = "tmod:@turbot/aws-redshift#/policy/types/clusterAuditLogging"
#   value    = "Check: Enabled"
# }

# # Redshift Cluster User Activity Logging Enabled
# resource "turbot_policy_setting" "aws_redshift_cluster_user_activity_logging" {
#   resource = turbot_smart_folder.aws_logging.id
#   type     = "tmod:@turbot/aws-redshift#/policy/types/clusterAuditLoggingUserActivityLogging"
#   value    = "Enabled"
# }

# S3 Bucket Access Logging Check
# Commenting out here as this policy is being set under aws_check_s3
# resource "turbot_policy_setting" "aws_s3_bucket_access_logging" {
#   resource = turbot_smart_folder.aws_logging.id
#   type     = "tmod:@turbot/aws-s3#/policy/types/bucketAccessLogging"
#   value    = "Check: Enabled"
# }