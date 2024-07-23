# Encryption at Rest Guardrails - https://turbot.com/v5/docs/concepts/guardrails/encryption-at-rest

# AWS > Redshift > Cluster > Encryption at Rest
# https://turbot.com/v5/mods/turbot/aws-redshift/inspect#/policy/types/clusterEncryptionAtRest
resource "turbot_policy_setting" "redshift_cluster_encryption_at_rest" {
  count    = var.enable_redshift_cluster_encryption_policies ? 1 : 0  
  resource = turbot_smart_folder.aws_encryption.id
  type     = "tmod:@turbot/aws-redshift#/policy/types/clusterEncryptionAtRest"
  value    = "Check: AWS managed key or higher"
}
