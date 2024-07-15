---
categories: ["security"]
---

# Enforce GCP Storage Buckets Are Not Publicly Accessible

Cloud Storage buckets, like other GCP resources, have Cloud Identity and Access Management (IAM) policies configured to determine who can have access to the storage resources. To deny access from anonymous and public users, remove the bindings for "allUsers" and "allAuthenticatedUsers" members from the storage bucket's IAM policy. The "allUsers" is a special member identifier that represents any user on the Internet, including authenticated and unauthenticated users, while the "allAuthenticatedUsers" is an identifier that represents any user or service account that can sign in to Google Cloud Platform (GCP) with a Google account.

This [policy pack](https://turbot.com/guardrails/docs/concepts/resources/smart-folders) can help you configure the following settings for storage buckets:

- Remove access for non-trusted members
- Do not allow `allUsers` access to buckets
- Do not allow `allAuthenticatedUsers` access to buckets

**[Review policy settings →](https://hub-guardrails-turbot-com-git-development-turbot.vercel.app/policy-packs/enforce_buckets_are_not_publicly_accessible/settings)**

## Getting Started

### Requirements

- [Terraform](https://developer.hashicorp.com/terraform/tutorials/gcp-get-started/install-cli)
- Guardrails mods:
  - [@turbot/gcp-storage](https://hub-guardrails-turbot-com-git-development-turbot.vercel.app/gcp/mods/gcp-storage)

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
cd guardrails-samples/policy_packs/gcp/storage/enforce_buckets_are_not_publicly_accessible
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
resource "turbot_policy_setting" "gcp_storage_bucket_policy_trusted_access" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/gcp-storage#/policy/types/bucketPolicyTrustedAccess"
  # value    = "Check: Trusted Access > *"
  value    = "Enforce: Trusted Access > *"
}
```

Then re-apply the changes:

```sh
terraform plan
terraform apply
```
