resource "turbot_policy_pack" "main" {
  title       = "Deny AWS EC2 Instances with Unapproved AMIs or Publisher Accounts"
  description = "Prevent use of potentially vulnerable or malicious images, ensuring that only vetted and compliant resources are deployed."
}
