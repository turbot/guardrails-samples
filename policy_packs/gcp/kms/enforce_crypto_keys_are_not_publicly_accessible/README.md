---
categories: ["security"]
---

# Enforce GCP KMS Crypto Keys Are Not Publicly Accessible

Enforcing that GCP KMS crypto keys are not publicly accessible is vital for protecting sensitive data from unauthorized access. This ensures that cryptographic keys, which are essential for data encryption and security, are only accessible to authorized users and services, thereby preventing potential data breaches and maintaining compliance with security best practices and regulatory standards.

This policy pack can help you configure the following settings for KMS crypto keys:

- Remove access for non-trusted members
- Do not allow `allUsers` access to crypto keys
- Do not allow `allAuthenticatedUsers` access to crypto keys

**[Review policy settings →](https://hub-guardrails-turbot-com-git-development-turbot.vercel.app/policy-packs/enforce_imdsv2_for_instances/settings)**

## Getting Started

### Requirements

- [Terraform](https://developer.hashicorp.com/terraform/tutorials/gcp-get-started/install-cli)
- Guardrails mods:
  - [@turbot/gcp-kms](https://hub-guardrails-turbot-com-git-development-turbot.vercel.app/gcp/mods/gcp-kms)

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
cd guardrails-samples/policy_packs/gcp/kms/enforce_crypto_keys_are_not_publicly_accessible
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
resource "turbot_policy_setting" "gcp_kms_crypto_key_policy_trusted_access" {
  resource = turbot_smart_folder.main.id
  type     = "tmod:@turbot/gcp-kms#/policy/types/cryptoKeyPolicyTrustedAccess"
  # value    = "Check: Trusted Access > *"
  value    = "Enforce: Trusted Access > *"
}
```

Then re-apply the changes:

```sh
terraform plan
terraform apply
```
