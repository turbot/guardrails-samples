resource "turbot_policy_pack" "main" {
  title       = "Enforce Encryption for AWS Athena Workgroups"
  description = "Ensures that AWS Athena workgroups have encryption enabled for query results stored in Amazon S3."
  akas        = ["aws_athena_enforce_encryption_for_workgroups"]
}
