resource "turbot_policy_pack" "main" {
  title       = "Deny Public Access to AWS EMR Clusters"
  description = "Denies the launch of EMR clusters if any security groups allow inbound traffic from all public addresses."
  akas        = ["aws_emr_deny_public_access_to_emr_clusters"]
}
