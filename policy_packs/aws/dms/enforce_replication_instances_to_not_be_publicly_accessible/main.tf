resource "turbot_policy_pack" "main" {
  title       = "Enforce AWS DMS Replication Instances to Restrict Public Access"
  description = "Mitigate the risk of unauthorized access, potential data breaches, and ensures compliance with security best practices and regulatory requirements."
  akas        = ["aws_dms_enforce_replication_instances_to_not_be_publicly_accessible"]
}
