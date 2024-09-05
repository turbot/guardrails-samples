resource "turbot_policy_pack" "main" {
  title       = "Enforce Managed Service Identity for Azure App Service Web Apps"
  description = "Ensure web apps securely access Azure resources without the need for hard-coded credentials, reducing the risk of credential exposure and ensuring compliance."
  akas        = ["azure_appservice_enforce_managed_service_identity_for_web_apps"]
}
