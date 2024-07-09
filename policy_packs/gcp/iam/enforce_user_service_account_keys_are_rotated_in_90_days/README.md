---
categories: ["public cloud"]
---

# Enforce GCP IAM User-Managed Service Account Keys to Not Have Rotation Period of More Than 90 Days

Inactive user-managed service account keys that have a rotation period of more than 90 days should be deleted.

This policy pack can help you configure the following settings for IAM user-managed service account keys:

- Delete inactive user-managed service account keys with 90 days warning

**[Review policy settings →](https://hub-guardrails-turbot-com-git-development-turbot.vercel.app/policy-packs/enforce_user_service_account_keys_are_rotated_in_90_days/settings)**

## Getting Started

### Requirements

- [Terraform](https://developer.hashicorp.com/terraform/tutorials/gcp-get-started/install-cli)
- Guardrails mods:
  - [@turbot/gcp-iam](https://hub-guardrails-turbot-com-git-development-turbot.vercel.app/gcp/mods/gcp-iam)

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
cd guardrails-samples/policy_packs/gcp/iam/enforce_user_service_account_keys_are_rotated_in_90_days
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
resource "turbot_policy_setting" "gcp_iam_service_account_key_active" {
  resource = turbot_smart_folder.main.id
  type     = "tmod:@turbot/gcp-iam#/policy/types/serviceAccountKeyActive"
  value    = "Check: Active"
  # value    =  "Enforce: Delete inactive with 90 days warning"
}
```

Then re-apply the changes:

```sh
terraform plan
terraform apply
```
