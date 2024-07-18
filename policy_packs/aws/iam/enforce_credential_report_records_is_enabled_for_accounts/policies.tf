# AWS > IAM > Credential Report > CMDB
resource "turbot_policy_setting" "iam_cmdb_credreport" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/aws-iam#/policy/types/credentialReportCmdb"
  value    = "Enforce: Enabled"
}