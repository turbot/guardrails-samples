# AWS > DMS > Replication Instance > Approved
resource "turbot_policy_setting" "aws_dms_replication_instance_approved" {
  resource = turbot_smart_folder.main.id
  type     = "tmod:@turbot/aws-dms#/policy/types/replicationInstanceApproved"
  value    = "Check: Approved"
  # value    = "Enforce: Stop unapproved"
  # value    = "Enforce: Stop unapproved if new"
  # value    = "Enforce: Delete unapproved if new"
}

# AWS > DMS > Replication Instance > Approved > Custom
resource "turbot_policy_setting" "aws_dms_replication_instance_approved_custom" {
  resource       = turbot_smart_folder.main.id
  type           = "tmod:@turbot/aws-dms#/policy/types/replicationInstanceApprovedCustom"
  template_input = <<-EOT
    {
      replicationInstance {
        publiclyAccessible: get(path:"PubliclyAccessible")
      }
    }
    EOT
  template       = <<-EOT
    {%- if $.replicationInstance.publiclyAccessible == true -%} 

      {%- set data = { 
          "title": "Publicly Accessible",
          "result": "Not approved",
          "message": "Replication instance is publicly accessible"
      } -%} 

    {%- elif $.replicationInstance.publiclyAccessible == false -%} 

      {%- set data = { 
          "title": "Publicly Accessible",
          "result": "Approved",
          "message": "Replication instance is not publicly accessible"
      } -%} 

    {%- else -%} 

      {%- set data = { 
          "title": "Publicly Accessible",
          "result": "Skip",
          "message": "No publicly accessible data for replication instance yet"
      } -%} 

    {%- endif -%} 

    {{ data | json }}
    EOT
}
