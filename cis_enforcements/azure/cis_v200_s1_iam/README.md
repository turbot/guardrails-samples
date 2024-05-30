---
benchmark: Azure CIS v2.0.0
section_number: 1
section_name: Identity and Access Management
cis_description: |
  This section covers security recommendations to set identity and access management policies on an Azure Subscription. Identity and Access Management policies are the first step towards a defense-in-depth approach to securing an Azure Cloud Platform environment.

  Many of the recommendations from this section are marked as "Manual" while the existing Azure CLI and Azure AD PowerShell support through the Azure AD Graph are being depreciated. It is now recommended to use the new Microsoft Graph in replacement of Azure AD Graph for PowerShell and API level access. From a security posture standpoint, these recommendations are still very important and should not be discounted because they are "Manual." As automation capability using Rest API is developed for this Benchmark, the related recommendations will be updated with the respective audit and remediation steps and changed to an "automated" assessment status.

  If any problems are encountered running Azure CLI or PowerShell methodologies, please refer to the Overview for this benchmark where you will find additional detail on permission and required cmdlets.
icon: "azure.svg"
mod_dependencies:
  - "@turbot/azure"
  - "@turbot/azure-activedirectory"
---

# Enforce Azure CIS v2.0.0 - Section 1 - Identity and Access Management

Automate enforcement of CIS benchmark best practices using Turbot Guardrails.

The Terraform stack defined in this section will create a Guardrails Smart Folder, containing specific policy examples, to automate enforcement controls aligned to the [CIS Azure Foundations Benchmark](https://learn.microsoft.com/en-us/azure/governance/policy/samples/cis-azure-2-0-0).

## Installation

Installing this Smart Folder requires [admin credentials to a Turbot Guardrails workspace](https://turbot.com/guardrails/docs/guides/iam/access-keys) and [a way to run Terraform](https://turbot.com/guardrails/docs/7-minute-labs/terraform).

Clone the repo locally:

```sh
git clone https://github.com/turbot/guardrails-samples.git
cd guardrails-samples/cis_enforcements/azure/cis_v200_s1_iam/
```

## How to use

<!-- 1. **Set the variable values**:

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
   ``` -->

1. **Create the Smart Folder in your workspace**:

   ```sh
   terraform init
   export TURBOT_PROFILE="my-workspace"
   terraform plan
   terrafrom apply
   ```

2. **Attach the Smart Folder to your test account**: Within the Guardrails UI navigate to [{workspace-url}/apollo?exploreMode=account](#). Select the account from the list for testing. Click on the "Detail" subtab and look for the "Smart Folders" widget in the bottom right of the page. Select the "MANAGE" link and `+ Add` the `Azure CIS v2.0.0 - Section 1 - Identity and Access Management` Smart Folder from the dropdown menu, then select "Save".

   > [!IMPORTANT]
   > Do not add or remove more than one Smart Folder to a resource at a time. Adding Smart Folders is an asynchronous operation, after changing the Smart Folder configuration for a resource, wait at least 5 minutes before adding or removing other Smart Folders.

3. **Verify state (`OK`, `Alarm`, `Error`) of associated controls**: Within the Guardrails UI navigate to:

   ```
   {workspace-url}/apollo/reports/alerts-by-control-type?filter=state%3Aalarm+controlTypeId%3A%27tmod%3A%40turbot%2Fazure%23%2Fcontrol%2Ftypes%2FsubscriptionStack%27
   ```

   Replace `{workspace-url}` with the FQDN of your workspace (e.g. https://company.cloud.turbot.com). Use the "Resource" filter to select the test account where the Smart Folder is attached. Review all controls in `Alarm` state to understand why they are violating CIS control objectives.

4. For each control type, choose to [resolve the alarms](https://turbot.com/guardrails/docs/guides/quick-actions), [create resource exceptions](https://turbot.com/guardrails/docs/getting-started/activity-exceptions#manual-policy-exceptions) or to apply enforcement settings. The default setting for all controls are set to `Check: ...`. Each policy with an enforcement option will have a corresponding enforcement setting that is commented out. These can easily be found by searching across the `*.tf` files for `Enforce:`.
5. To apply enforcement automation: Open the Smart Folder Terraform source files in your code editor. Toggle individual controls between `Check` and `Enforce` by changing which line is commented out:

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
