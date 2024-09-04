resource "turbot_policy_pack" "main" {
  title       = "Enforce AWS EC2 Snapshots Are Not Older Than 60 Days"
  description = "Automatically delete AWS EC2 snapshots that have been running for more than 60 days to ensure resource optimization and cost management."
  akas        = ["aws_ec2_enforce_snapshots_are_not_older_than_60_days"]
}
