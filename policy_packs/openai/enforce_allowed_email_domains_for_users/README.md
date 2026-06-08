---
categories: ["ai", "access management"]
primary_category: "ai"
---

# Enforce Allowed Email Domains for OpenAI Users

Membership in your OpenAI organization should be limited to people on your corporate identity. Restricting [organization users](https://platform.openai.com/docs/api-reference/users) to an allowlist of email-address domains keeps personal or partner accounts out of the organization, supports offboarding, and gives you a clear, auditable boundary for who can access your AI workloads.

The `Allowed > Email Domain` control evaluates the domain of each user's email address against an allowlist using `micromatch`, so wildcard patterns such as `*.acme.com` are supported. Owner-role users are alarm-only and are never deleted. With enforcement enabled, the control deletes disallowed non-owner users.

This [policy pack](https://turbot.com/guardrails/docs/concepts/policy-packs) can help you configure the following settings for OpenAI:

- Check or enforce that OpenAI organization users belong to an allowed email domain
- Specify the list of allowed email-address domain patterns

**[Review policy settings →](https://hub.guardrails.turbot.com/policy-packs/openai_enforce_allowed_email_domains_for_users/settings)**

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
cd guardrails-samples/policy_packs/openai/enforce_allowed_email_domains_for_users
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
resource "turbot_policy_setting" "openai_user_allowed_email_domain" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/openai#/policy/types/userAllowedEmailDomain"
  # value    = "Check: Allowed"
  value    = "Enforce: Delete if domain not allowed"
}
```

Then re-apply the changes:

```sh
terraform plan
terraform apply
```
