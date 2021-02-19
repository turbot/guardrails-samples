###  Pub/Sub Topic Unencrypted
# GCP > Pub/Sub > Topic > Approved
# https://turbot.com/v5/mods/turbot/gcp-pubsub/inspect#/policy/types/topicApproved
resource "turbot_policy_setting" "gcp_pubsub_topic_approved" {
  count    = var.enable_pubsub_topic_approved_policies ? 1 : 0
  resource = turbot_smart_folder.gcp_encryption.id
  type     = "tmod:@turbot/gcp-pubsub#/policy/types/topicApproved"
  value    = "Check: Approved"
          # "Enforce: Delete unapproved if new"
}

# GCP > Pub/Sub > Topic > Approved > Encryption at Rest
# https://turbot.com/v5/mods/turbot/gcp-pubsub/inspect#/policy/types/topicApprovedEncryptionAtRest
resource "turbot_policy_setting" "gcp_pubsub_topic_approved_encryption_at_rest" {
  count    = var.enable_pubsub_topic_approved_encryption_at_rest_policies ? 1 : 0
  resource = turbot_smart_folder.gcp_encryption.id
  type     = "tmod:@turbot/gcp-pubsub#/policy/types/topicApprovedEncryptionAtRest"
  value    = "Google managed key"
          # "Google managed key"
          # "Google managed key or higher"
          # "Customer managed key"
          # "Customer managed key or higher"
          # "Encryption at Rest > Customer Managed Key"
}
