# AWS > EC2 > Volume > Approved
resource "turbot_policy_setting" "aws_ec2_volume_approved" {
  resource       = turbot_smart_folder.pack.id
  type           = "tmod:@turbot/aws-ec2#/policy/types/volumeApproved"
  template_input = <<-EOT
      {
        volume {
          attachments: get(path: "Attachments")
          encrypted: get(path: "Encrypted")
        }
      }
      EOT
  template       = <<-EOT
    {%- set attachedWithInstance = false -%}
    {%- for attachment in $.volume.attachments -%}
      {#- If AWS EBS volume is attached to an EC2 instance -#}
      {%- if attachment.InstanceId -%}
      {%- set attachedWithInstance = true -%}
        {%- if attachedWithInstance and $.volume.encrypted -%}
          Check: Approved
          {#- Enforce: Detach unapproved if new -#}
          {#- Enforce: Detach, snapshot and delete unapproved if new -#}
        {%- endif -%}
      {%- endif -%}
    {%- endfor -%}
    EOT
}

# AWS > EC2 > Volume > Encryption at Rest
resource "turbot_policy_setting" "aws_ec2_volume_encryption_at_rest" {
  resource       = turbot_smart_folder.pack.id
  type           = "tmod:@turbot/aws-ec2#/policy/types/volumeEncryptionAtRest"
  template_input = <<-EOT
    {
      volume {
        attachments: get(path: "Attachments")
        encrypted: get(path: "Encrypted")
      }
    }
    EOT
  template       = <<-EOT
    {%- set attachedWithInstance = false -%}
    {%- for attachment in $.volume.attachments -%}
      {#- If AWS EBS volume is attached to an EC2 instance -#}
      {%- if attachment.InstanceId -%}
      {%- set attachedWithInstance = true -%}
        {%- if attachedWithInstance and $.volume.encrypted -%}
          AWS managed key or higher
          {#- AWS managed key -#}
          {#- Customer managed key -#}
          {#- Encryption at Rest > Customer Managed Key -#}
        {%- endif -%}
      {%- endif -%}
    {%- endfor -%}
    EOT
}
