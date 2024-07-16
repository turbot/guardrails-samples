resource "turbot_policy_pack" "main" {
  title       = "Enforce Deletion of Resources Older Than 90 Days for Volumes"
  description = "Automatically delete AWS EC2 volumes that have been running for more than 90 days to ensure resource optimization and cost management."
  akas        = ["aws_ec2_enforce_deletion_of_resources_older_than_90_days_for_volumes"]
}
