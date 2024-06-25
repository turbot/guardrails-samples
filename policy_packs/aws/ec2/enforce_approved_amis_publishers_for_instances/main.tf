resource "turbot_smart_folder" "pack" {
  title       = "Enforce AWS EC2 Instances to Use Approved AMIs and/or Publisher Accounts"
  description = "Ensure that only trusted, validated images are used, reducing the risk of security vulnerabilities and ensuring compliance with organizational policies and security standards."
  parent      = "tmod:@turbot/turbot#/"
}
