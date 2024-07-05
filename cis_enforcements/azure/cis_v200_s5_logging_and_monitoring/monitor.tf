# Azure > Monitor > Stack
resource "turbot_policy_setting" "azure_monitor_stack" {
  resource = turbot_smart_folder.main.id
  type     = "tmod:@turbot/azure-monitor#/policy/types/monitorStack"
  note     = "Azure CIS v2.0.0 - Controls: 5.2.1, 5.2.2, 5.2.3, 5.2.4, 5.2.5, 5.2.6, 5.2.7, 5.2.8, 5.2.9, 5.2.10"
  value    = "Check: Configured"
  # value    = "Enforce: Configured"
}

# Azure > Monitor > Stack > Source
resource "turbot_policy_setting" "azure_monitor_stack_source" {
  resource       = turbot_smart_folder.main.id
  type           = "tmod:@turbot/azure-monitor#/policy/types/monitorStackSource"
  note           = "Azure CIS v2.0.0 - Controls: 5.2.1, 5.2.2, 5.2.3, 5.2.4, 5.2.5, 5.2.6, 5.2.7, 5.2.8, 5.2.9, 5.2.10"
  template_input = <<-EOT
    {
      resourceGroup  {
        metadata
      }
    }
    EOT
  template       = <<-EOT
    |
    resource "azurerm_monitor_action_group" "monitor_action_group_5_2" {
      name                = "azure_cis_v200_s5_2_action_group"
      resource_group_name = {{ $.resourceGroup.metadata.azure.resourceGroupName }}
      short_name          = "azure_cis_v200_s5_2_action_group"

      email_receiver {
        name                    = "John Doe"
        email_address           = "test@example.com"
        use_common_alert_schema = true
      }
    }

    resource "azurerm_monitor_activity_log_alert" "monitor_log_alert_5_2_1" {
      name                = "create_policy_assignment_log_alert"
      resource_group_name = {{ $.resourceGroup.metadata.azure.resourceGroupName }}
      scopes              = ["/subscriptions/{{ $.resourceGroup.metadata.azure.subscriptionId }}"]
      description         = "Activity log alert on create policy assignment."

      criteria {
        category        = "Administrative"
        operation_name  = "Microsoft.Authorization/policyAssignments/write"
        level           = "Informational"
      }

      action {
        action_group_id = azurerm_monitor_action_group.monitor_action_group_5_2.id
      }
    }

    resource "azurerm_monitor_activity_log_alert" "monitor_log_alert_5_2_2" {
      name                = "delete_policy_assignment_log_alert"
      resource_group_name = {{ $.resourceGroup.metadata.azure.resourceGroupName }}
      scopes              = ["/subscriptions/{{ $.resourceGroup.metadata.azure.subscriptionId }}"]
      description         = "Activity log alert on delete policy assignment"

      criteria {
        category        = "Administrative"
        operation_name  = "Microsoft.Authorization/policyAssignments/delete"
        level           = "Informational"
      }

      action {
        action_group_id = azurerm_monitor_action_group.monitor_action_group_5_2.id
      }
    }

    resource "azurerm_monitor_activity_log_alert" "monitor_log_alert_5_2_3" {
      name                = "create_update_nsg_log_alert"
      resource_group_name = {{ $.resourceGroup.metadata.azure.resourceGroupName }}
      scopes              = ["/subscriptions/{{ $.resourceGroup.metadata.azure.subscriptionId }}"]
      description         = "Monitor NSG create/update events"

      criteria {
        category        = "Administrative"
        operation_name  = "Microsoft.Network/networkSecurityGroups/write"
        level           = "Informational"
      }

      action {
        action_group_id = azurerm_monitor_action_group.monitor_action_group_5_2.id
      }
    }

    resource "azurerm_monitor_activity_log_alert" "monitor_log_alert_5_2_4" {
      name                = "delete_nsg_log_alert"
      resource_group_name = {{ $.resourceGroup.metadata.azure.resourceGroupName }}
      scopes              = ["/subscriptions/{{ $.resourceGroup.metadata.azure.subscriptionId }}"]
      description         = "Monitor NSG delete events"

      criteria {
        category        = "Administrative"
        operation_name  = "Microsoft.Network/networkSecurityGroups/delete"
        level           = "Informational"
      }

      action {
        action_group_id = azurerm_monitor_action_group.monitor_action_group_5_2.id
      }
    }

    resource "azurerm_monitor_activity_log_alert" "monitor_log_alert_5_2_5" {
      name                = "create_update_security_solution_log_alert"
      resource_group_name = {{ $.resourceGroup.metadata.azure.resourceGroupName }}
      scopes              = ["/subscriptions/{{ $.resourceGroup.metadata.azure.subscriptionId }}"]
      description         = "Activity log alert on create/update security solutions"

      criteria {
        category        = "Administrative"
        operation_name  = "Microsoft.Security/securitySolutions/write"
        level           = "Informational"
      }

      action {
        action_group_id = azurerm_monitor_action_group.monitor_action_group_5_2.id
      }
    }

    resource "azurerm_monitor_activity_log_alert" "monitor_log_alert_5_2_6" {
      name                = "delete_security_solution_log_alert"
      resource_group_name = {{ $.resourceGroup.metadata.azure.resourceGroupName }}
      scopes              = ["/subscriptions/{{ $.resourceGroup.metadata.azure.subscriptionId }}"]
      description         = "Activity log alert on delete security solutions"

      criteria {
        category        = "Administrative"
        operation_name  = "Microsoft.Security/securitySolutions/delete"
        level           = "Informational"
      }

      action {
        action_group_id = azurerm_monitor_action_group.monitor_action_group_5_2.id
      }
    }

    resource "azurerm_monitor_activity_log_alert" "monitor_log_alert_5_2_7" {
      name                = "create_update_sql_server_firewall_rule_log_alert"
      resource_group_name = {{ $.resourceGroup.metadata.azure.resourceGroupName }}
      scopes              = ["/subscriptions/{{ $.resourceGroup.metadata.azure.subscriptionId }}"]
      description         = "Activity log alert on create/update SQL server firewall rules"

      criteria {
        category        = "Administrative"
        operation_name  = "Microsoft.Sql/servers/firewallRules/write"
        level           = "Informational"
      }

      action {
        action_group_id = azurerm_monitor_action_group.monitor_action_group_5_2.id
      }
    }

    resource "azurerm_monitor_activity_log_alert" "monitor_log_alert_5_2_8" {
      name                = "delete_sql_server_firewall_rule_log_alert"
      resource_group_name = {{ $.resourceGroup.metadata.azure.resourceGroupName }}
      scopes              = ["/subscriptions/{{ $.resourceGroup.metadata.azure.subscriptionId }}"]
      description         = "Activity log alert on delete SQL server firewall rules"

      criteria {
        category        = "Administrative"
        operation_name  = "Microsoft.Sql/servers/firewallRules/delete"
        level           = "Informational"
      }

      action {
        action_group_id = azurerm_monitor_action_group.monitor_action_group_5_2.id
      }
    }

    resource "azurerm_monitor_activity_log_alert" "monitor_log_alert_5_2_9" {
      name                = create_update_public_ip_address_log_alert
      resource_group_name = {{ $.resourceGroup.metadata.azure.resourceGroupName }}
      scopes              = ["/subscriptions/{{ $.resourceGroup.metadata.azure.subscriptionId }}"]
      description         = "Activity log alert on create/update Public IP Addresses"

      criteria {
        category        = "Administrative"
        operation_name  = "Microsoft.Network/publicIPAddresses/write"
        level           = "Informational"
      }

      action {
        action_group_id = azurerm_monitor_action_group.monitor_action_group_5_2.id
      }
    }

    resource "azurerm_monitor_activity_log_alert" "monitor_log_alert_5_2_10" {
      name                = "delete_public_ip_address_log_alert"
      resource_group_name = {{ $.resourceGroup.metadata.azure.resourceGroupName }}
      scopes              = ["/subscriptions/{{ $.resourceGroup.metadata.azure.subscriptionId }}"]
      description         = "Activity log alert on delete Public IP Addresses"

      criteria {
        category        = "Administrative"
        operation_name  = "Microsoft.Network/publicIPAddresses/delete"
        level           = "Informational"
      }

      action {
        action_group_id = azurerm_monitor_action_group.monitor_action_group_5_2.id
      }
    }
    EOT
}

# Azure > Subscription > Stack > Terraform Version
resource "turbot_policy_setting" "azure_monitor_stack_terraform_version" {
  resource = turbot_smart_folder.azure_cis_v200_s5_monitoring.id
  type     = "tmod:@turbot/azure-monitor#/policy/types/monitorStackTerraformVersion"
  note     = "Azure CIS v2.0.0 - Controls:  5.2.1, 5.2.2, 5.2.3, 5.2.4, 5.2.5, 5.2.6, 5.2.7, 5.2.8, 5.2.9, 5.2.10"
  value    = "0.15.*"
}
