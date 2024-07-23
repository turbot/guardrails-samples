# Create a smart folder which contains the credential report policy

resource "turbot_smart_folder" "iam_credential_report" {
  title         = var.smart_folder_title
  description   = "Create a smart folder to apply the IAM Cross Account policy settings"
  parent        = "tmod:@turbot/turbot#/"
}

# Record and synchronize details of AWS IAM credential report into the CMDB.
# AWS > IAM > Credential Report > CMDB

resource "turbot_policy_setting" "iam_cmdb_credreport" {
    resource = turbot_smart_folder.iam_credential_report.id
    type = "tmod:@turbot/aws-iam#/policy/types/credentialReportCmdb"
    value = "Enforce: Enabled"
}