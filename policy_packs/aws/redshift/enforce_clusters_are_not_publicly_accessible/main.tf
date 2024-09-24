resource "turbot_policy_pack" "main" {
  title       = "Enforce AWS Redshift Clusters Are Not Publicly Accessible"
  description = "This measure prevents unauthorized internet access to your Redshift clusters, reducing the risk of data breaches and enhancing compliance with security best practices and regulatory requirements."
  akas        = ["aws_redshift_enforce_clusters_are_not_publicly_accessible"]
}
