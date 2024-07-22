resource "turbot_policy_pack" "main" {
  title       = "Enforce AWS RDS DB Instances to Use Specific Engines and Instance Classes"
  description = "Ensure that RDS instances comply with organizational policies, meet performance and security requirements, and align with best practices for cost management and resource utilization."
  akas        = ["aws_rds_enforce_db_instances_to_use_specific_engines_and_instance_classes"]
}
