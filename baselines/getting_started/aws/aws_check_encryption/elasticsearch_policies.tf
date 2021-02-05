# Encryption at Rest Guardrails - https://turbot.com/v5/docs/concepts/guardrails/encryption-at-rest

# AWS > Elasticsearch > Domain > Approved
# https://turbot.com/v5/mods/turbot/aws-elasticsearch/inspect#/policy/types/domainApproved
resource "turbot_policy_setting" "aws_elasticsearch_approved" {
  count    = enable_elasticsearch_domain_approved_policies ? 1 : 0
  resource = turbot_smart_folder.aws_encryption.id
  type     = "tmod:@turbot/aws-elasticsearch#/policy/types/domainApproved"
  value    = "Check: Approved"
}

# AWS > Elasticsearch > Domain > Approved > Encryption at Rest
# https://turbot.com/v5/mods/turbot/aws-elasticsearch/inspect#/policy/types/domainEncryptionAtRest
resource "turbot_policy_setting" "aws_elasticsearch_encryption_at_rest" {
  count    = enable_elasticsearch_domain_encryption_policies ? 1 : 0
  resource = turbot_smart_folder.aws_encryption.id
  type     = "tmod:@turbot/aws-elasticsearch#/policy/types/domainEncryptionAtRest"
  value    = "AWS managed key or higher"
}
