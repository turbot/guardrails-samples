---
organization: Turbot
category: ["public cloud"]
icon_url: "/images/plugins/turbot/gcp.svg"
brand_color: "#FF9900" # TODO: verify the brand_color
display_name: "Enforce enable block project-wide SSH keys for GCP Compute Engine instances"
short_name: "enforce_enable_block_project_wide_ssh_keys_for_instance"
description: "Enforce enable block project-wide SSH keys for GCP Compute Engine instances."
mod_dependencies:
  - "@turbot/gcp"
  - "@turbot/gcp-iam"
  - "@turbot/gcp-computeengine"
---

# Enforce enable block project-wide SSH keys for GCP Compute Engine instances

This Policy Pack enables block project-wide SSH keys setting for compute engine instances, using Terraform. It automates the creation and setup of necessary Guardrails policies which will allow Guardrails to automatically detect and enable block project-wide SSH keys.

## Documentation

- **[Policy pack definitions & examples →](#)**

## Get started

### Install

Clone the repo locally:

```sh
git clone https://github.com/turbot/guardrails-samples.git
cd guardrails-samples/policy_packs/gcp/computeengine/enforce_enable_block_project_wide_ssh_keys_for_instance
```

### Credentials

Installing this Policy Pack requires [admin credentials to a Turbot Guardrails workspace](https://turbot.com/guardrails/docs/guides/iam/access-keys) and [a way to run Terraform](https://turbot.com/guardrails/docs/7-minute-labs/terraform).

### Configuration

- **[Set up your Guardrails environment variables →](https://registry.terraform.io/providers/turbot/turbot/latest/docs#environment-variables)**

## How to use

### Create the Policy Pack in your workspace

  ```sh
  terraform init
  terraform plan 
  terraform apply
  ```

### Attach the Policy Pack to your project

- Within the Guardrails UI navigate to [{workspace-url}/apollo?exploreMode=account](#).
- Select the project from the list for testing.
- Click on the "Detail" sub-tab and look for the "Policy Packs" widget in the bottom right of the page.
- Select the "MANAGE" link and `+ Add` the `Enforce enable block project-wide SSH keys for GCP Compute Engine instances` Policy Pack from the dropdown menu.
- Select "Save".

> [!IMPORTANT]
> Do not add or remove more than one Policy Pack to a resource at a time. Adding Policy Packs is an asynchronous operation, after changing the Policy Pack configuration for a resource, wait at least 5 minutes before adding or removing other Policy Packs.

### Verify state (OK, Alarm, Error) of associated controls

Within the Guardrails UI navigate to:

  ```sh
  {workspace-url}/apollo/controls/explore?filter=controlTypeId%3A%27tmod%3A%40turbot%2Fgcp-computeengine%23%2Fcontrol%2Ftypes%2FinstanceBlockProjectWideSshKeys%27
  ```

  Replace `{workspace-url}` with the FQDN of your workspace (e.g. <https://company.cloud.turbot.com>). Use the "Resource" filter to select the test account where the Policy Pack is attached. Review all controls in `Alarm` state to understand why they are violating this policy pack objective.

### Resolve the alarms

For each control type, choose to [resolve the alarms](https://turbot.com/guardrails/docs/guides/quick-actions), [create resource exceptions](https://turbot.com/guardrails/docs/getting-started/activity-exceptions#manual-policy-exceptions) or to apply enforcement settings. The default setting for all controls are set to `Check: ...`. Each policy with an enforcement option will have a corresponding enforcement setting that is commented out. These can easily be found by searching across the `*.tf` files for `Enforce:`.

To apply enforcement automation: Open the Policy Pack Terraform source files in your code editor. Toggle individual controls between `Check` and `Enforce` by changing which line is commented out:

  ```hcl
    resource "turbot_policy_setting" "gcp_compute_engine_instance_block_project_wide_ssh_keys" {
      resource = turbot_smart_folder.pack.id
      type     = "tmod:@turbot/gcp-computeengine#/policy/types/instanceBlockProjectWideSshKeys"
      # value    = "Check: Enabled"
      value    = "Enforce: Enabled"
    }
  ```

  Then re-apply the Terraform stack:

```sh
terraform plan 
terraform apply
```

> [!CAUTION]
> Enforcement controls have the ability delete data, remove permissions and change configuration of your cloud resources. Guardrails automation is very fast and there is no undo; if you do not fully understand the scope of an enforcement or the potential impact to your applications then do not implement enforcement options.
