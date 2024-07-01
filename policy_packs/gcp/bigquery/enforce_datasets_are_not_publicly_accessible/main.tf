resource "turbot_smart_folder" "main" {
  title       = "Enforce GCP BigQuery Datasets Are Not Publicly Accessible"
  description = "Ensure datasets are only accessible to authorized users and services, thereby preventing potential data breaches and maintaining compliance."
  parent      = "tmod:@turbot/turbot#/"
}
