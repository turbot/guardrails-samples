resource "turbot_policy_pack" "main" {
  title       = "Enforce Encryption By Default is Enabled for AWS EC2 EBS Volumes"
  description = "Ensure that all newly created EBS volumes are automatically encrypted, reducing the risk of unauthorized data access and breaches."
  akas        = ["aws_ec2_enforce_enforce_encryption_by_default_is_enabled_for_ebs_volumes"]
}
