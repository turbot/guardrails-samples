resource "turbot_policy_pack" "main" {
  title       = "Enforce AWS EBS Volumes Are Not Older Than 90 Days"
  description = "Automatically delete AWS EC2 volumes that have been running for more than 90 days to ensure resource optimization and cost management."
  akas        = ["aws_ec2_enforce_volumes_are_not_older_than_90_days"]
}
