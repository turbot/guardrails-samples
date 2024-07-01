resource "turbot_smart_folder" "main" {
  title       = "Enforce GCP BigQuery Datasets Are Not Publicly Accessible"
  description = "Protect sensitive and proprietary data from unauthorized access and potential breaches."
  parent      = "tmod:@turbot/turbot#/"
}
