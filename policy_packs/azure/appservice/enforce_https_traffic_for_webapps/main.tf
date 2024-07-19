resource "turbot_policy_pack" "main" {
  title       = "Enforce HTTPS Traffic for Azure App Service Web Apps"
  description = "Ensure encrypted data transmitted over the network, protecting it from interception and unauthorized access."
  akas        = ["azure_appservice_enforce_https_traffic_for_webapps"]
}
