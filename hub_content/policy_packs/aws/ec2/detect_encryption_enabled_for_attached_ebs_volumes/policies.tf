# AWS > EC2 > Volume > Approved
resource "turbot_policy_setting" "aws_ec2_volume_approved" {
  resource       = turbot_smart_folder.pack.id
  type           = "tmod:@turbot/aws-ec2#/policy/types/volumeApproved"
  template_input = <<-EOT
      {
        volume {
          Attachments: get(path: "Attachments")
          Encrypted: get(path: "Encrypted")
        }
      }
      EOT
  template       = <<-EOT
      {%- set attachedWithInstance = false -%}
      {%- for attachment in $.volume.Attachments -%}
      {%- if attachment.InstanceId -%}
      {%- set attachedWithInstance = true -%}
      {%- endif -%}
      {%- endfor -%}

      {#- If AWS EBS volume is attached with EC2 instance -#}
      {%- if attachedWithInstance and $.volume.Encrypted -%}
      Check: Approved
      {#- Enforce: Detach unapproved if new -#}
      {#- Enforce: Detach, snapshot and delete unapproved if new -#}
      {%- else -%}
      Skip
      {%- endif -%}
      EOT
}

# AWS > EC2 > Volume > Encryption at Rest
resource "turbot_policy_setting" "aws_ec2_volume_encryption_at_rest" {
  resource       = turbot_smart_folder.pack.id
  type           = "tmod:@turbot/aws-ec2#/policy/types/volumeEncryptionAtRest"
  note           = "Detecting whether encryption is enabled for AWS EBS volumes Attached to AWS EC2 instances"
  template_input = <<-EOT
    {
      volume {
        Attachments: get(path: "Attachments")
        Encrypted: get(path: "Encrypted")
      }
    }
    EOT
  template       = <<-EOT
    {%- set attachedWithInstance = false -%}
    {%- for attachment in $.volume.Attachments -%}
    {%- if attachment.InstanceId -%}
    {%- set attachedWithInstance = true -%}
    {%- endif -%}
    {%- endfor -%}

    {%- if attachedWithInstance and $.volume.Encrypted -%}
    {#- AWS EBS volume is attached with EC2 instance -#}
    AWS managed key or higher
    {#- AWS managed key -#}
    {#- Customer managed key -#}
    {#- Encryption at Rest > Customer Managed Key -#}
    {%- else -%}
    {#- AWS EBS volume is NOT attached with EC2 instance -#}
    None or higher
    {%- endif -%}
    EOT
}
