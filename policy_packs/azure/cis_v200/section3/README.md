---
categories: ["cis"]
---

# Azure CIS v2.0.0 - Section 3 - Storage Accounts

This section covers security recommendations to follow to set storage account policies on an Azure Subscription. An Azure storage account provides a unique namespace to store and access Azure Storage data objects.

This [policy pack](https://turbot.com/guardrails/docs/concepts/resources/smart-folders) can help you automate the enforcement of Azure CIS benchmark section 3 best practices.

**[Review policy settings →](https://hub-guardrails-turbot-com-git-development-turbot.vercel.app/policy-packs/azure/cis_v200/section3/settings)**

## Getting Started

### Requirements

- [Terraform](https://developer.hashicorp.com/terraform/tutorials/azure-get-started/install-cli)
- Guardrails mods:
  - [@turbot/azure-storage](https://hub-guardrails-turbot-com-git-development-turbot.vercel.app/azure/mods/azure-storage)

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
cd guardrails-samples/policy_packs/azure/cis_v200/section3
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

If this policy pack is attached to a Guardrails folder, its policies will be applied to all accounts and resources in that folder. The policy pack can also be attached to multiple resources.

For more information, please see [Policy Packs](https://turbot.com/guardrails/docs/concepts/resources/smart-folders).

### Enable Enforcement

> [!TIP]
> You can also update the policy settings in this policy pack directly in the Guardrails console.
>
> Please note your Terraform state file will then become out of sync and the policy settings should then only be managed in the console.

By default, the policies are set to `Check` in the pack's policy settings. To enable automated enforcements, you can switch these policies settings by adding a comment to the `Check` setting and removing the comment from one of the listed enforcement options:

```hcl
resource "turbot_policy_setting" "azure_storage_account_encryption_in_transit" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/azure-storage#/policy/types/storageAccountEncryptionInTransit"
  note     = "Azure CIS v2.0.0 - Control: 3.1"
  # value    = "Check: Enabled"
  value    = "Enforce: Enabled"
}

resource "turbot_policy_setting" "azure_storage_account_approved" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/azure-storage#/policy/types/storageAccountApproved"
  note     = "Azure CIS v2.0.0 - Control: 3.2"
  # value    = "Check: Approved"
  value    = "Enforce: Delete unapproved if new"
}

resource "turbot_policy_setting" "azure_storage_account_access_keys_rotation_reminder" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/azure-storage#/policy/types/storageAccountAccessKeysRotationReminder"
  note     = "Azure CIS v2.0.0 - Control: 3.3"
  # value    = "Check: Enabled per Rotation Reminder > Days"
  value    = "Enforce: Enabled per Rotation Reminder > Days"
}

resource "turbot_policy_setting" "azure_storage_account_queue_service_logging" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/azure-storage#/policy/types/queueServiceLogging"
  note     = "Azure CIS v2.0.0 - Control: 3.5"
  # value    = "Check: Per Logging > Properties"
  value    = "Enforce: Per Logging > Properties"
}

resource "turbot_policy_setting" "azure_storage_storage_account_blob_public_access" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/azure-storage#/policy/types/storageAccountPublicAccess"
  note     = "Azure CIS v2.0.0 - Control: 3.7"
  value    = "Check: Enabled"
  # value    = "Enforce: Enabled"
}

resource "turbot_policy_setting" "azure_storage_account_data_protection_soft_delete" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/azure-storage#/policy/types/storageAccountDataProtectionSoftDelete"
  note     = "Azure CIS v2.0.0 - Control: 3.11"
  # value    = "Check: Configured per Soft Delete > * policies"
  value    = "Enforce: Configured per Soft Delete > * policies"
}

resource "turbot_policy_setting" "azure_storage_storage_account_blob_logging" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/azure-storage#/policy/types/storageAccountBlobLogging"
  note     = "Azure CIS v2.0.0 - Control: 3.13"
  # value    = "Check: Per `Logging > *`"
  value    = "Enforce: Per `Logging > *`"
}

resource "turbot_policy_setting" "azure_storage_account_minimum_tls_version" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/azure-storage#/policy/types/storageAccountMinimumTlsVersion"
  note     = "Azure CIS v2.0.0 - Control: 3.15"
  # value    = "Check: TLS 1.2"
  value    = "Enforce: TLS 1.2"
}
```

Then re-apply the changes:

```sh
terraform plan
terraform apply
```
