resource "turbot_policy_pack" "main" {
  title       = "Enforce AWS ECR Repositories Are Private"
  description = "Ensures that AWS ECR repositories are not publicly accessible."
  akas        = ["aws_ecr_enforce_private_repositories"]
}
