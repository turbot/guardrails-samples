resource "turbot_policy_pack" "main" {
  title       = "Enforce AWS EC2 Snapshots Are Shared With Trusted Accounts"
  description = "Ensures that sensitive information is protected from unauthorized access, reducing the risk of data breaches and maintaining the integrity of your cloud environment."
  akas        = ["aws_ec2_enforce_snapshots_to_be_shared_with_trusted_accounts"]
}
