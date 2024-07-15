---
categories: ["cis"]
---

# Azure CIS v2.0.0 - Section 5 - Logging and Monitoring

This section contains recommendations for configuring Azure logging and monitoring features.

This policy pack can help you automate enforcement of Azure CIS benchmark section 5 best practices.

**[Review policy settings →](https://hub-guardrails-turbot-com-git-development-turbot.vercel.app/policy-packs/azure/cis_v200/section5/settings)**

## Getting Started

### Requirements

- [Terraform](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)
- Guardrails mods:
  - [@turbot/azure-monitor](https://hub-guardrails-turbot-com-git-development-turbot.vercel.app/azure/mods/azure-monitor)
  - [@turbot/azure-storage](https://hub-guardrails-turbot-com-git-development-turbot.vercel.app/azure/mods/azure-storage)
  - [@turbot/azure](https://hub-guardrails-turbot-com-git-development-turbot.vercel.app/azure/mods/azure)

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
cd guardrails-samples/policy_packs/azure/cis_v200/section5
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
resource "turbot_policy_setting" "azure_storage_container_public_access_level" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/azure-storage#/policy/types/containerPublicAccessLevel"
  note     = "Azure CIS v2.0.0 - Control: 5.1.3"
  # value    = "Check: Private (No anonymous access)"
  value    = "Enforce: Private (No anonymous access)"
}

resource "turbot_policy_setting" "azure_networkwatcher_flowlog_approved" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/azure-storage#/policy/types/flowLogApproved"
  note     = "Azure CIS v2.0.0 - Control: 5.1.6"
  # value    = "Check: Approved"
  value    = "Enforce: Delete unapproved if new"
}

resource "turbot_policy_setting" "azure_monitor_stack" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/azure-monitor#/policy/types/monitorStack"
  note     = "Azure CIS v2.0.0 - Controls:  5.2.1, 5.2.2, 5.2.3, 5.2.4, 5.2.5, 5.2.6, 5.2.7, 5.2.8, 5.2.9 and 5.2.10"
  # value    = "Check: Configured"
  value    = "Enforce: Configured"
}

resource "turbot_policy_setting" "azure_resource_group_stack" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/azure#/policy/types/resourceGroupStack"
  note     = "Azure CIS v2.0.0 - Controls: 5.3.1"
  # value    = "Check: Configured"
  value    = "Enforce: Configured"
}
```

Then re-apply the changes:

```sh
terraform plan
terraform apply
```
