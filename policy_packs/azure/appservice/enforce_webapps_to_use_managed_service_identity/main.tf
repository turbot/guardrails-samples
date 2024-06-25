resource "turbot_smart_folder" "main" {
  title       = "Enforce Azure App Service Web Apps to Use Managed Service Identity"
  description = "Ensure web apps securely access Azure resources without the need for hard-coded credentials, reducing the risk of credential exposure and ensuring compliance."
  parent      = "tmod:@turbot/turbot#/"
}
