resource "turbot_policy_pack" "main" {
  title       = "Enforce AWS EC2 EBS Volumes To Use Specific Volume Types"
  description = "Ensure that only approved volume types are used, organizations can maintain consistent performance standards, manage expenses effectively, and mitigate risks associated with unauthorized or inappropriate storage configurations."
  akas        = ["aws_ec2_enforce_ebs_volumes_to_use_specific_volume_types"]
}
