---
primary_category: ["Cost Controls"]
categories: ["Compute", "Cost Controls"]
---

# Enforce GCP Compute Engine Instances to Not Be Older Than 7 Days

Enforcing GCP Compute Engine Instances to not be older than 7 days is important to ensure that instances are regularly updated and patched, minimizing the risk of vulnerabilities and security exploits. This practice promotes a secure and resilient infrastructure by ensuring that all instances run the latest software versions and configurations.

This [policy pack](https://turbot.com/guardrails/docs/concepts/resources/smart-folders) can help you configure the following settings for Compute Engine instances:

- Delete instances that are older than 7 days

- **[Policy settings →](https://hub-guardrails-turbot-com-git-development-turbot.vercel.app/policy-packs/enforce_instances_to_not_be_older_than_7_days/settings)**

## Getting Started

### Requirements

- [Terraform](https://developer.hashicorp.com/terraform/tutorials/gcp-get-started/install-cli)
- Guardrails mods:
  - [@turbot/gcp-computeengine](https://hub-guardrails-turbot-com-git-development-turbot.vercel.app/gcp/mods/gcp-computeengine)

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
cd guardrails-samples/policy_packs/gcp/computeengine/enforce_instances_to_not_be_older_than_7_days
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
resource "turbot_policy_setting" "gcp_computeengine_instance_active" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/gcp-computeengine#/policy/types/instanceActive"
  # value    = "Check: Active"
  value    = "Enforce: Delete inactive with 7 days warning"
}
```

Then re-apply the changes:

```sh
terraform plan
terraform apply
```
