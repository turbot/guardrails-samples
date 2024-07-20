resource "turbot_policy_pack" "main" {
  title       = "Enforce Instances to Use Specific Engine and Instance Type"
  description = "Ensure that RDS instances are using the specified engine and instance type to maintain consistency and adhere to organizational standards."
  akas        = ["aws_rds_enforce_instances_to_use_specific_engine_and_instance_type"]
}
