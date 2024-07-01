resource "turbot_smart_folder" "main" {
  title       = "Enforce GCP GKE Clusters are Not Exposed to the Internet"
  description = "Ensure Enforce GCP GKE clusters are not exposed to the internet for safeguarding against unauthorized access and potential security breaches."
  parent      = "tmod:@turbot/turbot#/"
}
