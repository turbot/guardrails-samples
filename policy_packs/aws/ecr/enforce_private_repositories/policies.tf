# AWS > ECR > Public Repository > Approved
resource "turbot_policy_setting" "aws_ecr_public_repository_approved" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/aws-ecr#/policy/types/publicRepositoryApproved"
  value    = "Check: Approved"
  # value    = "Enforce: Delete unapproved if new"
}

# AWS > ECR > Public Repository > Approved > Usage
resource "turbot_policy_setting" "aws_ecr_public_repository_approved_usage" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/aws-ecr#/policy/types/publicRepositoryApprovedUsage"
  value    = "Not approved"
}
