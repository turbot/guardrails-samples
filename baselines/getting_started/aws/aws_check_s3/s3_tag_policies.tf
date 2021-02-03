# Tags in Turbot
#   https://turbot.com/v5/docs/concepts/guardrails/tagging

# Comment out if you are already using the Tag Baseline
# Checking for Tags per Tagging Template, will inherit from Tag Baseline unless set here:

# AWS > S3 > Bucket > Tags
# https://turbot.com/v5/mods/turbot/aws-s3/inspect#/policy/types/bucketTags
resource "turbot_policy_setting" "aws_s3_bucket_tags" {
  count    = var.enable_s3_tag_policies ? 1 : 0
  resource = turbot_smart_folder.aws_all_s3.id
  type     = "tmod:@turbot/aws-s3#/policy/types/bucketTags"
  value    = "Check: Tags are correct"
}

# AWS > S3 > Bucket > Tags > Template
# https://turbot.com/v5/mods/turbot/aws-s3/inspect#/policy/types/bucketTagsTemplate
resource "turbot_policy_setting" "aws_s3_bucket_tags_template" {
  count          = var.enable_s3_tag_policies ? 1 : 0
  resource       = turbot_smart_folder.aws_all_s3.id
  type           = "tmod:@turbot/aws-s3#/policy/types/bucketTagsTemplate"
  template_input = <<-QUERY
    {
      resource {
        turbot {
          title
          tags
        }
        creator: notifications(filter: "sort:version_id limit:1") {
          items {
            actor {
              alternatePersona
              identity {
                turbot {
                  title
                }
              }
            }
            turbot {
              createTimestamp
            }
          }
        }
      }
    }
  QUERY
  # Nunjucks template to set tags and check for tag validity.
  template = <<-TEMPLATE
    # Bring in environment metadata / attributes
    Name: "{{ $.resource.turbot.title }}"
    # Enforce selection of values, set to "Non-Compliant" if out of bounds
    Environment: "{% if $.resource.turbot.tags['Environment'] in ['Dev', 'QA', 'Prod', 'Temp'] %}{{ $.resource.turbot.tags['Environment'] }}{% else %}Non-Compliant Tag{% endif %}"
    # Actor who created the resource
    CreatedByActor: "{% if $.resource.creator.items[0].actor.identity.turbot.title == 'Unidentified Identity' %}{{ $.resource.creator.items[0].actor.alternatePersona }}{% else %}{{ $.resource.creator.items[0].actor.identity.turbot.title }}{% endif %}"
    # Creation Timestamp
    CreatedByTime: "{{ $.resource.creator.items[0].turbot.createTimestamp }}"
  TEMPLATE
}
