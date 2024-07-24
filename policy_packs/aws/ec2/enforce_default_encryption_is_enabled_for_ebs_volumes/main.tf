resource "turbot_policy_pack" "main" {
  title       = "Enforce Default Encryption Is Enabled for New AWS EBS Volumes"
  description = "Ensure that all newly created EBS volumes are automatically encrypted, reducing the risk of unauthorized data access and breaches."
  akas        = ["aws_ec2_enforce_default_encryption_is_enabled_for_ebs_volumes"]
}
