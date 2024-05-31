# Azure > Security Center > Security Center > Defender Plan
resource "turbot_policy_setting" "azure_securitycenter_defender_plan" {
  resource = turbot_smart_folder.azure_cis_v200_s2_microsoft_defender.id
  type     = "tmod:@turbot/azure-securitycenter#/policy/types/securityCenterDefenderPlan"
  note     = "Azure CIS v2.0.0 - Controls: 2.1.1, 2.1.2, 2.1.3, 2.1.4, 2.1.5, 2.1.6, 2.1.7, 2.1.8, 2.1.9, 2.1.10, 2.1.11, 2.1.12"
  value    = "Check: Defender Plan Disabled"
  # value    = "Check: Defender Plan Enabled"
  # value    = "Enforce: Defender Plan Disabled"
  # value    = "Enforce: Defender Plan Enabled"
}

# Azure > Security Center > Security Center > Defender Plan > Resource Type
resource "turbot_policy_setting" "azure_securitycenter_defender_plan_resource_type" {
  resource = turbot_smart_folder.azure_cis_v200_s2_microsoft_defender.id
  type     = "tmod:@turbot/azure-securitycenter#/policy/types/securityCenterDefenderPlanResourceType"
  note     = "Azure CIS v2.0.0 - Controls: 2.1.1, 2.1.2, 2.1.3, 2.1.4, 2.1.5, 2.1.6, 2.1.7, 2.1.8, 2.1.9, 2.1.10, 2.1.11, 2.1.12"
  value    = jsonencode(["Servers", "API", "App Service", "Azure SQL Databases", "Cloud Posture", "Container registries", "Containers", "Cosmos DB", "DNS", "Key Vault", "Kubernetes", "Open-source relational databases", "Resource Manager", "SQL servers on machines", "Storage"])
}

# Azure > Security Center > Security Center > Auto Provisioning
resource "turbot_policy_setting" "azure_securitycenter_auto_provisioning" {
  resource = turbot_smart_folder.azure_cis_v200_s2_microsoft_defender.id
  type     = "tmod:@turbot/azure-securitycenter#/policy/types/securityCenterAutoProvisioning"
  note     = "Azure CIS v2.0.0 - Control: 2.1.15"
  value    = "Check: Disabled"
  #   value    = "Check: Enabled"
  #   value    = "Enforce: Disabled"
  #   value    = "Enforce: Enabled"
}
