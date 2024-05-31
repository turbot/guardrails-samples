# Smart folder to hold RDS public instance policy

resource "turbot_smart_folder" "rds_public_access" {
  title         = var.smart_folder_title
  description   = "Create a smart folder to apply the RDS policy settings"
  parent        = "tmod:@turbot/turbot#/"
}

# Policy setting that tells Turbot to check a DB instance to see if it is publically accessible
# AWS > RDS > DB Instance > DB Instance Publicly Accessible

resource "turbot_policy_setting" "rds_instance_approved_publicaccess" {
    resource = turbot_smart_folder.rds_public_access.id
    type = "tmod:@turbot/aws-rds#/policy/types/dbInstancePubliclyAccessible"
    value = "Check: DB Instance is not publicly accessible"
}