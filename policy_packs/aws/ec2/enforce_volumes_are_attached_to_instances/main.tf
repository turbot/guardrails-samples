resource "turbot_policy_pack" "main" {
  title       = "Enforce AWS EBS Volumes Are Attached to EC2 Instances"
  description = "This practice helps avoid unnecessary costs associated with unattached volumes, reduces the risk of data exposure, and ensures that all storage resources are actively managed and utilized."
  akas        = ["aws_ec2_enforce_volumes_are_attached_to_instances"]
}
