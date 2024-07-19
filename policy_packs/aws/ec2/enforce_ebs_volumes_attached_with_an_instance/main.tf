resource "turbot_policy_pack" "main" {
  title       = "Enforce AWS EC2 EBS Volumes Attached With An EC2 Instance"
  description = "Ensure EBS volumes are attached to an EC2 instance as detached volumes can lead to data loss, security vulnerabilities, and potential service disruptions, affecting the overall reliability and performance of the system."
  akas        = ["aws_ec2_enforce_ebs_volumes_attached_with_an_instance"]
}
