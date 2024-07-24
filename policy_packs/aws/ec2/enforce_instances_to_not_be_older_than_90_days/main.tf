resource "turbot_policy_pack" "main" {
  title       = "Enforce AWS EC2 Instances Are Not Older Than 90 Days"
  description = "Automatically delete AWS EC2 instances that have been running for more than 90 days to ensure resource optimization and cost management."
  akas        = ["aws_ec2_enforce_instances_to_not_be_older_than_90_days"]
}
