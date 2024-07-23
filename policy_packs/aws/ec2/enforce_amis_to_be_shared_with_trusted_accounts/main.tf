resource "turbot_policy_pack" "main" {
  title       = "Enforce AWS EC2 AMIs to Be Shared With Trusted Accounts"
  description = "Ensures that sensitive or proprietary configurations and data are only accessible to authorized users, reducing the risk of unauthorized access and potential data breaches."
  akas        = ["aws_ec2_enforce_amis_to_be_shared_with_trusted_accounts"]
}
