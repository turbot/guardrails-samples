resource "turbot_policy_pack" "main" {
  title       = "AWS EC2 Enforce EBS Volumes Have Recent Snapshots"
  description = "Enforce that AWS EBS volumes have recent snapshots for backup and recovery purposes."
  akas        = ["aws_ec2_enforce_ebs_volumes_have_recent_snapshots"]
}
