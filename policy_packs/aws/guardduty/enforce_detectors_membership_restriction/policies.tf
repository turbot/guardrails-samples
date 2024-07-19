# AWS > GuardDuty > Detector > Approved
resource "turbot_policy_setting" "aws_guardduty_detector_approved" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/aws-guardduty#/policy/types/detectorApproved"
  value    = "Check: Approved"
  # value    = "Enforce: Delete unapproved if new"
}

# AWS > GuardDuty > Detector > Approved > Custom
resource "turbot_policy_setting" "aws_guardduty_detector_approved_custom" {
  resource       = turbot_policy_pack.main.id
  type           = "tmod:@turbot/aws-guardduty#/policy/types/detectorApprovedCustom"
  template_input = <<-EOT
    {
      item: detector {
        masterAccount: get(path: "Master.AccountId")
      }
    }
  EOT
  template       = <<-EOT
    {# Replace dummy value with your account ID #}
    {%- set masterAccount = $.item.masterAccount -%}

    {%- if masterAccount != null and masterAccount == "688720832404" or masterAccount == null -%}

      {%- set data = {
          "title": "GuardDuty Detector Master Account Usage",
          "result": "Approved",
          "message": "GuardDuty detector membership to a specific master account"
      } -%}

    {%- elif masterAccount != null and masterAccount != "688720832404" -%}

      {%- set data = {
          "title": "GuardDuty Detector Master Account Usage",
          "result": "Not approved",
          "message": "GuardDuty detector is not a membership to a specific master account"
      } -%}

    {%- else -%}

      {%- set data = {
         "title": "GuardDuty Detector Master Account Usage",
          "result": "Skip",
          "message": "No data for guardduty detector master account yet"
      } -%}

    {%- endif -%}
    {{ data | json }}
  EOT
}
