# AWS > EC2 > Volume > Approved
resource "turbot_policy_setting" "aws_ec2_volume_approved" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/aws-ec2#/policy/types/volumeApproved"
  value    = "Check: Approved"
  # value    =  "Enforce: Detach unapproved if new"
  # value    =  "Enforce: Detach, snapshot and delete unapproved if new"
}

# AWS > EC2 > Volume > Approved > Custom
resource "turbot_policy_setting" "aws_ec2_volume_approved_custom" {
  resource       = turbot_policy_pack.main.id
  type           = "tmod:@turbot/aws-ec2#/policy/types/volumeApprovedCustom"
  template_input = <<-EOT
    {
      item: volume {
        attachments: get(path:"Attachments")
      }
    }
    EOT
  template       = <<-EOT
    {%- set attachments = $.item.attachments -%}

    {%- if attachments | length == 0 -%}

      {%- set data = {
          "title": "EC2 Volumes Attachment",
          "result": "Not approved",
          "message": "Volume is not attached with an EC2 instance"
      } -%}

    {%- elif attachments | length > 0 -%}

      {%- set data = {
          "title": "EC2 Volumes Attachment",
          "result": "Approved",
          "message": "Volume is attached with an EC2 instance"
      } -%}

    {%- else -%}

      {%- set data = {
         "title": "EC2 Volumes Attachment",
          "result": "Skip",
          "message": "No data for volume attachments yet"
      } -%}

    {%- endif -%}
    {{ data | json }}
  EOT
}
