# GCP > BigQuery > Dataset > Publicly Accessible
resource "turbot_policy_setting" "gcp_bigquery_dataset_publicly_accessible" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/gcp-bigquery#/policy/types/datasetPubliclyAccessible"
  value    = "Check: Dataset is not publicly accessible"
  # value    = "Enforce: Dataset is not publicly accessible"
}
