---
categories: ["ai", "security", "networking"]
primary_category: "ai"
---

# Enforce Public Network Access Is Disabled for Azure Bot Service Bots

Azure Bot Service bots can accept connections over the public internet by default. Disabling public network access ensures the bot is only reachable through private endpoints, which is the recommended posture for production conversational AI workloads and significantly reduces the network attack surface.

This [policy pack](https://turbot.com/guardrails/docs/concepts/policy-packs) can help you configure the following settings for Azure Bot Service bots:

- Check or enforce that public network access is disabled

**[Review policy settings →](https://hub.guardrails.turbot.com/policy-packs/azure_botservice_enforce_public_network_access_disabled_for_bots/settings)**

## Getting Started

### Requirements

- [Terraform](https://developer.hashicorp.com/terraform/install)
- Guardrails mods:
  - [@turbot/azure-botservice](https://hub.guardrails.turbot.com/mods/azure/mods/azure-botservice)

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
cd guardrails-samples/policy_packs/azure/botservice/enforce_public_network_access_disabled_for_bots
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

### Enable Enforcement

> [!TIP]
> You can also update the policy settings in this policy pack directly in the Guardrails console.
>
> Please note your Terraform state file will then become out of sync and the policy settings should then only be managed in the console.

By default, the policies are set to `Check` in the pack's policy settings. To enable automated enforcements, you can switch these policies settings by adding a comment to the `Check` setting and removing the comment from one of the listed enforcement options:

```hcl
resource "turbot_policy_setting" "azure_botservice_bot_public_network_access" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/azure-botservice#/policy/types/botPublicNetworkAccess"
  # value    = "Check: Disabled"
  value    = "Enforce: Disabled"
}
```

Then re-apply the changes:

```sh
terraform plan
terraform apply
```
