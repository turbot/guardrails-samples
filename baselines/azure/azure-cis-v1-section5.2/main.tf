provider azurerm {
  features {}
}

# 5.2.1 Ensure that Activity Log Alert exists for Create Policy Assignment (Scored)
resource "azurerm_monitor_activity_log_alert" "setting_5_2_1" {
  name                = "policy-alert"
  resource_group_name = var.resource_group_name
  scopes              = var.scopes
  description         = "This alert will monitor all policy attachments"


  criteria {
    operation_name = "Microsoft.Authorization/policyassignments/write"
    resource_type  = "microsoft.authorization/policyassignments"
    resource_provider = "microsoft.authorization/policyassignments"
    category       = "Administrative"
  }
}

# 5.2.2 Ensure that Activity Log Alert exists for Create or Update Network Security Group (Scored)
resource "azurerm_monitor_activity_log_alert" "setting_5_2_2" {
  name                = "nsg-alert"
  resource_group_name = var.resource_group_name
  scopes              = var.scopes
  description         = "This alert will monitor all nsgs"


  criteria {
    operation_name = "Microsoft.Network/networkSecurityGroups/write"
    resource_type  = "microsoft.network/networksecuritygroups"
    category       = "Administrative"
  }
}

# 5.2.3 Ensure that Activity Log Alert exists for Delete Network Security Group (Scored)
resource "azurerm_monitor_activity_log_alert" "setting_5_2_3" {
  name                = "nsg-delete-alert"
  resource_group_name = var.resource_group_name
  scopes              = var.scopes
  description         = "This alert will monitor all nsgs"


  criteria {
    operation_name = "Microsoft.Network/networkSecurityGroups/delete"
    resource_type  = "microsoft.network/networksecuritygroups"
    category       = "Administrative"
  }
}

# 5.2.4 Ensure that Activity Log Alert exists for Create or Update Network Security Group Rule (Scored)
resource "azurerm_monitor_activity_log_alert" "setting_5_2_4" {
  name                = "nsg-rules-alert"
  resource_group_name = var.resource_group_name
  scopes              = var.scopes
  description         = "This alert will monitor all nsgs"


  criteria {
    operation_name = "Microsoft.Network/networkSecurityGroups/securityRules/write"
    resource_type  = "microsoft.network/networkSecurityGroups/securityRules"
    category       = "Administrative"
  }
}

# 5.2.5 Ensure that activity log alert exists for the Delete Network Security Group Rule (Scored)
resource "azurerm_monitor_activity_log_alert" "setting_5_2_5" {
  name                = "nsg-rules-delete-alert"
  resource_group_name = var.resource_group_name
  scopes              = var.scopes
  description         = "This alert will monitor all nsgs"


  criteria {
    operation_name = "Microsoft.Network/networkSecurityGroups/securityRules/delete"
    resource_type  = "microsoft.network/networkSecurityGroups/securityRules"
    category       = "Administrative"
  }
}

# 5.2.6 Ensure that Activity Log Alert exists for Create or Update Security Solution (Scored)
resource "azurerm_monitor_activity_log_alert" "setting_5_2_6" {
  name                = "security-solutions-alert"
  resource_group_name = var.resource_group_name
  scopes              = var.scopes
  description         = "This alert will monitor all nsgs"


  criteria {
    operation_name = "Microsoft.Security/securitySolutions/write"
    resource_type  = "microsoft.security/securitySolutions"
    category       = "Administrative"
  }
}

# 5.2.7 Ensure that Activity Log Alert exists for Delete Security Solution (Scored)
resource "azurerm_monitor_activity_log_alert" "setting_5_2_7" {
  name                = "security-solutions-delete-alert"
  resource_group_name = var.resource_group_name
  scopes              = var.scopes
  description         = "This alert will monitor all nsgs"


  criteria {
    operation_name = "Microsoft.Security/securitySolutions/delete"
    resource_type  = "microsoft.security/securitySolutions"
    category       = "Administrative"
  }
}

# 5.2.8 Ensure that Activity Log Alert exists for Create or Update or Delete SQL Server Firewall Rule (Scored)
resource "azurerm_monitor_activity_log_alert" "setting_5_2_8" {
  name                = "sql-servers-firewall-rules-alert"
  resource_group_name = var.resource_group_name
  scopes              = var.scopes
  description         = "This alert will monitor all nsgs"


  criteria {
    operation_name = "Microsoft.Sql/servers/firewallRules/write"
    resource_type  = "microsoft.sql/servers/firewallRules"
    category       = "Administrative"
  }
}

# 5.2.9 Ensure that Activity Log Alert exists for Update Security Policy (Scored)
resource "azurerm_monitor_activity_log_alert" "setting_5_2_9" {
  name                = "security-policies-alert"
  resource_group_name = var.resource_group_name
  scopes              = var.scopes
  description         = "This alert will monitor all nsgs"


  criteria {
    operation_name = "Microsoft.Security/policies/write"
    resource_type  = "microsoft.security/policies"
    category       = "Administrative"
  }
}
