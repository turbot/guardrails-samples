# AWS > DMS > Replication Instance > Approved
resource "turbot_policy_setting" "aws_dms_replication_instance_approved" {
  resource = turbot_smart_folder.pack.id
  type     = "tmod:@turbot/aws-dms#/policy/types/replicationInstanceApproved"
  value    = "Check: Approved"
  # value    = "Enforce: Stop unapproved"
  # value    = "Enforce: Stop unapproved if new"
  # value    = "Enforce: Delete unapproved if new"
}

# AWS > DMS > Replication Instance > Approved > Publicly Accessible
resource "turbot_policy_setting" "aws_dms_replication_instance_approved_custom" {
  resource       = turbot_smart_folder.pack.id
  type           = "tmod:@turbot/aws-dms#/policy/types/replicationInstanceApprovedCustom"
  template_input = <<-EOT
    {
      replicationInstance {
        parent {
          publiclyAccessible: get(path:"PubliclyAccessible")
        }
      }
    }
    EOT
  template       = <<-EOT
    title: "Detect If Replication Instance Publicly Accessible"
    {%- if $.replicationInstance.parent.publiclyAccessible %}
    result: Not approved
    message: "Replication instance is publicly accessible"
    {%- else -%}
    result: Approved
    message: "Replication instance is not publicly accessible"
    {%- endif -%}
    EOT
}
