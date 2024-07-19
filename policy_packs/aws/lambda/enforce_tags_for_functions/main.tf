resource "turbot_policy_pack" "main" {
  title       = "Enforce Tags For AWS Lambda Functions"
  description = "Ensure that only authorized functions are executed, preventing potential vulnerabilities and misuse while optimizing resource allocation and controlling expenses."
  akas        = ["aws_lambda_enforce_tags_for_functions"]
}
