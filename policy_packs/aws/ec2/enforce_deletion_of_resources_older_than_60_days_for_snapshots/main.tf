resource "turbot_policy_pack" "main" {
  title       = "Enforce Deletion of Resources Older Than 60 Days for Snapshots"
  description = "Automatically delete AWS EC2 snapshots that have been running for more than 60 days to ensure resource optimization and cost management."
  akas        = ["aws_ec2_enforce_deletion_of_resources_older_than_90_days_for_snapshots"]
}
