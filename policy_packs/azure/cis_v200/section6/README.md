---
categories: ["cis"]
---

# Enforce Azure CIS v2.0.0 - Section 6 - Networking

This section covers security recommendations to follow in order to set networking policies on an Azure subscription.

This policy pack can help you automate enforcement of Azure CIS benchmark section 6 best practices.

**[Review policy settings →](https://hub-guardrails-turbot-com-git-development-turbot.vercel.app/policy-packs/azure/cis_v200/section6/settings)**

## Getting Started

### Requirements

- [Terraform](https://developer.hashicorp.com/terraform/tutorials/azure-get-started/install-cli)
- Guardrails mods:
  - [@turbot/azure-network](https://hub-guardrails-turbot-com-git-development-turbot.vercel.app/azure/mods/azure-network)
  - [@turbot/azure-networkwatcher](https://hub-guardrails-turbot-com-git-development-turbot.vercel.app/azure/mods/azure-networkwatcher)

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
cd guardrails-samples/policy_packs/azure/cis_v200/section6
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
resource "turbot_policy_setting" "azure_network_network_security_group_ingress_rules_approved" {
  resource = turbot_smart_folder.pack.id
  type     = "tmod:@turbot/azure-network#/policy/types/networkSecurityGroupIngressRulesApproved"
  note     = "Azure CIS v2.0.0 - Controls: 6.1, 6.2, 6.3, 6.4"
  # value    = "Check: Approved"
  value    = "Enforce: Delete unapproved"
}

resource "turbot_policy_setting" "azure_network_watcher_approved" {
  resource = turbot_smart_folder.pack.id
  type     = "tmod:@turbot/azure-networkwatcher#/policy/types/networkWatcherApproved"
  note     = "Azure CIS v2.0.0 - Controls: 6.6"
  # value    = "Check: Approved"
  value    = "Enforce: Delete unapproved if new"
}
```

Then re-apply the changes:

```sh
terraform plan
terraform apply
```
