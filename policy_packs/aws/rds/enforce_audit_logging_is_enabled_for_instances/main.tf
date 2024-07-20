resource "turbot_policy_pack" "main" {
  title       = "Enforce Audit Logging Is Enabled for AWS RDS Instances"
  description = "Ensuring that audit logging is enabled for RDS instances is crucial for enhancing security. This measure helps monitor database activities, thereby reducing the risk of unauthorized access and ensuring compliance with security best practices and regulatory requirements."
  akas        = ["aws_rds_enforce_audit_logging_is_enabled_for_instances"]
}
