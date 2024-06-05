# Azure > AppService > WebApp > Approved
resource "turbot_policy_setting" "azure_appservice_webapp_approved" {
  resource = turbot_smart_folder.pack.id
  type     = "tmod:@turbot/azure-appservice#/policy/types/webAppApproved"
  value    = "Check: Approved"
  # value    = "Enforce: Stop unapproved"
  # value    = "Enforce: Stop unapproved if new"
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
    title: "Detect If Web App is running outdated Java/PHP/Python version"
    {%- if $.webApp.javaVersion in ['8', '11'] %}
    result: Not approved
    message: "Web App is running with outdated Java version"
    {%- elif $.webApp.phpVersion in ['5.6', '7.0', '7.1', '7.2', '7.3'] %}
    result: Not approved
    message: "Web App is running with outdated PHP version"
    {%- elif $.webApp.pythonVersion in ['2.7', '3.4', '3.5', '3.6'] %}
    result: Not approved
    message: "Web App is running with outdated Python version"
    {%- else -%}
    result: Approved
    message: "Web App is running with latest Java/PHP/Python version"
    {%- endif -%}
  EOT
}
