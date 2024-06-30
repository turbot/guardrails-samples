# Azure > AppService > WebApp > Approved
resource "turbot_policy_setting" "azure_appservice_webapp_approved" {
  resource = turbot_smart_folder.azure_cis_v200_s9_app_service.id
  type     = "tmod:@turbot/azure-appservice#/policy/types/webAppApproved"
  note     = "Azure CIS v2.0.0 - Control: 9.1, 9.5, 9,6 and 9.7"
  value    = "Check: Approved"
  # value    = "Enforce: Delete unapproved"
}

# Azure > AppService > WebApp > custom
resource "turbot_policy_setting" "azure_appservice_webapp_approved_custom" {
  resource       = turbot_smart_folder.azure_cis_v200_s9_app_service.id
  type           = "tmod:@turbot/azure-appservice#/policy/types/webAppApprovedCustom"
  note           = "Azure CIS v2.0.0 - Control: 9.1, 9.5, 9,6 and 9.7"
  template_input = <<-EOT
    {
      outdatedJavaVersions: constant(value: "['8', '11']")
      outdatedPhpVersions: constant(value: "['5.6', '7.0', '7.1', '7.2', '7.3']")
      outdatedPythonVersions: constant(value: "['2.7', '3.4', '3.5', '3.6']")
      webApp {
        appServiceAuth: get(path:"authSettings.enabled")
        javaVersion: get(path:"configuration.javaVersion"),
        phpVersion: get(path:"configuration.phpVersion"),
        pythonVersion: get(path:"configuration.pythonVersion")
      }
    }
  EOT
  template       = <<-EOT
    {%- if $.webApp.appServiceAuth == false -%}

      {%- set data = {
          "title": "App Service authentication",
          "result": "Not approved",
          "message": "App Service authentication is disabled"
      } -%}

    {%- elif $.webApp.javaVersion in $.outdatedJavaVersions -%}

      {%- set data = {
          "title": "Java Version",
          "result": "Not approved",
          "message": "Web App is running with outdated Java version"
      } -%}

    {%- elif $.webApp.phpVersion in $.outdatedPhpVersions -%}

      {%- set data = {
          "title": "PHP Version",
          "result": "Not approved",
          "message": "Web App is running with outdated PHP version"
      } -%}

    {%- elif $.webApp.pythonVersion in $.outdatedPythonVersions -%}

      {%- set data = {
          "title": "Python Version",
          "result": "Not approved",
          "message": "Web App is running with outdated Python version"
      } -%}

    {%- else -%}

      {%- if $.webApp.appServiceAuth == true -%}

        {%- set data = {
            "title": "App Service authentication",
            "result": "Approved",
            "message": "App Service authentication is enabled"
        } -%}

      {%- elif $.webApp.javaVersion -%}

        {%- set data = {
            "title": "Java Version",
            "result": "Approved",
            "message": "Web App is running on a latest Java version"
        } -%}

      {%- elif $.webApp.phpVersion -%}

        {%- set data = {
            "title": "PHP Version",
            "result": "Approved",
            "message": "Web App is running on a latest PHP version"
        } -%}

      {%- elif $.webApp.pythonVersion -%}

        {%- set data = {
            "title": "Python Version",
            "result": "Approved",
            "message": "Web App is running on a latest Python version"
        } -%}

      {%- else -%}

        {%- set data = {
            "title": "Java/PHP/Python Version",
            "result": "Skip",
            "message": "No data for web app yet"
        } -%}

      {%- endif -%}

    {%- endif -%}
    {{ data | json }}
  EOT
}
