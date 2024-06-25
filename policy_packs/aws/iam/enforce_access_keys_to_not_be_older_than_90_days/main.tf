resource "turbot_smart_folder" "main" {
  title       = "Enforce AWS IAM Access Keys to Not Be Older Than 90 Days"
  description = "Reduce the risk of compromised credentials by ensuring keys are regularly rotated."
  parent      = "tmod:@turbot/turbot#/"
}
