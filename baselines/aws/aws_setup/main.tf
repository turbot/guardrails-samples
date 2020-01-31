resource "turbot_smart_folder" "aws_folder" {
  title       = var.smart_folder_title
  description = "Smart folder for importing the aws account:"
  parent      = var.folder_parent
}

# Region Defaults
# AWS > Account > Regions [Default]
resource "turbot_policy_setting" "regionsDefault" {
  resource    = turbot_smart_folder.aws_folder.id
  type        = "tmod:@turbot/aws#/policy/types/regionsDefault"
  value       = var.aws_regions
}

# Approved Regions
# AWS > Account > Approved Regions [Default]
resource "turbot_policy_setting" "approvedRegionsDefault" {
  resource    = turbot_smart_folder.aws_folder.id
  type        = "tmod:@turbot/aws#/policy/types/approvedRegionsDefault"
  value       = var.aws_regions
}

# Create AWS logging bucket
# AWS > Turbot > Logging > Bucket
resource "turbot_policy_setting" "loggingBucket" {
  resource    = turbot_smart_folder.aws_folder.id
  type        = "tmod:@turbot/aws#/policy/types/loggingBucket"
  value       = "Enforce: Configured"
  count       = var.setup_cloudtrail ? 1 : 0
}

# Create AWS CloudTrail using AuditTrail stack
# AWS > Turbot > Audit Trail > CloudTrail > Trail >
resource "turbot_policy_setting" "auditTrail" {
  resource    = turbot_smart_folder.aws_folder.id
  type        = "tmod:@turbot/aws#/policy/types/auditTrail"
  value       = "Enforce: Configured"
  count       = var.setup_cloudtrail ? 1 : 0
}

# Create the Trail type
# AWS > Turbot > Audit Trail > CloudTrail > Trail > Type
resource "turbot_policy_setting" "trailType" {
  resource    = turbot_smart_folder.aws_folder.id
  type        = "tmod:@turbot/aws#/policy/types/trailType"
  value       = "A multi-region trail in the `Trail > Global Region` in each account"
  count       = var.setup_cloudtrail ? 1 : 0
}

# Create Event Handlers as per the Region Defaults
# AWS > Turbot > Event Handlers
resource "turbot_policy_setting" "eventHandlers" {
  resource    = turbot_smart_folder.aws_folder.id
  type        = "tmod:@turbot/aws#/policy/types/eventHandlers"

  template_input = <<EOT
    {

      resource_region: resource {
        turbot {
          custom
        }
      }
      regions_default: policyValue(uri: "tmod:@turbot/aws#/policy/types/regionsDefault") {
        value
      }
    }
  EOT

  template      = <<EOT
    {% if $.resource_region.turbot.custom.aws.regionName in $.regions_default.value %}
    "Enforce: Configured"
    {% else %}
    "Skip"
    {% endif %}
  EOT
}

# Create the service roles and sets the value
# AWS > Turbot > Service Roles
resource "turbot_policy_setting" "serviceRoles" {
  resource    = turbot_smart_folder.aws_folder.id
  type        = "tmod:@turbot/aws#/policy/types/serviceRoles"
  value       = "Enforce: Configured"
}
