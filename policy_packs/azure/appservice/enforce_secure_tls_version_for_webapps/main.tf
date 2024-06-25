resource "turbot_smart_folder" "main" {
  title       = "Enforce Secure TLS Version for Azure App Service Web Apps"
  description = "Ensure data is protected by using strong encryption protocols, reducing the risk of vulnerabilities associated with older TLS versions"
  parent      = "tmod:@turbot/turbot#/"
}
