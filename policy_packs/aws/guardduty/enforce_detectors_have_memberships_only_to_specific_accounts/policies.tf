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
      approvedAccounts: constant(value: "['688720832423', '688720832465']")
    }
  EOT
  template       = <<-EOT
    {%- set masterAccount = $.item.masterAccount -%}

    {%- if masterAccount != null and masterAccount in $.approvedAccounts -%}

      {%- set data = {
          "title": "GuardDuty Detector Membership",
          "result": "Approved",
          "message": "GuardDuty detector is a member of approved account"
      } -%}

    {%- elif masterAccount != null and masterAccount not in $.approvedAccounts -%}

      {%- set data = {
          "title": "GuardDuty Detector Membership",
          "result": "Not approved",
          "message": "GuardDuty detector is not a member of approved account"
      } -%}

    {%- else -%}

      {%- set data = {
         "title": "GuardDuty Detector Membership",
          "result": "Skip",
          "message": "No data for detector yet"
      } -%}

    {%- endif -%}
    {{ data | json }}
  EOT
}
