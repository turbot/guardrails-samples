#  Dataflow Jobs Unencrypted

# GCP > Dataflow > Job > Approved
# https://turbot.com/v5/mods/turbot/gcp-dataflow/inspect#/policy/types/jobApproved
resource "turbot_policy_setting" "gcp_dataflow_job_approved" {
  count    = var.enable_dataflow_job_approved_policies ? 1 : 0
  resource = turbot_smart_folder.gcp_encryption.id
  type     = "tmod:@turbot/gcp-dataflow#/policy/types/jobApproved"
  value    = "Check: Approved"
          # No Enforcement alternative available 
}

# GCP > Dataflow > Job > Approved > Encryption at Rest
# https://turbot.com/v5/mods/turbot/gcp-dataflow/inspect#/policy/types/jobApprovedEncryptionAtRest
resource "turbot_policy_setting" "gcp_dataflow_job_approved_encryption_at_rest" {
  count    = var.enable_dataflow_job_approved_encryption_at_rest_policies ? 1 : 0
    resource = turbot_smart_folder.gcp_encryption.id
  type     = "tmod:@turbot/gcp-dataflow#/policy/types/jobApprovedEncryptionAtRest"
  value    = "Google managed key"
          # "Google managed key"
          # "Google managed key or higher"
          # "Customer managed key"
          # "Customer managed key or higher"
          # "Encryption at Rest > Customer Managed Key"
}
