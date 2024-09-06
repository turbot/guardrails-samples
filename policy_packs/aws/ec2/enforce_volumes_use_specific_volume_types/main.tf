resource "turbot_policy_pack" "main" {
  title       = "Enforce AWS EBS Volumes Use Specific Volume Types"
  description = "By Ensuring that only approved volume types are used, organizations can maintain consistent performance standards, manage expenses effectively, and mitigate risks associated with unauthorized or inappropriate storage configurations."
  akas        = ["aws_ec2_enforce_volumes_use_specific_volume_types"]
}
