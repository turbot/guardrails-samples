# Note: App Service Approved > Usage is validated for httpsOnly for securing the custom domain.

# Azure > App Service > Function App > Approved > Usage
# https://turbot.com/v5/mods/turbot/azure-appservice/inspect#/policy/types/functionAppApprovedUsage
resource "turbot_policy_setting" "azure_appservice_function_app_approved_usage" {
  count          = var.appservice_function_app_approved_usage_policies ? 1 : 0
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

# Azure > App Service > Web App > Approved > Usage
# https://turbot.com/v5/mods/turbot/azure-appservice/inspect#/policy/types/webAppApprovedUsage
resource "turbot_policy_setting" "azure_appservice_web_app_approved_usage" {
  count          = var.azure_appservice_web_app_approved_usage_policies ? 1 : 0
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
