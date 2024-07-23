# First part is to create the Turbot File, for this example the File will be created on the Turbot Level
# Application metadata for Acme in a Turbot File
resource "turbot_file" "acme_applications" {
  parent  = "tmod:@turbot/turbot#/"
  title   = "Acme Applications"
  akas = ["acmeapps"]
  content = <<EOT
    {
    "applications": {
        "0000000001": {
        "owner": "bob@acme.com",
        "appName": "POS System App",
        "costCenter": "123456"
        },
        "0000000002": {
        "owner": "kevin@acme.com",
        "appName": "Supply Chain App",
        "costCenter": "123456"
        },
        "0000000003": {
        "owner": "mike@acme.com",
        "appName": "Security System App",
        "costCenter": "345678"
        }
      }
    }
    EOT
}

# Next we will create a Smart Folder and policy to relate the Turbot File data into the policy

# Smart Folder Definition
resource "turbot_smart_folder" "s3_bucket_tagging_with_files" {
  title       = var.smart_folder_title
  description = var.smart_folder_description
  parent      = var.smart_folder_parent_resource
}

# The baseline assumes a Check: mode to start
# Edit the template below to meet your requirements.

# AWS > S3 > Bucket > Tags
resource "turbot_policy_setting" "aws_s3_bucket_tags" {
  resource = turbot_smart_folder.s3_bucket_tagging_with_files.id
  type     = "tmod:@turbot/aws-s3#/policy/types/bucketTags"
  value    = "Check: Tags are correct"
          # "Skip"
          # "Check: Tags are correct"
          # "Enforce: Set tags"
}

# AWS > S3 > Bucket > Tags > Template
resource "turbot_policy_setting" "aws_s3_bucket_tags_template" {
  resource       = turbot_smart_folder.s3_bucket_tagging_with_files.id
  type           = "tmod:@turbot/aws-s3#/policy/types/bucketTagsTemplate"
  template_input = <<EOT
    {
    folder {
        turbot {
        tags
        }
    }
    apps: resource(id:"acmeapps"){
        data
     }
    }
  EOT
  template       = <<EOT
    "AppId": "{{ $.folder.turbot.tags.AppId }}"
    "Owner": "{{ $.apps.data.applications[$.folder.turbot.tags.AppId].owner }}"
    "Cost Center": "{{ $.apps.data.applications[$.folder.turbot.tags.AppId].costCenter }}"
    EOT
}