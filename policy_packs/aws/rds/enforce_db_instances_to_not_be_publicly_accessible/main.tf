resource "turbot_policy_pack" "main" {
  title       = "Enforce AWS RDS DB Instances Are Not Publicly Accessible"
  description = "This measure prevents unauthorized internet access to your RDS instances, reducing the risk of data breaches and enhancing compliance with security best practices and regulatory requirements."
  akas        = ["aws_rds_enforce_db_instances_to_not_be_publicly_accessible"]
}
