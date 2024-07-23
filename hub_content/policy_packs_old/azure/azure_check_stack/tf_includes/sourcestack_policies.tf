resource "azurerm_resource_group" "demo_rg" {
  name     = "turbot_stack_demo"
  location = "East US"

  tags = {
    environment = "demo"
  }
}

resource "azurerm_monitor_action_group" "demo_rg" {
    name = "turbot_monitor_action_group_demo"
    resource_group_name = "${azurerm_resource_group.demo_rg.name}"
    short_name  = "eventHandler"
    tags = {
      environment = "demo"
  }
  }
  resource "azurerm_monitor_activity_log_alert" "turbot_azure_event_handler_activity_Log_Alert" {
    name                = "turbot_monitor_log_alert_demo"
    resource_group_name = "${azurerm_resource_group.demo_rg.name}"
    scopes              = ["${azurerm_resource_group.demo_rg.id}"]

    criteria {
    category       = "Administrative"
    status         = "Succeeded"
    level          = "Informational"
    }

    tags = {
      environment = "demo"
    }

    action {
      action_group_id = "${azurerm_monitor_action_group.demo_rg.id}"
    }
  }