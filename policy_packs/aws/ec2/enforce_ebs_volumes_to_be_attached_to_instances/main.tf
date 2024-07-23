resource "turbot_policy_pack" "main" {
  title       = "Enforce AWS EC2 EBS Volumes to Be Attached to Instances"
  description = "This practice helps avoid unnecessary costs associated with unattached volumes, reduces the risk of data exposure, and ensures that all storage resources are actively managed and utilized."
  akas        = ["aws_ec2_enforce_ebs_volumes_to_be_attached_to_instances"]
}
