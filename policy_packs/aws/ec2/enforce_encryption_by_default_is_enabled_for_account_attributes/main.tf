resource "turbot_policy_pack" "main" {
  title       = "Enforce Encryption By Default is Enabled for AWS EC2 Account Attributes"
  description = "Ensure that all data stored on EC2 instances account attributes are automatically encrypted, reducing the risk of unauthorized access and enhancing compliance with security standards and regulations."
  akas        = ["aws_ec2_enforce_encryption_by_default_is_enabled_for_account_attributes"]
}
