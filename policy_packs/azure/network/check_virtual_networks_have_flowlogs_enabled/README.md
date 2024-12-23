---
categories: ["logging", "networking"]
primary_category: "networking"
type: "featured"
---

# Check Azure Virtual Networks Have Flow Logs Enabled

Ensure that Azure Virtual Networks have flow logs configured and enabled to monitor and analyze network traffic. Flow logs capture information about IP traffic flowing in and out of network interfaces in the virtual network. This helps detect anomalies, troubleshoot issues, and maintain compliance with security best practices and regulatory requirements.

This [policy pack](https://turbot.com/guardrails/docs/concepts/policy-packs) can help you configure the following settings for network security groups:

- Check if flow logs are configured for Azure Virtual Networks
- Validate that flow logging status is enabled

**[Review policy settings →](https://hub.guardrails.turbot.com/policy-packs/azure_network_check_virtual_networks_have_flowlog_enabled/settings)**

## Getting Started

### Requirements

- [Terraform](https://developer.hashicorp.com/terraform/install)
- Guardrails mods:
  - [@turbot/azure-network](https://hub.guardrails.turbot.com/mods/azure/mods/azure-network)
  - [@turbot/azure-networkwatcher](https://hub.guardrails.turbot.com/mods/azure/mods/azure-networkwatcher)

### Credentials

To create a policy pack through Terraform:

- Ensure you have `Turbot/Admin` permissions (or higher) in Guardrails
- [Create access keys](https://turbot.com/guardrails/docs/guides/iam/access-keys#generate-a-new-guardrails-api-access-key) in Guardrails

And then set your credentials:

```sh
export TURBOT_WORKSPACE=myworkspace.acme.com
export TURBOT_ACCESS_KEY=acce6ac5-access-key-here
export TURBOT_SECRET_KEY=a8af61ec-secret-key-here
```

Please see [Turbot Guardrails Provider authentication](https://registry.terraform.io/providers/turbot/turbot/latest/docs#authentication) for additional authentication methods.

## Usage

### Install Policy Pack

> [!NOTE]
> By default, installed policy packs are not attached to any resources.
>
> Policy packs must be attached to resources in order for their policy settings to take effect.

Clone:

```sh
git clone https://github.com/turbot/guardrails-samples.git
cd guardrails-samples/policy_packs/azure/network/check_virtual_networks_have_flowlog_enabled
```

Run the Terraform to create the policy pack in your workspace:

```sh
terraform init
terraform plan
```

Then apply the changes:

```sh
terraform apply
```

### Apply Policy Pack

Log into your Guardrails workspace and [attach the policy pack to a resource](https://turbot.com/guardrails/docs/guides/policy-packs#attach-a-policy-pack-to-a-resource).

If this policy pack is attached to a Guardrails folder, its policies will be applied to all accounts and resources in that folder. The policy pack can also be attached to multiple resources.

For more information, please see [Policy Packs](https://turbot.com/guardrails/docs/concepts/policy-packs).
