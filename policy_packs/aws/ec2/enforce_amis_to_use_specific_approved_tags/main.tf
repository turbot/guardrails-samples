resource "turbot_policy_pack" "main" {
  title       = "Enforce AWS EC2 AMIs To Use Specific Approved Tags"
  description = "Ensure AMIs to have proper tags for better tracking, auditing, and automation of resource usage, thereby enhancing overall operational efficiency and governance."
  akas        = ["aws_ec2_enforce_amis_to_use_specific_approved_tags"]
}
