resource "turbot_policy_pack" "main" {
  title       = "Alert on Unapproved BigQuery DataSet Access"
  description = "Raises an alarm when an unapproved user/service account has access to a BigQuery Dataset"
  akas        = ["alert_dataset_unapproved_access"]
}
