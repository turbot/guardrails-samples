resource "turbot_smart_folder" "pack" {
  title       = "Enforce AWS DMS Replication Instances to Restrict Public Access"
  description = "Mitigate the risk of unauthorized access, potential data breaches, and ensures compliance with security best practices and regulatory requirements."
  parent      = "tmod:@turbot/turbot#/"
}
