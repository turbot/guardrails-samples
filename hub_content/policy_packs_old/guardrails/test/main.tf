## Create Smart Folder
provider "turbot" {
  profile = "demo"
}

resource "turbot_smart_folder" "folder_test" {
  parent      = "tmod:@turbot/turbot#/"
  title       = "AAA SF test"
  description = "Test"
}

# Smart Folder Attachments
resource "turbot_smart_folder_attachment" "attachment_test" {
  # PUNISHER
  # resource     = "188739281797066" # Actual resource
  # resource     = "188716601440372" # punisher-aaa
  # resource     = "187486019045335" # folder expediators 
  # DEMO
  # resource     = "185847359853835" # dboeke key pair
  # resource     = "165045201235611" # AWS for Dave
  resource     = "165043304546839" # Folder Dave
  smart_folder = turbot_smart_folder.folder_test.id
}

# Check only guardrail
# AWS > ec2 > AMI > Approved
resource "turbot_policy_setting" "policy_test_1" {
  resource = turbot_smart_folder.folder_test.id
  type     = "tmod:@turbot/aws-ec2#/policy/types/keyPairActive"
  value    = "Check: Active"
}

# resource "turbot_policy_setting" "policy_test_2" {
#   resource = turbot_smart_folder.folder_test.id
#   type     = "tmod:@turbot/aws-ec2#/policy/types/keyPairActiveLastModified"
#   value    = "Force active if last modified <= 365 days"
# }

