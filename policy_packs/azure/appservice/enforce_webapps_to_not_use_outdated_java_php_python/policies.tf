# Azure > AppService > WebApp > Approved
resource "turbot_policy_setting" "azure_appservice_webapp_approved" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/azure-appservice#/policy/types/webAppApproved"
  value    = "Check: Approved"
  # value    = "Enforce: Delete unapproved if new"
}

# Azure > AppService > WebApp > custom
resource "turbot_policy_setting" "azure_appservice_webapp_approved_custom" {
  resource       = turbot_policy_pack.main.id
  type           = "tmod:@turbot/azure-appservice#/policy/types/webAppApprovedCustom"
  template_input = <<-EOT
    {
      outdatedJavaVersions: constant(value: "['8', '11']")
      outdatedPhpVersions: constant(value: "['5.6', '7.0', '7.1', '7.2', '7.3']")
      outdatedPythonVersions: constant(value: "['2.7', '3.4', '3.5', '3.6']")
      webApp {
        javaVersion: get(path:"configuration.javaVersion"),
        phpVersion: get(path:"configuration.phpVersion"),
        pythonVersion: get(path:"configuration.pythonVersion")
      }
    }
  EOT
  template       = <<-EOT
    {%- if $.webApp.javaVersion in $.outdatedJavaVersions -%}

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

      {%- if $.webApp.javaVersion -%}

        {%- set data = {
            "title": "Java Version",
            "result": "Approved",
            "message": "Web App is running on a valid Java version"
        } -%}

      {%- elif $.webApp.phpVersion -%}

        {%- set data = {
            "title": "PHP Version",
            "result": "Approved",
            "message": "Web App is running on a valid PHP version"
        } -%}

      {%- elif $.webApp.pythonVersion -%}

        {%- set data = {
            "title": "Python Version",
            "result": "Approved",
            "message": "Web App is running on a valid Python version"
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
