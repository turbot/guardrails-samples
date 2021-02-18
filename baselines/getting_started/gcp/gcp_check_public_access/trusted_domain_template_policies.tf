# Trusted Domains Template - sets the global template for all services, pulls from tfvars file
# Individual services can have their own set of trusted accounts as well
# More Info: https://turbot.com/v5/docs/concepts/guardrails/trusted-access

# List of Trusted Domains
# Could also consider Trusted Groups, Projects, Service Accounts, and Users

resource "turbot_policy_setting" "project_trusted_domains_template" {
  resource = turbot_smart_folder.gcp_public_access.id
  type     = "tmod:@turbot/gcp#/policy/types/trustedDomains"
  value    = <<-EOT
    - "*" # allows all, adjust for specific domains (e.g. gmail.com, turbot.com)
    - "turbot.com" #example of setting a specific domain
EOT
}

#Loop through var.service_status and set enable policies
resource "turbot_policy_setting" "gcp_service_trusted_access" {
  for_each = local.policy_map
  resource = turbot_smart_folder.gcp_public_access.id
  type     = each.value
  value    = "Check: Trusted Access > *"
}
