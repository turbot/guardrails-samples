resource "turbot_policy_pack" "main" {
  title       = "Enforce Azure App Service Web Apps to Not Use Outdated Java/PHP/Python Versions"
  description = "Ensure that applications run on supported, secure versions of these languages, reducing the risk of vulnerabilities, enhancing stability, and ensuring compliance."
  parent      = "tmod:@turbot/turbot#/"
}
