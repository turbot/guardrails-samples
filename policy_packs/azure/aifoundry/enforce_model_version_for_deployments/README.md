---
categories: ["ai", "security"]
primary_category: "ai"
---

# Enforce Approved Model Version for Azure AI Foundry Deployments

Azure AI Foundry deployments reference a specific model version, and Azure can auto-upgrade versions over time. Pinning deployments to an approved model version ensures workloads run on a known, tested version, which avoids unexpected behavior changes and keeps results reproducible.

This [policy pack](https://turbot.com/guardrails/docs/concepts/policy-packs) can help you configure the following settings for Azure AI Foundry deployments:

- Check or enforce that deployments use an approved model version
- Specify the required model version

**[Review policy settings →](https://hub.guardrails.turbot.com/policy-packs/azure_aifoundry_enforce_model_version_for_deployments/settings)**

## Getting Started

### Requirements

- [Terraform](https://developer.hashicorp.com/terraform/install)
- Guardrails mods:
  - [@turbot/azure-aifoundry](https://hub.guardrails.turbot.com/mods/azure/mods/azure-aifoundry)

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
cd guardrails-samples/policy_packs/azure/aifoundry/enforce_model_version_for_deployments
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
resource "turbot_policy_setting" "azure_aifoundry_deployment_model_version" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/azure-aifoundry#/policy/types/deploymentModelVersion"
  # value    = "Check: per `Model Version > Required Version`"
  value    = "Enforce: per `Model Version > Required Version`"
}
```

Then re-apply the changes:

```sh
terraform plan
terraform apply
```
