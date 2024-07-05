# Azure > AppService > WebApp > Approved
resource "turbot_policy_setting" "azure_appservice_webapp_approved" {
  resource = turbot_smart_folder.main.id
  type     = "tmod:@turbot/azure-appservice#/policy/types/webAppApproved"
  note     = "Azure CIS v2.0.0 - Control: 9.1, 9.6, 9.7 and 9.8"
  value    = "Check: Approved"
  # value    = "Enforce: Delete unapproved if new"
}

# Azure > AppService > WebApp > Approved > Custom
resource "turbot_policy_setting" "azure_appservice_webapp_approved_custom" {
  resource       = turbot_smart_folder.main.id
  type           = "tmod:@turbot/azure-appservice#/policy/types/webAppApprovedCustom"
  note           = "Azure CIS v2.0.0 - Control: 9.1, 9.6, 9.7 and 9.8"
  template_input = <<-EOT
    {
      outdatedJavaVersions: constant(value: "['8', '11']")
      outdatedPhpVersions: constant(value: "['5.6', '7.0', '7.1', '7.2', '7.3']")
      outdatedPythonVersions: constant(value: "['2.7', '3.4', '3.5', '3.6']")
      webApp {
        appServiceAuth: get(path:"authSettings.enabled"),
        javaVersion: get(path:"configuration.javaVersion"),
        phpVersion: get(path:"configuration.phpVersion"),
        pythonVersion: get(path:"configuration.pythonVersion")
      }
    }
  EOT
  template       = <<-EOT
    {% set results = [] -%}

    {%- if $.webApp.appServiceAuth == false -%}

      {%- set data = {
          "title": "App Service authentication",
          "result": "Not approved",
          "message": "App Service authentication is disabled"
      } -%}

    {%- else -%}

      {%- set data = {
          "title": "App Service authentication",
          "result": "Approved",
          "message": "App Service authentication is enabled"
        } -%}

    {%- endif -%}

    {% set results = results.concat(data) -%}

    {%- if $.webApp.javaVersion in $.outdatedJavaVersions -%}

      {%- set data = {
          "title": "Java Version",
          "result": "Not approved",
          "message": "Web App is running with outdated Java version"
      } -%}

    {%- elif $.webApp.javaVersion -%}

      {%- set data = {
          "title": "Java Version",
          "result": "Approved",
          "message": "Web App is running on a latest Java version"
      } -%}

    {%- else -%}

      {%- set data = {
          "title": "Java Version",
          "result": "Skip",
          "message": "No data for web app yet"
      } -%}

    {%- endif -%}

    {% set results = results.concat(data) -%}

    {%- if $.webApp.phpVersion in $.outdatedPhpVersions -%}

      {%- set data = {
          "title": "PHP Version",
          "result": "Not approved",
          "message": "Web App is running with outdated PHP version"
      } -%}

    {%- elif $.webApp.phpVersion -%}

      {%- set data = {
          "title": "PHP Version",
          "result": "Approved",
          "message": "Web App is running on a latest PHP version"
      } -%}

    {%- else -%}

      {%- set data = {
          "title": "PHP Version",
          "result": "Skip",
          "message": "No data for web app yet"
      } -%}

    {%- endif -%}

    {% set results = results.concat(data) -%}

    {%- if $.webApp.pythonVersion in $.outdatedPythonVersions -%}

      {%- set data = {
          "title": "Python Version",
          "result": "Not approved",
          "message": "Web App is running with outdated Python version"
      } -%}

    {%- elif $.webApp.pythonVersion -%}

      {%- set data = {
          "title": "Python Version",
          "result": "Approved",
          "message": "Web App is running on a latest Python version"
      } -%}

    {%- else -%}

      {%- set data = {
          "title": "Python Version",
          "result": "Skip",
          "message": "No data for web app yet"
      } -%}

    {%- endif -%}

    {% set results = results.concat(data) -%}
    {{ results | json }}
  EOT
}

# Azure > AppService > WebApp > HTTPS Only
resource "turbot_policy_setting" "azure_appservice_web_app_https_only" {
  resource = turbot_smart_folder.main.id
  type     = "tmod:@turbot/azure-appservice#/policy/types/webAppHttpsOnly"
  note     = "Azure CIS v2.0.0 - Control: 9.2"
  value    = "Check: Enabled"
  # value    = "Enforce: Enabled"
}

# Azure > AppService > WebApp > Minimum Tls Version
resource "turbot_policy_setting" "azure_appservice_web_app_minimum_tls_version" {
  resource = turbot_smart_folder.main.id
  type     = "tmod:@turbot/azure-appservice#/policy/types/webAppMinimumTlsVersion"
  note     = "Azure CIS v2.0.0 - Control: 9.3"
  value    = "Check: TLS 1.2"
  # value    = "Enforce: TLS 1.2"
}

# Azure > AppService > WebApp > HTTP 2.0 Enabled
resource "turbot_policy_setting" "azure_appservice_web_app_http20_enabled" {
  resource = turbot_smart_folder.main.id
  type     = "tmod:@turbot/azure-appservice#/policy/types/webAppHttp20Enabled"
  note     = "Azure CIS v2.0.0 - Control: 9.9"
  value    = "Check: Enabled"
  # value    = "Enforce: Enabled"
}

# Azure > AppService > WebApp > FTPS State
resource "turbot_policy_setting" "azure_appservice_web_app_ftps_state" {
  resource = turbot_smart_folder.main.id
  type     = "tmod:@turbot/azure-appservice#/policy/types/webAppFtpsState"
  note     = "Azure CIS v2.0.0 - Control: 9.10"
  value    = "Check: FTPS only"
  # value    = "Enforce: FTPS only"
}
