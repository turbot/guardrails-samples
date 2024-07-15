
# Azure > Active Directory > User > Approved
resource "turbot_policy_setting" "azure_activedirectory_user_approved" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/azure-activedirectory#/policy/types/userApproved"
  note     = "Azure CIS v2.0.0 - Control: 1.5"
  value    = "Check: Approved"
  # value    = "Enforce: Delete unapproved"
}

# Azure > Active Directory > User > Approved > Custom
resource "turbot_policy_setting" "azure_activedirectory_user_approved_custom" {
  resource       = turbot_policy_pack.main.id
  type           = "tmod:@turbot/azure-activedirectory#/policy/types/userApprovedCustom"
  note           = "Azure CIS v2.0.0 - Control: 1.5"
  template_input = <<-EOT
    {
      user {
        userType: get(path: "userType")
        accountEnabled: get(path: "accountEnabled")
      }
    }
  EOT
  template       = <<-EOT
    {%- if $.user.userType == "Guest" and $.user.accountEnabled -%}

      {%- set data = {
          "title": "Guest User",
          "result": "Approved",
          "message": "Guest user is reviewed on a regular basis"
      } -%}

    {%- elif $.user.userType == "Guest" and not $.user.accountEnabled -%}

      {%- set data = {
          "title": "Guest User",
          "result": "Not approved",
          "message": "Guest user is not reviewed on a regular basis"
      } -%}

    {%- else -%}

      {%- set data = {
          "title": "Guest User",
          "result": "Skip",
          "message": "No data for guest user yet"
      } -%}

    {%- endif -%}
    {{ data | json }}
  EOT
}
