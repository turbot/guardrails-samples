resource "turbot_policy_pack" "main" {
  title       = "Enforce Encryption at Rest Is Enabled for AWS SNS Topics"
  description = "Encryption at rest for topics helps safeguard data confidentiality by automatically encrypting all messages stored in them, thereby reducing the risk of data breaches and complying with regulatory requirements"
  akas        = ["aws_sns_enforce_encryption_at_rest_is_enabled_for_topics"]
}
