resource "turbot_policy_pack" "main" {
  title       = "Enforce Encryption at Rest for AWS RDS Instances"
  description = "Ensure that RDS instances are encrypted for enhanced security."
  akas        = ["aws_rds_enforce_encryption_at_rest_for_instances"]
}
