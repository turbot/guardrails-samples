resource "turbot_smart_folder" "main" {
  title       = "Enforce Azure Storage Blob Containers Block Public Access"
  description = "Ensures that storage blob containers do not allow public access to prevent unauthorized access and data breaches. Therefore enhancing data security and compliance with privacy regulations."
  parent      = "tmod:@turbot/turbot#/"
}
