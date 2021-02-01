resource "turbot_smart_folder" "aws_all_s3" {
  parent = "tmod:@turbot/turbot#/"
  title  = var.smart_folder_name
}
