# AWS > Redshift > Cluster > Encryption in Transit
resource "turbot_policy_setting" "aws_redshift_cluster_encryption_in_transit" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/aws-redshift#/policy/types/clusterEncryptionInTransit"
  value    = "Check: Enabled"
  # value    = "Enforce: Enabled"
}
