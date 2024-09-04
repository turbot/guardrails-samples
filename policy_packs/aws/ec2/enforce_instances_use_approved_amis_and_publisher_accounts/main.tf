resource "turbot_policy_pack" "main" {
  title       = "Enforce AWS EC2 Instances Use Approved AMIs and Publisher Accounts"
  description = "Ensure that only trusted, validated images are used, reducing the risk of security vulnerabilities and ensuring compliance with organizational policies and security standards."
  akas        = ["aws_ec2_enforce_instances_use_approved_amis_and_publisher_accounts"]
}
