resource "turbot_policy_pack" "main" {
  title       = "EKS Deny Public Resources"
  description = "A policy pack that controls EKS cluster approval based on public endpoint access configuration with exception handling."
  akas        = ["eks_deny_public_resources"]
}
