resource "turbot_smart_folder" "main" {
  title       = "Check If GCP Network Load Balancers Enforce HTTPS to Manage Encrypted Web Traffic"
  description = "Ensure that the data transmitted between clients and load-balanced applications is encrypted, protecting it from interception and unauthorized access."
  parent      = "tmod:@turbot/turbot#/"
}
