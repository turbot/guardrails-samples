resource "turbot_policy_pack" "main" {
  title       = "Enforce AWS EC2 Instances with Approved AMIs or Publisher Accounts"
  description = "Prevent use of potentially vulnerable or malicious images, ensuring that only vetted and compliant resources are deployed."
  akas        = ["aws_ec2_deny_unapproved_amis_publishers_for_instances"]
}
