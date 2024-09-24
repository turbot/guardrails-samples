# AWS > Redshift > Cluster > Publicly Accessible
resource "turbot_policy_setting" "aws_redshift_cluster_publicly_accessible" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/aws-redshift#/policy/types/clusterPubliclyAccessible"
  value    = "Check: Cluster is not publicly accessible"
  # value    = "Enforce: Cluster is not publicly accessible"
}
