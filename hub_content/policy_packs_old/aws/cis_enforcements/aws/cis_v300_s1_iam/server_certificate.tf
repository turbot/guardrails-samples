# AWS > IAM > Server Certificate > Active
resource "turbot_policy_setting" "aws_iam_server_certificate_active" {
  resource = turbot_smart_folder.aws_cis_v300_s1_iam.id
  type     = "tmod:@turbot/aws-iam#/policy/types/serverCertificateActive"
  note     = "AWS CIS v3.0.0 - Controls: 1.19"
  value    = "Check: Active"
  # value    = "Enforce: Delete inactive with 1 day warning"
}

# AWS > IAM > Server Certificate > Active > Expired
resource "turbot_policy_setting" "aws_iam_server_certificate_active_expired" {
  resource = turbot_smart_folder.aws_cis_v300_s1_iam.id
  type     = "tmod:@turbot/aws-iam#/policy/types/serverCertificateActiveExpired"
  note     = "AWS CIS v3.0.0 - Controls: 1.19"
  value    = "Force inactive if expired"
}
