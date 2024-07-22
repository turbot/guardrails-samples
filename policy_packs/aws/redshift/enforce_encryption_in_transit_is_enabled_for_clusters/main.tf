resource "turbot_policy_pack" "main" {
  title       = "Enforce Encryption in Transit Is Enabled For AWS Redshift Clusters"
  description = "Ensure that all data is encrypted during transmission, safeguarding it from interception and unauthorized access, thereby enhancing overall security and compliance with best practices."
  akas        = ["aws_redshift_enforce_encryption_in_transit_is_enabled_for_clusters"]
}
