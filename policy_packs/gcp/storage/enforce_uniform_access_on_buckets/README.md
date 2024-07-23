---
categories: ["data protection", "security", "storage"]
primary_category: "data protection"
---

# Enforce Uniform Access is Enabled for GCP Storage Buckets

Enforcing Uniform Access for GCP Storage Buckets is crucial to ensure consistent and centralized management of access permissions, reducing the risk of unauthorized access and potential data breaches. This control helps streamline the administration of security policies, ensuring all objects within a bucket inherit the same access controls, thus maintaining data integrity and security.

This [policy pack](https://turbot.com/guardrails/docs/concepts/resources/policy-packs) can help you configure the following settings for Storage buckets:

- Set uniform access

**[Review policy settings →](https://hub.guardrails.turbot.com/policy-packs/gcp_storage_enforce_uniform_access_on_buckets/settings)**

## Getting Started

### Requirements

- [Terraform](https://developer.hashicorp.com/terraform/install)
- Guardrails mods:
  - [@turbot/gcp-storage](https://hub.guardrails.turbot.com/mods/gcp/mods/gcp-storage)

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
cd guardrails-samples/policy_packs/gcp/storage/enforce_uniform_access_on_buckets
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

For more information, please see [Policy Packs](https://turbot.com/guardrails/docs/concepts/resources/policy-packs).

### Enable Enforcement

> [!TIP]
> You can also update the policy settings in this policy pack directly in the Guardrails console.
>
> Please note your Terraform state file will then become out of sync and the policy settings should then only be managed in the console.

By default, the policies are set to `Check` in the pack's policy settings. To enable automated enforcements, you can switch these policies settings by adding a comment to the `Check` setting and removing the comment from one of the listed enforcement options:

```hcl
resource "turbot_policy_setting" "gcp_storage_bucket_access_control" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/gcp-storage#/policy/types/bucketAccessControl"
  # value    = "Check: Uniform"
  value    = "Enforce: Uniform"
}
```

Then re-apply the changes:

```sh
terraform plan
terraform apply
```
