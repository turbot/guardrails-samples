resource "turbot_smart_folder" "pack" {
  title       = "Deny AWS EC2 Instances with Unapproved AMIs and/or Publisher Accounts"
  description = "Prevent use of potentially vulnerable or malicious images, ensuring that only vetted and compliant resources are deployed."
  parent      = "tmod:@turbot/turbot#/"
}
