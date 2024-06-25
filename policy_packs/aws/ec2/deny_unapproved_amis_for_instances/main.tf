resource "turbot_smart_folder" "main" {
  title       = "Deny Unapproved AMIs for AWS EC2 Instances"
  description = "Prevent use of potentially vulnerable or malicious images, ensuring that only vetted and compliant resources are deployed."
  parent      = "tmod:@turbot/turbot#/"
}
