---
categories: ["ai", "security"]
primary_category: "ai"
---

# Enforce Approved Models for OpenAI Projects

OpenAI [projects](https://platform.openai.com/docs/guides/production-best-practices) carry per-model rate-limit entries that determine which models a project can call. Restricting projects to an approved set of models keeps teams on the models you have vetted for cost, capability, and data-handling, and prevents shadow usage of models that have not been reviewed.

The `Approved Models` control walks each project's rate-limit entries and raises an alarm for any entry whose model is not on the approved list. With enforcement enabled, the control zeroes the rate limits on disallowed entries, effectively disabling those models for the project.

This [policy pack](https://turbot.com/guardrails/docs/concepts/policy-packs) can help you configure the following settings for OpenAI:

- Check or enforce that OpenAI projects only use approved models
- Specify the list of OpenAI model ids permitted for use on projects

**[Review policy settings →](https://hub.guardrails.turbot.com/policy-packs/openai_enforce_approved_models_for_projects/settings)**

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
cd guardrails-samples/policy_packs/openai/enforce_approved_models_for_projects
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
resource "turbot_policy_setting" "openai_project_rate_limit_approved_models" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/openai#/policy/types/projectRateLimitApprovedModels"
  # value    = "Check: Approved"
  value    = "Enforce: Set zero-RPM on disallowed models"
}
```

Then re-apply the changes:

```sh
terraform plan
terraform apply
```
