# Smart Folder Definition
resource "turbot_smart_folder" "azure_compute_disk_customer_key_encrypted_folder" {
  title       = var.smart_folder_title
  description = var.smart_folder_description
  parent      = var.smart_folder_parent_resource
}

# Azure > Compute > Disk > Approved
resource "turbot_policy_setting" "azure_compute_disk_approved_customer_key_encrypted" {
  resource = turbot_smart_folder.azure_compute_disk_customer_key_encrypted_folder.id
  type     = "tmod:@turbot/azure-compute#/policy/types/diskApproved"
  value    = "Check: Approved"
}

# Azure > Compute > Disk > Approved > Usage
resource "turbot_policy_setting" "azure_compute_disk_approved_usage_customer_key_encrypted" {
  resource       = turbot_smart_folder.azure_compute_disk_customer_key_encrypted_folder.id
  type           = "tmod:@turbot/azure-compute#/policy/types/diskApprovedUsage"
  template_input = <<EOT
  {
    resource {
      encryption: get(path: "encryption")
    }
  }
  EOT
  template = <<EOT
  {%- if $.resource.encryption and $.resource.encryption.type == "EncryptionAtRestWithCustomerKey" -%}
    Approved
  {%- else -%}
    Not approved
  {%- endif -%}
  EOT
}

# Attach Smart Folder
resource "turbot_smart_folder_attachment" "azure_compute_disk_approved_usage_customer_key_encrypted_attachment" {
  resource     = var.target_resource
  smart_folder = turbot_smart_folder.azure_compute_disk_customer_key_encrypted_folder.id
}
