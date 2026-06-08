---
categories: ["ai", "data protection", "compliance"]
primary_category: "ai"
---

# Enforce Zero Data Retention for OpenAI

[Zero Data Retention (ZDR)](https://platform.openai.com/docs/guides/your-data) and Modified Abuse Monitoring are contractual, Console-only controls that stop OpenAI from retaining your API inputs and outputs. Confirming they are enabled is essential evidence for data protection reviews, privacy commitments, and compliance frameworks that restrict how long prompt and completion data may be stored.

OpenAI exposes no Admin API endpoint to probe ZDR state, so the control reads an operator attestation. Once you have configured ZDR and Modified Abuse Monitoring with OpenAI, an operator sets the attestation to confirm the organization is compliant.

This [policy pack](https://turbot.com/guardrails/docs/concepts/policy-packs) can help you configure the following settings for OpenAI:

- Check that Zero Data Retention and Modified Abuse Monitoring are enabled for the organization
- Capture the operator attestation that confirms the organization is compliant

**[Review policy settings →](https://hub.guardrails.turbot.com/policy-packs/openai_enforce_zero_data_retention/settings)**

## Getting Started

### Requirements

- [Terraform](https://developer.hashicorp.com/terraform/install)
- Guardrails mods:
  - [@turbot/openai](https://hub.guardrails.turbot.com/mods/openai/mods/openai)

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
cd guardrails-samples/policy_packs/openai/enforce_zero_data_retention
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

This control verifies an operator attestation and has no automated enforcement variant. After you have configured Zero Data Retention and Modified Abuse Monitoring with OpenAI, set the attestation to `true` so the control reports compliance:

```hcl
resource "turbot_policy_setting" "openai_organization_zdr_status_attested" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/openai#/policy/types/zdrStatusAttested"
  value    = true
}
```

Then re-apply the changes:

```sh
terraform plan
terraform apply
```
