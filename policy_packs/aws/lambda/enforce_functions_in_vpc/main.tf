resource "turbot_policy_pack" "main" {
  title       = "Enforce AWS Lambda Functions in VPC"
  description = "Ensure that the functions can securely interact with resources within the VPC while preventing unauthorized access from the internet."
  akas        = ["aws_lambda_enforce_functions_in_vpc"]
}
