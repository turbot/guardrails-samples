###  Pub/Sub Topic Unencrypted 
resource "turbot_policy_setting" "gcp_pubsub_topic_approved" {
  resource = turbot_smart_folder.gcp_encryption.id
  type     = "tmod:@turbot/gcp-pubsub#/policy/types/topicApproved"
  value    = "Check: Approved"
          # "Enforce: Delete unapproved if new"
}

resource "turbot_policy_setting" "gcp_pubsub_topic_approved_encryption_at_rest" {
  resource = turbot_smart_folder.gcp_encryption.id
  type     = "tmod:@turbot/gcp-pubsub#/policy/types/topicApprovedEncryptionAtRest"
  value    = "Google managed key"
          # "Google managed key"
          # "Google managed key or higher"
          # "Customer managed key"
          # "Customer managed key or higher"
          # "Encryption at Rest > Customer Managed Key"
}