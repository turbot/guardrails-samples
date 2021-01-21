# List of common S3 controls enabled for versioning, public access, encryption, audit logging.


# Encryption at Rest and In Transit.  Also in the Encryption Baseline
resource "turbot_policy_setting" "aws_s3_encryption_in_transit" {
  resource = turbot_smart_folder.aws_all_s3.id
  type     = "tmod:@turbot/aws-s3#/policy/types/encryptionInTransit"
  value    = "Check: Enabled"
}

resource "turbot_policy_setting" "aws_s3_bucket_encryption_at_rest" {
  resource = turbot_smart_folder.aws_all_s3.id
  type     = "tmod:@turbot/aws-s3#/policy/types/bucketEncryptionAtRest"
  value    = "Check: AWS SSE or higher"
            # "Skip" 
            # "Check: None"
            # "Check: None or higher"
            # "Check: AWS SSE"
            # "Check: AWS SSE or higher"
            # "Check: AWS managed key"
            # "Check: AWS managed key or higher"
            # "Check: Customer managed key"
            # "Check: Encryption at Rest > Customer Managed Key"
            # "Enforce: None"
            # "Enforce: None or higher"
            # "Enforce: AWS SSE"
            # "Enforce: AWS SSE or higher"
            # "Enforce: AWS managed key"
            # "Enforce: AWS managed key or higher"
            # "Enforce: Customer managed key"
            # "Enforce: Encryption at Rest > Customer Managed Key"
}


# Simple policy to check if S3 is Approved for Usage -- can adjust for testing per bucket
# Will inherit the Approved Regions list if using the Approved Regions baseline or can keep the Regions setting below.
resource "turbot_policy_setting" "aws_s3_bucket_approved" {
  resource = turbot_smart_folder.aws_all_s3.id
  type     = "tmod:@turbot/aws-s3#/policy/types/bucketApproved"
  value    = "Check: Approved"
}

resource "turbot_policy_setting" "aws_s3_bucket_approved_usage" {
  resource = turbot_smart_folder.aws_all_s3.id
  type     = "tmod:@turbot/aws-s3#/policy/types/bucketApprovedUsage"
  value    = "Approved"
}

resource "turbot_policy_setting" "aws_s3_bucket_approved_regions" {
  resource = turbot_smart_folder.aws_all_s3.id
  type     = "tmod:@turbot/aws-s3#/policy/types/bucketApprovedRegions"
  value    = <<EOT
- us*
EOT
}


# Simple policy to check the age of the bucket. Similiar to Cost Control baseline
resource "turbot_policy_setting" "aws_s3_bucket_active" {
  resource = turbot_smart_folder.aws_all_s3.id
  type     = "tmod:@turbot/aws-s3#/policy/types/bucketActive"
  value    = "Check: Active"
}

resource "turbot_policy_setting" "aws_s3_bucket_active_age" {
  resource = turbot_smart_folder.aws_all_s3.id
  type     = "tmod:@turbot/aws-s3#/policy/types/bucketActiveAge"
  value    = "Force inactive if age > 60 days"
}


# Trusted Accounts Access controls
# Will inherit the trusted accounts from Public Access baseline or from what is set in this baseline
resource "turbot_policy_setting" "aws_s3_bucket_policy_trusted_access" {
  resource = turbot_smart_folder.aws_all_s3.id
  type     = "tmod:@turbot/aws-s3#/policy/types/bucketPolicyTrustedAccess"
  value    = "Check: Trusted Access"
            # "Enforce: Revoke untrusted access"
}

# S3 Account Level Public Access Block
resource "turbot_policy_setting" "aws_s3_s3_account_public_access_block" {
  resource = turbot_smart_folder.aws_all_s3.id
  type     = "tmod:@turbot/aws-s3#/policy/types/s3AccountPublicAccessBlock"
  value    = "Check: Per `Public Access Block  > Settings`"
}

resource "turbot_policy_setting" "aws_s3_s3_account_public_access_block_settings" {
  resource = turbot_smart_folder.aws_all_s3.id
  type     = "tmod:@turbot/aws-s3#/policy/types/s3AccountPublicAccessBlockSettings"
  value    = <<EOT
- Block Public ACLs
- Block Public Bucket Policies
- Ignore Public ACLs
- Restrict Public Bucket Policies
EOT
}


# S3 Bucket Level Public Access Block
resource "turbot_policy_setting" "aws_s3_s3_bucket_public_access_block" {
  resource = turbot_smart_folder.aws_all_s3.id
  type     = "tmod:@turbot/aws-s3#/policy/types/s3BucketPublicAccessBlock"
  value    = "Check: Per `Public Access Block  > Settings`"
}

resource "turbot_policy_setting" "aws_s3_s3_bucket_public_access_block_settings" {
  resource = turbot_smart_folder.aws_all_s3.id
  type     = "tmod:@turbot/aws-s3#/policy/types/s3BucketPublicAccessBlockSettings"
  value    = <<EOT
- Block Public ACLs
- Block Public Bucket Policies
- Ignore Public ACLs
- Restrict Public Bucket Policies
EOT
}


# Access Logging Check
resource "turbot_policy_setting" "aws_s3_bucket_access_logging" {
  resource = turbot_smart_folder.aws_all_s3.id
  type     = "tmod:@turbot/aws-s3#/policy/types/bucketAccessLogging"
  value    = "Check: Enabled"
}

# Checking for Tags per Tagging Template, will inherit from Tag Baseline unless set here:
resource "turbot_policy_setting" "aws_s3_bucket_tags" {
  resource = turbot_smart_folder.aws_all_s3.id
  type     = "tmod:@turbot/aws-s3#/policy/types/bucketTags"
  value    = "Check: Tags are correct"
}

# Commenting out if you are already using the Tag Baseline
# resource "turbot_policy_setting" "aws_s3_bucket_tags_template2" {
#   resource = turbot_smart_folder.aws_all_s3.id
#   type     = "tmod:@turbot/aws-s3#/policy/types/bucketTagsTemplate"
#   template_input = <<-QUERY
#   {
#     resource {
#       turbot {
#         title
#         tags
#       }
#       creator: notifications(filter: "sort:version_id limit:1") {
#         items {
#           actor {
#             alternatePersona
#             identity {
#               turbot {
#                 title
#               }
#             }
#           }
#           turbot {
#             createTimestamp
#           }
#         }
#       }
#     }
#   }
#     QUERY
#   # Nunjucks template to set tags and check for tag validity.
#   template = <<-TEMPLATE
#   # Bring in environment metadata / attributes
#   Name: "{{ $.resource.turbot.title }}"
#   # Enforce selection of values, set to "Non-Compliant" if out of bounds
#   Environment: "{% if $.resource.turbot.tags['Environment'] in ['Dev', 'QA', 'Prod', 'Temp'] %}{{ $.resource.turbot.tags['Environment'] }}{% else %}Non-Compliant Tag{% endif %}"
#   # Actor who created the resource
#   CreatedByActor: "{% if $.resource.creator.items[0].actor.identity.turbot.title == 'Unidentified Identity' %}{{ $.resource.creator.items[0].actor.alternatePersona }}{% else %}{{ $.resource.creator.items[0].actor.identity.turbot.title }}{% endif %}"
#   # Creation Timestamp
#   CreatedByTime: "{{ $.resource.creator.items[0].turbot.createTimestamp }}"
#     TEMPLATE
# }


# Using a calculated policy here as an example for getting started with calculated policies
# Shows an example of setting different Checks based on naming syntax and tag key:value pair
resource "turbot_policy_setting" "aws_s3_bucket_versioning" {
  resource = turbot_smart_folder.aws_all_s3.id
  type     = "tmod:@turbot/aws-s3#/policy/types/bucketVersioning"
  template_input  = <<-QUERY
     {
      bucket {
        Name
        turbot {
          tags
          }
        }
      }
    QUERY
    
  # Nunjucks template evaluate metadata.
  template        = <<-TEMPLATE
    {% set regExp = r/turbot-demo.*/g %}
    {%- if regExp.test($.bucket.Name)
    or $.bucket.turbot.tags.Test == "Temp"-%}
    "Check: Disabled"
    {%- else -%}
    "Check: Enabled"
    {%- endif -%}
        TEMPLATE
}

# Simple Policy setting for Bucket Versioning, using the Calculated Policy below as an example for a calc policy
# resource "turbot_policy_setting" "aws_s3_bucket_versioning_simple" {
#   resource = turbot_smart_folder.aws_all_s3.id
#   type     = "tmod:@turbot/aws-s3#/policy/types/bucketVersioning"
#   value    = "Check: Enabled"
#         # "Skip"
#         # "Check: Disabled"
#         # "Check: Enabled"
#         # "Enforce: Disabled"
#         # "Enforce: Enabled"
# }