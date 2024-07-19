resource "turbot_policy_pack" "main" {
  title       = "Enforce Encryption at Rest is Enabled for AWS EBS Volumes"
  description = "Enforcing encryption at rest for AWS EBS volumes is critical to protect sensitive data from unauthorized access and potential breaches."
  akas        = ["aws_ec2_enforce_encryption_at_rest_is_enabled_for_ebs_volumes"]
}
