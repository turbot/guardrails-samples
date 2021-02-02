# Smart Folder Definition
resource "turbot_smart_folder" "resource_owner_tags" {
  title       = var.smart_folder_title
  description = var.smart_folder_description
  parent      = var.smart_folder_parent_resource
}


# Below examples assumes global tag templates e.g. AWS > Account > Tags Template [Default]
# Could be set globally per Service, e.g. AWS > S3 > Tags Template [Default]
# Or set per resource type, e.g. AWS > S3 > Bucket > Tags > Template

# To enable the template, per service enable the tag action:
# e.g. AWS > S3 > Bucket > Tags: tmod:@turbot/aws-s3#/policy/types/bucketTags
# More information: https://turbot.com/v5/docs/concepts/guardrails/tagging



# AWS > Account > Tags Template [Default]
resource "turbot_policy_setting" "aws_account_tags_template" {
  resource = turbot_smart_folder.resource_owner_tags.id
  type     = "tmod:@turbot/aws#/policy/types/defaultTagsTemplate"
  # GraphQL to pull resource information
  template_input = <<EOT
    {
      resource {
        creator: notifications(filter: "sort:version_id limit:1") {
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
  # Nunjucks template to set the tag values
  template = <<EOT
    # Actor who created the resource 
    created_by: "{{ $.resource.creator.items[0].actor.identity.turbot.title }}"

    # Creation timestamp
    created_time: "{{ $.resource.creator.items[0].turbot.createTimestamp }}"
  EOT
}

# Azure > Subscription > Tags Template [Default]
resource "turbot_policy_setting" "azure_subscription_tags_template" {
  resource = turbot_smart_folder.resource_owner_tags.id
  type     = "tmod:@turbot/azure#/policy/types/defaultTagsTemplate"
  # GraphQL to pull resource information
  template_input = <<EOT
    {
      resource {
        creator: notifications(filter: "sort:version_id limit:1") {
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
  # Nunjucks template to set the tag values
  template = <<EOT
    # Actor who created the resource 
    created_by: "{{ $.resource.creator.items[0].actor.identity.turbot.title }}"

    # Creation timestamp
    created_time: "{{ $.resource.creator.items[0].turbot.createTimestamp }}"
  EOT
}

# GCP > Project > Labels Template [Default]
resource "turbot_policy_setting" "gcp_project_labels_template" {
  resource = turbot_smart_folder.resource_owner_tags.id
  type     = "tmod:@turbot/gcp#/policy/types/defaultLabelsTemplate"
  # GraphQL to pull resource information
  template_input = <<EOT
    {
      resource {
        creator: notifications(filter: "sort:version_id limit:1") {
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
  # Nunjucks template to set the tag values
  template = <<EOT
    # Actor who created the resource
    {%- set owner = $.resource.creator.items[0].actor.identity.turbot.title -%}
    created_by: "{{ owner | lower | replace(" ", "_") }}"

    # Creation Timestamp
    {%- set create_time = $.resource.creator.items[0].turbot.createTimestamp -%}
    created_time: "{{ create_time | lower | replace(".", "_") | replace(":", "-") }}"
  EOT
}