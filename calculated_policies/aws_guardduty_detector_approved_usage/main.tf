# Smart Folder Definition
resource "turbot_smart_folder" "aws_guardduty_detector_approved_usage" {
  title       = var.smart_folder_title
  description = var.smart_folder_description
  parent      = var.smart_folder_parent_resource
}

# AWS > GuardDuty > Detector > Approved
resource "turbot_policy_setting" "aws_guardduty_detector_approved" {
  resource = turbot_smart_folder.aws_guardduty_detector_approved_usage.id
  type     = "tmod:@turbot/aws-guardduty#/policy/types/detectorApproved"
  value    = "Check: Approved"
}

# AWS > GuardDuty > Detector > Approved > Usage
resource "turbot_policy_setting" "aws_guardduty_detector_approved_usage" {
  resource = turbot_smart_folder.aws_guardduty_detector_approved_usage.id
  type     = "tmod:@turbot/aws-guardduty#/policy/types/detectorApprovedUsage"
  # GraphQL to pull detector metadata
  template_input = <<EOT
  {
    resource {
      masterAccount: get(path: "Master.AccountId")
    }
  }
  EOT
  # Nunjucks Template Nunjucks Comments are formatted: {# comment #}
  template = <<EOT
  {% if $.resource.masterAccount %}
  {%   if $.resource.masterAccount == "${var.detector_master_account}" %}
          "Approved"
  {%   else %}
          "Not approved"
  {%   endif %}
  {% else %}
    "Approved"
  {% endif %}
  EOT
}

# Attach Smart Folder
resource "turbot_smart_folder_attachment" "aws_guardduty_detector_approved_usage" {
  resource     = var.target_resource
  smart_folder = turbot_smart_folder.aws_guardduty_detector_approved_usage.id
}
