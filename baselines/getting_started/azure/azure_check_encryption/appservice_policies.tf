## App Services Function App
resource "turbot_policy_setting" "azure_appservice_function_app_approved_usage" {
  resource       = turbot_smart_folder.azure_encryption.id
  type           = "tmod:@turbot/azure-appservice#/policy/types/functionAppApprovedUsage"
  template_input = <<EOT
{
  functionApp{
    httpsOnly
  }
}
EOT
  template       = <<EOT
{%- if $.functionApp.httpsOnly == false -%}
Not approved
{%- else -%}
Approved
{%- endif -%}
EOT
}

## App Services Web App
resource "turbot_policy_setting" "azure_appservice_web_app_approved_usage" {
  resource       = turbot_smart_folder.azure_encryption.id
  type           = "tmod:@turbot/azure-appservice#/policy/types/webAppApprovedUsage"
  template_input = <<EOT
{
  webApp{
    httpsOnly
  }
}
EOT
  template       = <<EOT
{%- if $.webApp.httpsOnly == false -%}
Not approved
{%- else -%}
Approved
{%- endif -%}
EOT
}