resource "turbot_policy_pack" "main" {
  title       = "Enforce Secure TLS Version for Azure App Service Web Apps"
  description = "Ensure data is protected by using strong encryption protocols, reducing the risk of vulnerabilities associated with older TLS versions"
  akas        = ["azure_appservice_enforce_secure_tls_version_for_webapps"]
}
