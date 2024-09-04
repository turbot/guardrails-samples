resource "turbot_policy_pack" "main" {
  title       = "Enforce AWS Lambda Functions Are in a VPC"
  description = "Ensure that Lambda functions can interact securely with resources within the VPC, utilize VPC security groups and network ACLs, and prevent unauthorized access by restricting outbound internet access."
  akas        = ["aws_lambda_enforce_functions_are_in_vpc"]
}
