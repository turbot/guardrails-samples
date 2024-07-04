# Azure > AppService > WebApp > Approved
resource "turbot_policy_setting" "azure_appservice_webapp_approved" {
  resource = turbot_smart_folder.main.id
  type     = "tmod:@turbot/azure-appservice#/policy/types/webAppApproved"
  value    = "Check: Approved"
  # value    = "Enforce: Delete unapproved if new"
}

# Azure > AppService > WebApp > Approved > Custom
resource "turbot_policy_setting" "azure_appservice_webapp_approved_custom" {
  resource       = turbot_smart_folder.main.id
  type           = "tmod:@turbot/azure-appservice#/policy/types/webAppApprovedCustom"
  template_input = <<-EOT
    {
      webApp {
        managedServiceIdentityId: get(path:"configuration.managedServiceIdentityId")
        location: get(path:"location")
      }
    }
    EOT
  template       = <<-EOT
    {%- if $.webApp.location and $.webApp.managedServiceIdentityId != null -%}

      {%- set data = { 
          "title": "Managed Service Identity",
          "result": "Approved",
          "message": "Managed Service Identity is available"
      } -%} 

    {%- elif $.webApp.location and $.webApp.managedServiceIdentityId == null -%}

      {%- set data = { 
          "title": "Managed Service Identity",
          "result": "Not approved",
          "message": "Managed Service Identity is not available"
      } -%} 

    {%- else -%}

      {%- set data = { 
          "title": "Managed Service Identity",
          "result": "Skip",
          "message": "No data for Web App yet"
      } -%} 

    {%- endif -%}
    {{ data | json }}
    EOT
}
