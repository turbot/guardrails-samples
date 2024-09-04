resource "turbot_policy_pack" "main" {
  title       = "Enforce AWS EC2 Instances Use AMIs With Approved Tags"
  description = "Ensure that all instances are easily identifiable based on their purpose, environment, and other criteria, facilitating cost tracking, security management, and adherence to organizational policies."
  akas        = ["aws_ec2_enforce_instances_use_amis_with_approved_tags"]
}
