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
        volumeId: get(path:"VolumeId")
      }
    }
    EOT
  template       = <<-EOT
    {%- set attachments = $.item.attachments -%}

    {%- if $.item.volumeId and attachments | length == 0 -%}

      {%- set data = {
          "title": "Attachment",
          "result": "Not approved",
          "message": "Volume is not attached to an instance"
      } -%}

    {%- elif $.item.volumeId and attachments | length > 0 -%}

      {%- set data = {
          "title": "Attachment",
          "result": "Approved",
          "message": "Volume is attached to an instance"
      } -%}

    {%- else -%}

      {%- set data = {
         "title": "Attachment",
          "result": "Skip",
          "message": "No data for volume yet"
      } -%}

    {%- endif -%}
    {{ data | json }}
  EOT
}
