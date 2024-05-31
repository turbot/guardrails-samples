---
benchmark: Azure CIS v2.0.0
section_number: 5.2
section_name: Monitoring using Activity Log Alerts
cis_description: |
    The recommendations provided in this section are intended to provide entry-level alerting for crucial activities on a tenant account. These recommended activities should be tuned to your needs. By default, each of these Activity Log Alerts tends to guide the reader to alerting at the "Subscription-wide" level which will capture and alert on rules triggered by all resources and resource groups contained within a subscription. This is not an ideal rule set for Alerting within larger and more complex organizations. While this section provides recommendations for the creation of Activity Log Alerts specifically, Microsoft Azure supports four different types of alerts:
    - Metric Alerts
    - Log Alerts
    - Activity Log Alerts
    - Smart Detection Alerts

    All Azure services (Microsoft provided or otherwise) that can generate alerts are assigned a "Resource provider namespace" when they are registered in an Azure tenant. The recommendations in this section are in no way exhaustive of the plethora of available "Providers" or "Resource Types." The Resource Providers that are registered in your Azure Tenant can be located in your Subscription. Each registered Provider in your environment may have available "Conditions" to raise alerts via Activity Log Alerts. These providers should be considered for inclusion in Activity Log Alert rules of your own making.
    To view the registered resource providers in your Subscription(s), use this guide:
    - https://docs.microsoft.com/en-us/azure/azure-resource-manager/management/resource-providers-and-types

    If you wish to create custom alerting rules for Activity Log Alerts or other alert types, please refer to Microsoft documentation:
    - https://docs.microsoft.com/en-us/azure/azure-monitor/alerts/alerts-create-new-alert-rule"
icon: "azure.svg"
mod_dependencies:
  - "@turbot/azure"
  - "@turbot/azure-monitor"
---

# Enforce Azure CIS v2.0.0 - Section 5.2 - Monitoring using Activity Log Alerts

Automate enforcement of CIS benchmark best practices using Turbot Guardrails.

The Terraform stack defined in this section will create a Guardrails Smart Folder, containing specific policy examples, to automate enforcement controls aligned to the [CIS Azure Foundations Benchmark](https://learn.microsoft.com/en-us/azure/governance/policy/samples/cis-azure-2-0-0).

## Installation

Installing this Smart Folder requires [admin credentials to a Turbot Guardrails workspace](https://turbot.com/guardrails/docs/guides/iam/access-keys) and [a way to run Terraform](https://turbot.com/guardrails/docs/7-minute-labs/terraform).

Clone the repo locally:

```sh
git clone https://github.com/turbot/guardrails-samples.git
cd guardrails-samples/cis_enforcements/azure/cis_v200_s5_logging_and_monitoring/
```

## How to use

1. __Set the variable values__:

    ```sh
    cp monitoring.tfvars.example monitoring.tfvars
    vi monitoring.tfvars
    ```

    ```hcl
    # Log Metric Alert name for control 5.2.1
    monitor_log_alert_name_5_2_1 = "create_policy_assignment_log_alert"
    # Log Metric Alert name for control 5.2.2
    monitor_log_alert_name_5_2_2 = "delete_policy_assignment_log_alert"
    # Log Metric Filter name for control 5.2.3
    monitor_log_alert_name_5_2_3 = "create_update_nsg_log_alert"
    # Log Metric Alert name for control 5.2.4
    monitor_log_alert_name_5_2_4 = "delete_nsg_log_alert"
    ```

1. __Create the Smart Folder in your workspace__:

    ```sh
    terraform init
    export TURBOT_PROFILE="my-workspace"
    terraform plan 
    terrafrom apply
    ```

1. __Attach the Smart Folder to your test account__: Within the Guardrails UI navigate to [{workspace-url}/apollo?exploreMode=account](#). Select the account from the list for testing. Click on the "Detail" subtab and look for the "Smart Folders" widget in the bottom right of the page. Select the "MANAGE" link and `+ Add` the `Azure CIS v2.0.0 - Section 5 - Monitoring using Activity Log Alerts` Smart Folder from the dropdown menu, then select "Save".
    > [!IMPORTANT]
    > Do not add or remove more than one Smart Folder to a resource at a time. Adding Smart Folders is an asynchronous operation, after changing the Smart Folder configuration for a resource, wait at least 5 minutes before adding or removing other Smart Folders.

1. __Verify state (`OK`, `Alarm`, `Error`) of associated controls__: Within the Guardrails UI navigate to: 
    ```
    {workspace-url}/apollo/reports/alerts-by-control-type?filter=state%3Aalarm+controlTypeId%3A%27tmod%3A%40turbot%2Fazure%23%2Fcontrol%2Ftypes%2FsubscriptionStack%27
    ```

    Replace `{workspace-url}` with the FQDN of your workspace (e.g. https://company.cloud.turbot.com). Use the "Resource" filter to select the test account where the Smart Folder is attached. Review all controls in `Alarm` state to understand why they are violating CIS control objectives.

1. For each control type, choose to [resolve the alarms](https://turbot.com/guardrails/docs/guides/quick-actions), [create resource exceptions](https://turbot.com/guardrails/docs/getting-started/activity-exceptions#manual-policy-exceptions) or to apply enforcement settings. The default setting for all controls are set to `Check: ...`. Each policy with an enforcement option will have a corresponding enforcement setting that is commented out. These can easily be found by searching across the `*.tf` files for `Enforce:`.
1. To apply enforcement automation: Open the Smart Folder Terraform source files in your code editor. Toggle individual controls between `Check` and `Enforce` by changing which line is commented out:

    ```hcl
    resource "turbot_policy_setting" "example" {
      resource = turbot_smart_folder.example.id
      type     = "tmod:@turbot/azure#/policy/types/resourceName"
      # value    = "Check: Approved"
      value    = "Enforce: Delete unapproved"
    }
    ```

    Then re-apply the Terraform stack:

    ```sh
    terraform plan 
    terrafrom apply
    ```

    > [!CAUTION]
    > Enforcement controls have the ability delete data, remove permissions and change configuration of your cloud resources. Guardrails automation is very fast and there is no undo; if you do not fully understand the scope of an enforcement or the potential impact to your applications then do not implement enforcement options.