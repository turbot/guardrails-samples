resource "turbot_policy_pack" "main" {
  title       = "Enforce AWS EC2 Instances Are Launched In Approved Regions"
  description = "By restricting instances to specific regions, you can control where data is stored and processed, reducing exposure to regions with higher security risks and ensuring adherence to legal and compliance obligations."
  akas        = ["aws_ec2_enforce_instances_are_launched_in_approved_regions"]
}
