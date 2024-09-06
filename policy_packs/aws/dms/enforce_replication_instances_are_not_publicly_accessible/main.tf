resource "turbot_policy_pack" "main" {
  title       = "Enforce AWS DMS Replication Instances Are Not Publicly Accessible"
  description = "Mitigate the risk of unauthorized access, potential data breaches, and ensures compliance with security best practices and regulatory requirements."
  akas        = ["aws_dms_enforce_replication_instances_are_not_publicly_accessible"]
}
