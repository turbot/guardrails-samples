# RDS Encryption at Rest

resource "turbot_smart_folder" "rds_encryption_at_rest" {
  title         = var.smart_folder_title
  description   = "Create a smart folder to set the RDS approved policy"
  parent        = "tmod:@turbot/turbot#/"
}

# AWS > RDS > DB Instance > Approved > Encryption at Rest
# Alternate values include: `None`, `None or higher`, `AWS managed key`, `Customer managed key`, and `Encryption at Rest > Customer Managed Key`

 resource "turbot_policy_setting" "rds_encryption_rest" {
  resource = turbot_smart_folder.rds_encryption_at_rest.id
  type = "tmod:@turbot/aws-rds#/policy/types/dbInstanceEncryptionAtRest"
  value = "AWS managed key or higher"
}