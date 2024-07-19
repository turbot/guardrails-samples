resource "turbot_policy_pack" "main" {
  title       = "Enforce AWS EC2 Instances to Use Approved AMIs and/or Publisher Accounts"
  description = "Ensure that only trusted, validated images are used, reducing the risk of security vulnerabilities and ensuring compliance with organizational policies and security standards."
  akas        = ["aws_ec2_enforce_approved_amis_publishers_for_instances"]
}
