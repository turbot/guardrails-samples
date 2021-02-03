###  Dataflow Jobs Unencrypted 
resource "turbot_policy_setting" "gcp_dataflow_job_approved" {
  resource = turbot_smart_folder.gcp_encryption.id
  type     = "tmod:@turbot/gcp-dataflow#/policy/types/jobApproved"
  value    = "Check: Approved"
          # No Enforcement alternative available 
}

resource "turbot_policy_setting" "gcp_dataflow_job_approved_encryption_at_rest" {
  resource = turbot_smart_folder.gcp_encryption.id
  type     = "tmod:@turbot/gcp-dataflow#/policy/types/jobApprovedEncryptionAtRest"
  value    = "Google managed key"
          # "Google managed key"
          # "Google managed key or higher"
          # "Customer managed key"
          # "Customer managed key or higher"
          # "Encryption at Rest > Customer Managed Key"
}