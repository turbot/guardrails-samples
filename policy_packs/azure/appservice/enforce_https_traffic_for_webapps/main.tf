resource "turbot_smart_folder" "pack" {
  title       = "Enforce HTTPS Traffic for Azure App Service Web Apps"
  description = "Ensure encrypted data transmitted over the network, protecting it from interception and unauthorized access."
  parent      = "tmod:@turbot/turbot#/"
}
