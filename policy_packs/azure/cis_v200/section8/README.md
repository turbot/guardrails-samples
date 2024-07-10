---
categories: ["cis"]
---

# Azure CIS v2.0.0 - Section 8 - Key Vault

This section covers security recommendations to follow for the configuration and use of Azure Key Vault.

This policy pack can help you automate enforcement of Azure CIS benchmark section 8 best practices.

**[Review policy settings →](https://hub-guardrails-turbot-com-git-development-turbot.vercel.app/policy-packs/azure/cis_v200/section8/settings)**

## Getting Started

### Requirements

- [Terraform](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)
- Guardrails mods:
  - [@turbot/azure-keyvault](https://hub-guardrails-turbot-com-git-development-turbot.vercel.app/azure/mods/azure-keyvault)

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
cd guardrails-samples/policy_packs/azure/cis_v200/section8
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

Log into your Guardrails workspace and [attach the policy pack to a resource](https://turbot.com/guardrails/docs/guides/working-with-folders/smart#attach-a-smart-folder-to-a-resource).

### Enable Enforcement

> [!TIP]
> You can also update the policy settings in this policy pack directly in the Guardrails console.
>
> Please note your Terraform state file will then become out of sync and the policy settings should then only be managed in the console.

By default, the policies are set to `Check` in the pack's policy settings. To enable automated enforcements, you can switch these policies settings by adding a comment to the `Check` setting and removing the comment from one of the listed enforcement options:

```hcl
resource "turbot_policy_setting" "azure_keyvault_vault_approved" {
  resource = turbot_smart_folder.main.id
  type     = "tmod:@turbot/azure-keyvault#/policy/types/vaultApproved"
  note     = "Azure CIS v2.0.0 - Control: 8.6 and 8.7"
  # value  = "Check: Approved"
  value    = "Enforce: Delete unapproved if new"
}

resource "turbot_policy_setting" "azure_keyvault_key_expiration" {
  resource = turbot_smart_folder.main.id
  type     = "tmod:@turbot/azure-keyvault#/policy/types/keyExpiration"
  note     = "Azure CIS v2.0.0 - Control: 8.1 and 8.2"
  # value  = "Check: Expiration"
  value    = "Enforce: Expiration"
}

resource "turbot_policy_setting" "azure_keyvault_secret_expiration" {
  resource = turbot_smart_folder.main.id
  type     = "tmod:@turbot/azure-keyvault#/policy/types/secretExpiration"
  note     = "Azure CIS v2.0.0 - Control: 8.3 and 8.4"
  # value  = "Check: Expiration"
  value    = "Enforce: Expiration"
}

resource "turbot_policy_setting" "azure_keyvault_vault_purge_protection" {
  resource = turbot_smart_folder.main.id
  type     = "tmod:@turbot/azure-keyvault#/policy/types/vaultPurgeProtection"
  note     = "Azure CIS v2.0.0 - Control: 8.5"
  # value  = "Check: Purge Protection Enabled"
  value    = "Enforce: Enable Purge Protection"
}
```

Then re-apply the changes:

```sh
terraform plan
terraform apply
```
