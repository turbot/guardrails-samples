resource "turbot_policy_pack" "main" {
  title       = "Enforce AWS EC2 AMIs Used By Instances To Use Specific Approved Tags"
  description = "Ensure that all instances are easily identifiable based on their purpose, environment, and other criteria, facilitating cost tracking, security management, and adherence to organizational policies."
  akas        = ["aws_ec2_enforce_amis_used_by_instances_to_use_specific_approved_tags"]
}
