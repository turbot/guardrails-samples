---
categories: ["ai", "security", "data protection"]
primary_category: "ai"
---

# Enforce Encryption at Rest for GCP Vertex AI Deployment Resource Pools

[GCP Vertex AI deployment resource pools](https://cloud.google.com/vertex-ai/docs/predictions/use-deployment-resource-pools) let you share dedicated compute resources across multiple deployed models. Encrypting the data on these pools at rest, especially with a customer managed encryption key (CMEK), gives you control over the key lifecycle and helps satisfy security, compliance, and data residency requirements.

This [policy pack](https://turbot.com/guardrails/docs/concepts/policy-packs) can help you configure the following settings for GCP Vertex AI deployment resource pools:

- Check or enforce that deployment resource pools use an allowed encryption at rest level
- Specify the required encryption level (Google managed key or customer managed key)
- Optionally pin encryption to a specific customer managed key (CMEK)

**[Review policy settings →](https://hub.guardrails.turbot.com/policy-packs/gcp_vertexai_enforce_encryption_at_rest_for_deployment_resource_pools/settings)**

## Getting Started

### Requirements

- [Terraform](https://developer.hashicorp.com/terraform/install)
- Guardrails mods:
  - [@turbot/gcp-vertexai](https://hub.guardrails.turbot.com/mods/gcp/mods/gcp-vertexai)

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
cd guardrails-samples/policy_packs/gcp/vertexai/enforce_encryption_at_rest_for_deployment_resource_pools
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
resource "turbot_policy_setting" "gcp_vertexai_deployment_resource_pool_allowed_encryption_at_rest" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/gcp-vertexai#/policy/types/deploymentResourcePoolAllowedEncryptionAtRest"
  # value    = "Check: Allowed encryption level"
  value    = "Enforce: Delete if encryption level not allowed and resource is new"
}
```

Then re-apply the changes:

```sh
terraform plan
terraform apply
```
