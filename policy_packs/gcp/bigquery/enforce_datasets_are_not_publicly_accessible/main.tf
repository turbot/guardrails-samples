resource "turbot_policy_pack" "main" {
  title       = "Enforce GCP BigQuery Datasets Are Not Publicly Accessible"
  description = "Protect sensitive and proprietary data from unauthorized access and potential breaches."
  akas        = ["gcp_bigquery_enforce_datasets_are_not_publicly_accessible"]
}
