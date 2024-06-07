---
organization: Turbot
category: ["public cloud"]
icon_url: "/images/plugins/turbot/gcp.svg"
brand_color: "#FF9900" # TODO: verify the brand_color
display_name: "Check if the creation of the default VPC network is disabled at the GCP organization level"
short_name: "check_default_vpc_creation_disabled_at_org_level"
description: "Ensure that the creation of the default VPC network is disabled at the GCP organization level."
mod_dependencies:
  - "@turbot/gcp"
  - "@turbot/gcp-iam"
  - "@turbot/gcp-orgpolicy"
---

# Check if the creation of the default VPC network is disabled at the GCP organization level

This Policy Pack checks if the GCP Organization Policy "Skip default network creation" is disabled at the GCP organization level, using Terraform. It automates the creation and setup of necessary Guardrails policies which will allow Guardrails to automatically detect if the setting is disabled.

## Documentation

- **[Policy pack definitions & examples →](#)**

## Get started

### Install

Clone the repo locally:

```sh
git clone https://github.com/turbot/guardrails-samples.git
cd guardrails-samples/policy_packs/gcp/computeengine/check_default_vpc_creation_disabled_at_org_level
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
- Select the "MANAGE" link and `+ Add` the `Check if the creation of the default VPC network is disabled at the GCP organization level` Policy Pack from the dropdown menu.
- Select "Save".

> [!IMPORTANT]
> Do not add or remove more than one Policy Pack to a resource at a time. Adding Policy Packs is an asynchronous operation, after changing the Policy Pack configuration for a resource, wait at least 5 minutes before adding or removing other Policy Packs.

### Verify state (OK, Alarm, Error) of associated controls

Within the Guardrails UI navigate to:

  ```sh
  {workspace-url}/apollo/controls/explore?filter=controlTypeId%3A%27tmod%3A%40turbot%2Fgcp-orgpolicy%23%2Fcontrol%2Ftypes%2FcomputeSkipDefaultNetworkCreation%27
  ```

  Replace `{workspace-url}` with the FQDN of your workspace (e.g. <https://company.cloud.turbot.com>). Use the "Resource" filter to select the test account where the Policy Pack is attached. Review all controls in `Alarm` state to understand why they are violating this policy pack objective.
