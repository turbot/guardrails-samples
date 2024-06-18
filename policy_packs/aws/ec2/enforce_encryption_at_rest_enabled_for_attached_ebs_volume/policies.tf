# AWS > EC2 > Volume > Approved
resource "turbot_policy_setting" "aws_ec2_volume_approved" {
  resource       = turbot_smart_folder.pack.id
  type           = "tmod:@turbot/aws-ec2#/policy/types/volumeApproved"
  template_input = <<-EOT
      {
        volume {
          attachments: get(path: "Attachments")
        }
      }
      EOT
  template       = <<-EOT
    {%- set attachedWithInstance = false -%}
    {%- for attachment in $.volume.attachments -%}
      {#- If AWS EBS volume is attached to an EC2 instance -#}
      {%- if attachment.InstanceId -%}
      {%- set attachedWithInstance = true -%}
        {%- if attachedWithInstance -%}
          Check: Approved
          {#- Enforce: Detach unapproved if new -#}
          {#- Enforce: Detach, snapshot and delete unapproved if new -#}
        {%- endif -%}
      {%- endif -%}
    {%- endfor -%}
    EOT
}

# AWS > EC2 > Volume > Approved > Encryption at Rest
resource "turbot_policy_setting" "aws_ec2_volume_approved_encryption_at_rest" {
  resource       = turbot_smart_folder.pack.id
  type           = "tmod:@turbot/aws-ec2#/policy/types/volumeEncryptionAtRest"
  template_input = <<-EOT
    {
      volume {
        attachments: get(path: "Attachments")
      }
    }
    EOT
  template       = <<-EOT
    {%- set attachedWithInstance = false -%}
    {%- for attachment in $.volume.attachments -%}
      {#- If AWS EBS volume is attached to an EC2 instance -#}
      {%- if attachment.InstanceId -%}
      {%- set attachedWithInstance = true -%}
        {%- if attachedWithInstance -%}
          AWS managed key or higher
          {#- Customer managed key -#}
          {#- Encryption at Rest > Customer Managed Key -#}
        {%- endif -%}
      {%- endif -%}
    {%- endfor -%}
    EOT
}

# AWS > EC2 > Volume > Approved > Encryption at Rest > Customer Managed Key
resource "turbot_policy_setting" "aws_ec2_volume_approved_encryption_at_rest_customer_managed_key" {
  resource = turbot_smart_folder.pack.id
  type     = "tmod:@turbot/aws-ec2#/policy/types/volumeEncryptionAtRestCustomerManagedKey"
  # Enter your CMK id/arn/alias below
  value    = "alias/turbot/default"
}
