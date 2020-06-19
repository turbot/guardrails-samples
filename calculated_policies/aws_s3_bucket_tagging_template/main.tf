# Smart Folder Definition
resource "turbot_smart_folder" "s3_tagging_template" {
  title       = var.smart_folder_title
  description = var.smart_folder_description
  parent      = var.smart_folder_parent_resource
}

# AWS > Region > Bucket > Tags > Template
resource "turbot_policy_setting" "s3_tag_template" {
  resource = "turbot_smart_folder.s3_tagging_template.id"
  type     = "tmod:@turbot/aws-s3#/policy/types/bucketTagsTemplate"
  # GraphQL to pull bucket metadata
  template_input = <<EOT
  {
    account {
      Id
    }
    folder {
      turbot {
        tags
      }
    }
    bucket {
      Name
      turbot {
        tags
      }
      creator: history(filter: "sort:version_id limit:1") {
        items {
          actor {
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
  EOT
  # Nunjucks Template Nunjucks Comments are formatted: {# comment #}
  template = <<EOT
  {# Pull down tags from folder level #}
  Cost Center: "{{ $.folder.turbot.tags.Cost_Center }}"

  {# Set Static Name Example #}
  Company: "Acme Inc."

  {# Bring in AWS environment metadata / attributes #}
  Billing Account Detail: "AF-{{ $.account.Id }}"
  Bucket Name: "{{ $.bucket.Name }}"

  {# Allow any value except null, set to "Non-Compliant" if out of bounds #}
  Description: "{% if $.bucket.turbot.tags['Description'] %}{{ $.bucket.turbot.tags['Description'] }}{% else %}Non-Compliant Tag{% endif %}"

  {# Enforce selection of values, set to "Non-Compliant" if out of bounds #}
  Environment: "{% if $.bucket.turbot.tags['Environment'] in ['Dev', 'QA', 'Prod', 'Temp'] %}{{ $.bucket.turbot.tags['Environment'] }}{% else %}Non-Compliant Tag{% endif %}"

  {# Actor who created the bucket #}
  CreatedByActor: "{{ $.bucket.creator.items[0].actor.identity.turbot.title }}"

  {# Creation Timestamp #}
  CreatedByTime: "{{ $.bucket.creator.items[0].turbot.createTimestamp }}"
  EOT
}
