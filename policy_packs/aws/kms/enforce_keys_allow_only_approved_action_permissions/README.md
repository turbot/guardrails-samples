---
categories: ["access management", "security"]
primary_category: "security"
---

# Enforce AWS KMS Keys Allow Only Approved Action Permissions

Enforcing that AWS KMS keys do not allow unapproved action permissions is crucial for maintaining the security and integrity of encrypted data. This measure ensures that only authorized actions can be performed on KMS keys, reducing the risk of unauthorized access and misuse, thereby enhancing overall security and compliance with best practices and regulatory requirements.

This [policy pack](https://turbot.com/guardrails/docs/concepts/policy-packs) can help you configure the following settings for KMS keys:

- Revoke policy statements which allow below KMS actions:
  - Access via Lambda service
  - Access via Secrets Manager service
  - ConnectCustomKeyStore
  - CreateCustomKeyStore
  - Decrypt
  - DeleteCustomKeyStore
  - Describe\*
  - DescribeCustomKeyStores
  - DisableKeyRotation
  - DisconnectCustomKeyStore
  - Encrypt
  - Get\*
  - GetPublicKey (if asymmetric key)
  - List\*
  - Sign (if asymmetric key)
  - UpdateCustomKeyStore
  - Verify (if asymmetric key)

## Documentation

- **[Review Policy settings →](https://hub.guardrails.turbot.com/policy-packs/aws_kms_enforce_keys_allow_only_approved_action_permissions/settings)**

## Getting Started

### Requirements

- [Terraform](https://developer.hashicorp.com/terraform/install)
- Guardrails mods:
  - [@turbot/aws-kms](https://hub.guardrails.turbot.com/mods/aws/mods/aws-kms)

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
cd guardrails-samples/policy_packs/aws/kms/enforce_keys_allow_only_approved_action_permissions
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

For more information, please see [Policy Packs](https://turbot.com/guardrails/docs/concepts/policy-packs).

### Enable Enforcement

> [!TIP]
> You can also update the policy settings in this policy pack directly in the Guardrails console.
>
> Please note your Terraform state file will then become out of sync and the policy settings should then only be managed in the console.

By default, the policies are set to `Check` in the pack's policy settings. To enable automated enforcements, you can switch these policies settings by adding a comment to the `Check` setting and removing the comment from one of the listed enforcement options:

```hcl
resource "turbot_policy_setting" "aws_kms_key_policy_statements_approved" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/aws-kms#/policy/types/keyPolicyStatementsApproved"
  # value    = "Check: Approved"
  value    = "Enforce: Delete unapproved"
}
```

Then re-apply the changes:

```sh
terraform plan
terraform apply
```
