---
organization: Turbot
category: ["public cloud"]
icon_url: "/images/plugins/turbot/azure.svg"
brand_color: "#FF9900"
display_name: "Enforce Approved Extensions Are Installed on Azure Compute Virtual Machines"
short_name: "enforce_approved_extensions_installed_for_vms"
description: "Stop/Terminate Azure compute virtual machines use unapproved extensions."
mod_dependencies:
  - "@turbot/azure"
  - "@turbot/azure-iam"
  - "@turbot/azure-compute"
---

# Enforce Approved Extensions Are Installed on Azure Compute Virtual Machines

This Policy Pack stops/terminates Virtual Machines that use unapproved extensions, using Terraform. It automates the creation and setup of necessary Guardrails policies which will allow Guardrails to automatically stop/terminate unapproved virtual machines.

## Documentation

- **[Policy pack definitions & examples →](#)**

## Get started

### Install

Clone the repo locally:

```sh
git clone https://github.com/turbot/guardrails-samples.git
cd guardrails-samples/policy_packs/azure/compute/enforce_approved_extensions_installed_for_vms
```

### Credentials

Installing this Policy Pack requires [admin credentials to a Turbot Guardrails workspace](https://turbot.com/guardrails/docs/guides/iam/access-keys) and [a way to run Terraform](https://turbot.com/guardrails/docs/7-minute-labs/terraform).

### Configuration

- **[Set up your Guardrails credentials →](https://turbot.com/guardrails/docs/7-minute-labs/cli#set-up-your-turbot-credentials)**

## How to use

### Create the Policy Pack in your workspace

  ```sh
  terraform init
  export TURBOT_PROFILE="my-workspace"
  terraform plan 
  terraform apply
  ```

### Attach the Policy Pack to your account

- Within the Guardrails UI navigate to [{workspace-url}/apollo?exploreMode=account](#).
- Select the account from the list for testing.
- Click on the "Detail" sub-tab and look for the "Policy Packs" widget in the bottom right of the page.
- Select the "MANAGE" link and `+ Add` the `Enforce Approved Extensions Are Installed on Azure Compute Virtual Machines` Policy Pack from the dropdown menu.
- Select "Save".

> [!IMPORTANT]
> Do not add or remove more than one Policy Pack to a resource at a time. Adding Policy Packs is an asynchronous operation, after changing the Policy Pack configuration for a resource, wait at least 5 minutes before adding or removing other Policy Packs.

### Verify state (OK, Alarm, Error) of associated controls (TODO: subject to change)

Within the Guardrails UI navigate to:

  ```sh
  {workspace-url}/apollo/controls/explore/173989899405234?filter=controlTypeId%3A%27tmod%3A%40turbot%2Fazure-compute%23%2Fcontrol%2Ftypes%2FvirtualMachineApproved%27
  ```

  Replace `{workspace-url}` with the FQDN of your workspace (e.g. <https://company.cloud.turbot.com>). Use the "Resource" filter to select the test account where the Policy Pack is attached. Review all controls in `Alarm` state to understand why they are violating this policy pack objective.

### Resolve the alarms (TODO: subject to change)

For each control type, choose to [resolve the alarms](https://turbot.com/guardrails/docs/guides/quick-actions), [create resource exceptions](https://turbot.com/guardrails/docs/getting-started/activity-exceptions#manual-policy-exceptions) or to apply enforcement settings. The default setting for all controls are set to `Check: ...`. Each policy with an enforcement option will have a corresponding enforcement setting that is commented out. These can easily be found by searching across the `*.tf` files for `Enforce:`.

To apply enforcement automation: Open the Policy Pack Terraform source files in your code editor. Toggle between `Lockdown Disabled` and `Lockdown Enabled: Allow Image > ...` by changing which line is commented out:

  ```hcl
    resource "turbot_policy_setting" "azure_compute_virtual_machine_approved" {
      resource = turbot_smart_folder.main.id
      type     = "tmod:@turbot/azure-compute#/policy/types/virtualMachineApproved"
      # value    = "Check: Approved"
      value    = "Enforce: Stop unapproved"
      # value    = "Enforce: Delete unapproved if new"
    }
  ```

  Then re-apply the Terraform stack:

```sh
terraform plan 
terraform apply
```

> [!CAUTION]
> Enforcement controls have the ability delete data, remove permissions and change configuration of your cloud resources. Guardrails automation is very fast and there is no undo; if you do not fully understand the scope of an enforcement or the potential impact to your applications then do not implement enforcement options.
