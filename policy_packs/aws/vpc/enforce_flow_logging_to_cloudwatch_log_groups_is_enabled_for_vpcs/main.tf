resource "turbot_policy_pack" "main" {
  title       = "Enforce Flow Logging to CloudWatch Log Groups Is Enabled for AWS VPCs"
  description = "ensures that all network flow logs are captured and stored in CloudWatch Log Groups, enabling efficient detection of anomalous activity, troubleshooting of network issues, and compliance with security best practices and regulatory requirements."
  akas        = ["aws_vpc_enforce_flow_logging_to_cloudwatch_log_groups_is_enabled_for_vpcs"]
}
