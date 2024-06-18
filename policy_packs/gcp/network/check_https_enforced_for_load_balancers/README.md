---
organization: Turbot
category: ["public cloud"]
icon_url: "/images/plugins/turbot/gcp.svg"
brand_color: "#FF9900" # TODO: verify the brand_color
display_name: "Check If GCP Network Load Balancers Enforce HTTPS to Manage Encrypted Web Traffic"
short_name: "check_https_enforced_for_load_balancers"
description: "Detect if GCP Network load balancers enforce HTTPS to handle encrypted web traffic."
mod_dependencies:
  - "@turbot/gcp"
  - "@turbot/gcp-iam"
  - "@turbot/gcp-network"
---

# Check If GCP Network Load Balancers Enforce HTTPS to Manage Encrypted Web Traffic

This policy-pack checks that load balancers enforce HTTPS to handle encrypted web traffic, using Terraform. It automates the creation and setup of necessary Guardrails policies, allowing Guardrails to automatically detect if HTTPS is enforced on load balancers to handle encrypted web traffic.

## Documentation

- **[Policy pack definitions & examples →](#)**

## Get started

### Install

Clone the repo locally:

```sh
git clone https://github.com/turbot/guardrails-samples.git
cd guardrails-samples/policy_packs/gcp/network/check_https_enforced_for_load_balancers
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
- Select the "MANAGE" link and `+ Add` the `Check If GCP Network Load Balancers Enforce HTTPS to Manage Encrypted Web Traffic` Policy Pack from the dropdown menu.
- Select "Save".

> [!IMPORTANT]
> Do not add or remove more than one Policy Pack to a resource at a time. Adding Policy Packs is an asynchronous operation, after changing the Policy Pack configuration for a resource, wait at least 5 minutes before adding or removing other Policy Packs.

### Verify state (OK, Alarm, Error) of associated controls

Within the Guardrails UI navigate to:

  ```sh
  {workspace-url}/apollo/controls/explore?filter=controlTypeId%3A%27tmod%3A%40turbot%2Faws-s3%23%2Fcontrol%2Ftypes%2FbucketPolicyTrustedAccess%27
  ```

  Replace `{workspace-url}` with the FQDN of your workspace (e.g. <https://company.cloud.turbot.com>). Use the "Resource" filter to select the test account where the Policy Pack is attached. Review all controls in `Alarm` state to understand why they are violating this policy pack objective.

### Resolve the alarms

For each control type, choose to [resolve the alarms](https://turbot.com/guardrails/docs/guides/quick-actions), [create resource exceptions](https://turbot.com/guardrails/docs/getting-started/activity-exceptions#manual-policy-exceptions) or to apply enforcement settings. The default setting for all controls are set to `Check: ...`. Each policy with an enforcement option will have a corresponding enforcement setting that is commented out. These can easily be found by searching across the `*.tf` files for `Enforce:`. For this policy pack we only have the `Check` mode.

  ```hcl
    resource "turbot_policy_setting" "gcp_network_url_map_approved" {
      resource = turbot_smart_folder.pack.id
      type     = "tmod:@turbot/gcp-network#/policy/types/urlMapApproved"
      # value    = "Check: Approved"
    }
  ```

  Then re-apply the Terraform stack:

```sh
terraform plan
terraform apply
```

> [!CAUTION]
> Enforcement controls have the ability delete data, remove permissions and change configuration of your cloud resources. Guardrails automation is very fast and there is no undo; if you do not fully understand the scope of an enforcement or the potential impact to your applications then do not implement enforcement options.