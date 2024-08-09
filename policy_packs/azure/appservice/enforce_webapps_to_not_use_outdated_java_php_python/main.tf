resource "turbot_policy_pack" "main" {
  title       = "Enforce Azure App Service Web Apps to Use Supported Java, PHP, and Python Versions"
  description = "Ensure that applications run on supported, secure versions of these languages, reducing the risk of vulnerabilities, enhancing stability, and ensuring compliance."
  akas        = ["azure_appservice_enforce_webapps_to_not_use_outdated_java_php_python"]
}
