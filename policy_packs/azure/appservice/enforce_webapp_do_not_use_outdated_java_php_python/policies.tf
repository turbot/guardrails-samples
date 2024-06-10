# Azure > AppService > WebApp > Approved
resource "turbot_policy_setting" "azure_appservice_webapp_approved" {
  resource = turbot_smart_folder.pack.id
  type     = "tmod:@turbot/azure-appservice#/policy/types/webAppApproved"
  value    = "Check: Approved"
  # value    = "Enforce: Delete unapproved if new"
}

# Azure > AppService > WebApp > custom
resource "turbot_policy_setting" "azure_appservice_webapp_approved_custom" {
  resource       = turbot_smart_folder.pack.id
  type           = "tmod:@turbot/azure-appservice#/policy/types/webAppApprovedCustom"
  template_input = <<-EOT
    {
      webApp {
        javaVersion: get(path:"configuration.javaVersion"),
        phpVersion: get(path:"configuration.phpVersion"),
        pythonVersion: get(path:"configuration.pythonVersion")
      }
    }
  EOT
  template       = <<-EOT
    {%- if $.webApp.javaVersion in ['8', '11'] -%} 

      {%- set data = { 
          "title": "Java Version",
          "result": "Not approved",
          "message": "Web App is running on outdated Java version"
      } -%} 

    {%- elif $.webApp.phpVersion in ['5.6', '7.0', '7.1', '7.2', '7.3'] -%} 

      {%- set data = { 
          "title": "PHP Version",
          "result": "Not approved",
          "message": "Web App is running on outdated PHP version"
      } -%} 

    {%- elif $.webApp.pythonVersion in ['2.7', '3.4', '3.5', '3.6'] -%} 

      {%- set data = { 
          "title": "Python Version",
          "result": "Not approved",
          "message": "Web App is running on outdated Python version"
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
            "message": "No data for Web App yet"
        } -%} 

      {%- endif -%}

    {%- endif -%} 
    {{ data | json }}
  EOT
}
