resource "turbot_policy_pack" "main" {
  title       = "Enforce Azure Storage Blob Containers Block Public Access"
  description = "Ensure that only authenticated and authorized users can interact with the stored data, thus enhancing security and compliance with data protection regulations."
  parent      = "tmod:@turbot/turbot#/"
}
