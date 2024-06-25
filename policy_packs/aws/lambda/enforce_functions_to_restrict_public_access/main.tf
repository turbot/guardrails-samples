resource "turbot_smart_folder" "pack" {
  title       = "Enforce AWS Lambda Functions to Restrict Public Access"
  description = "Prevent unauthorized users from invoking functions, which can lead to security vulnerabilities and potential data breaches."
  parent      = "tmod:@turbot/turbot#/"
}

