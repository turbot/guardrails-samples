---
categories: ["security"]
---

# Enforce Encryption at Rest Is Enabled for AWS S3 Buckets

Enforcing encryption at rest for AWS S3 buckets is crucial to safeguard sensitive data stored in the cloud. This ensures that all data within S3 buckets is encrypted, protecting it from unauthorized access and potential breaches, and ensuring compliance with security best practices and regulatory requirements.

This policy pack can help you configure the following settings for S3 buckets:

- Enforce Encryption at Rest, to safeguard sensitive data in buckets
- Set the Customer Managed Key to be used to encrypt data in buckets

## Documentation

- **[Review Policy settings →](https://hub-guardrails-turbot-com-git-development-turbot.vercel.app/policy-packs/enforce_encryption_at_rest_is_enabled_for_buckets/settings)**

## Getting Started

### Requirements

- [Terraform](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)
- Guardrails mods:
  - [@turbot/aws-s3](https://hub-guardrails-turbot-com-git-development-turbot.vercel.app/aws/mods/aws-s3)

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
cd guardrails-samples/policy_packs/aws/s3/enforce_encryption_at_rest_is_enabled_for_buckets
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
resource "turbot_policy_setting" "aws_s3_bucket_encryption_at_rest" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/aws-s3#/policy/types/bucketEncryptionAtRest"
  # value    = "Check: AWS managed key or higher"
  value    = "Enforce: AWS managed key"
  # value    = "Enforce: Encryption at Rest > Customer Managed Key"
}
```

Then re-apply the changes:

```sh
terraform plan
terraform apply
```
