resource "turbot_policy_pack" "main" {
  title       = "Block Public Access for AWS EKS Clusters"
  description = "Enhance security by ensuring AWS EKS clusters do not have public endpoint access enabled, reducing the attack surface."
  akas        = ["aws_eks_block_cluster_public_access"]
}
