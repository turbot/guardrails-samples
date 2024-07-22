resource "turbot_policy_pack" "main" {
  title       = "Check SSL Requirement for Redshift Clusters"
  description = "Ensure that SSL is required for Redshift clusters to enhance security by encrypting data in transit."
  akas        = ["aws_redshift_check_ssl_requirement_for_clusters"]
}