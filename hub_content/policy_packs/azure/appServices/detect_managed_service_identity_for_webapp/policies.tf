# Azure > AppService > WebApp > Approved
resource "turbot_policy_setting" "azure_appservice_webapp_approved" {
  resource = turbot_smart_folder.pack.id
  type     = "tmod:@turbot/azure-appservice#/policy/types/webAppApproved"
  value    = "Check: Approved"
  # value    = "Enforce: Stop unapproved"
  # value    = "Enforce: Stop unapproved if new"
  # value    = "Enforce: Delete unapproved if new"
}

# Azure > AppService > WebApp > Approved > Custom
resource "turbot_policy_setting" "azure_appservice_webapp_approved_custom" {
  resource       = turbot_smart_folder.pack.id
  type           = "tmod:@turbot/azure-appservice#/policy/types/webAppApprovedCustom"
  template_input = <<-EOT
    {
      webApp {
        managedServiceIdentityId: get(path:"configuration.managedServiceIdentityId")
      }
    }
    EOT
  template       = <<-EOT
    title: "Detect If Managed Service identities disabled"
    {%- if $.webApp.managedServiceIdentityId == null %}
    result: Not approved
    message: "Managed Service identities disabled"
    {%- else -%}
    result: Approved
    message: "Managed Service identities enabled"
    {%- endif -%}
    EOT
}
