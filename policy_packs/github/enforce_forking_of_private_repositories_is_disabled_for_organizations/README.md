---
categories: ["security"]
primary_category: "security"
---

# Enforce Forking of Private Repositories is Disabled for GitHub Organizations

Enforcing that member privileges forking of private repositories is disabled for GitHub organizations is essential to prevent unauthorized duplication of sensitive code. This measure enhances security by restricting the distribution of proprietary or confidential information outside the organization.

This [policy pack](https://turbot.com/guardrails/docs/concepts/policy-packs) can help you configure the following settings for GitHub organizations:

- Disable forking of private repositories

## Documentation

- **[Review policy settings →](https://hub.guardrails.turbot.com/policy-packs/github_enforce_forking_of_private_repositories_is_disabled_for_organizations/settings)**

## Getting Started

### Requirements

- [Terraform](https://developer.hashicorp.com/terraform/install)
- Guardrails mods:
  - [@turbot/github](https://hub.guardrails.turbot.com/mods/github/mods/github)

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
cd guardrails-samples/policy_packs/github/enforce_forking_of_private_repositories_is_disabled_for_organizations
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
resource "turbot_policy_setting" "github_organization_member_privileges_repository_forking" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/github#/policy/types/organizationMemberPrivilegesRepositoryForking"
  # value    = "Check: Deny forking of private repositories"
  value    = "Enforce: Deny forking of private repositories"
}
```

Then re-apply the changes:

```sh
terraform plan
terraform apply
```
