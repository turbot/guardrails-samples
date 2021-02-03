# AWS Logging Policies for various services
# More Info: https://turbot.com/v5/docs/concepts/guardrails/audit-logging

# Policy Settings:
    # Skip
    # Check: Disabled
    # Check: Enabled
    # Check: Enabled to Access Logging > Bucket
    # Enforce: Disabled
    # Enforce: Enabled to Access Logging > Bucket


# Application Load Balancer (ALB) Access Logging Check
resource "turbot_policy_setting" "aws_alb_access_logging" {
  resource = turbot_smart_folder.aws_logging.id
  type     = "tmod:@turbot/aws-ec2#/policy/types/applicationLoadBalancerAccessLogging"
  value    = "Check: Enabled"
}

# Classic Load Balancer (ELB) Access Logging Check
resource "turbot_policy_setting" "aws_elb_access_logging" {
  resource = turbot_smart_folder.aws_logging.id
  type     = "tmod:@turbot/aws-ec2#/policy/types/classicLoadBalancerAccessLogging"
  value    = "Check: Enabled"
}

# Network Load Balancer (NLB) Access Logging Check
resource "turbot_policy_setting" "aws_nlb_access_logging" {
  resource = turbot_smart_folder.aws_logging.id
  type     = "tmod:@turbot/aws-ec2#/policy/types/networkLoadBalancerAccessLogging"
  value    = "Check: Enabled"
}

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
resource "turbot_policy_setting" "aws_s3_bucket_access_logging" {
  resource = turbot_smart_folder.aws_logging.id
  type     = "tmod:@turbot/aws-s3#/policy/types/bucketAccessLogging"
  value    = "Check: Enabled"
}