resource "turbot_smart_folder" "main" {
  title       = "Enforce GCP BigQuery Datasets To Not Be Publicly Accessible"
  description = "Protect sensitive and proprietary data from unauthorized access and potential breaches."
  parent      = "tmod:@turbot/turbot#/"
}
