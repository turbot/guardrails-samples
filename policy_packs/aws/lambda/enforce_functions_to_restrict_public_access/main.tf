resource "turbot_policy_pack" "main" {
  title       = "Enforce AWS Lambda Functions to Restrict Public Access"
  description = "Prevent unauthorized users from invoking functions, which can lead to security vulnerabilities and potential data breaches."
  parent      = "tmod:@turbot/turbot#/"
}

