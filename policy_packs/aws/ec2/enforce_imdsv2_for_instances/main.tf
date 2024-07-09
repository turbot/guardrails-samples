resource "turbot_smart_folder" "main" {
  title       = "Enforce IMDSv2 for AWS EC2 Instances"
  description = "Mitigate the risk of unauthorized metadata exposure through vulnerabilities like Server-Side Request Forgery (SSRF)."
  parent      = "tmod:@turbot/turbot#/"
}
