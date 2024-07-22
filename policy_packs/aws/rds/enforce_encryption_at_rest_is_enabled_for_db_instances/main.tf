resource "turbot_policy_pack" "main" {
  title       = "Enforce Encryption At Rest Is Enabled For RDS DB Instances"
  description = "Ensure that all data is encrypted when stored, protecting it from unauthorized access and potential breaches, and ensuring compliance with security best practices."
  akas        = ["aws_rds_enforce_encryption_at_rest_is_enabled_for_db_instances"]
}
