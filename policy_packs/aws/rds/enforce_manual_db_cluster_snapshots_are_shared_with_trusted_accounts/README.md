---
categories: ["data protection", "security"]
primary_category: "security"
---

# Enforce AWS RDS Manual DB Cluster Snapshots Are Shared With Trusted Accounts

Enforcing that AWS RDS manual DB cluster snapshots are shared only with trusted accounts is vital for maintaining data security and access control. This measure ensures that sensitive data within snapshots is accessible only to authorized accounts, reducing the risk of unauthorized access and data breaches, and ensuring compliance with security best practices and regulatory requirements.

This [policy pack](https://turbot.com/guardrails/docs/concepts/policy-packs) can help you configure the following settings for RDS manual DB cluster snapshots:

- Set trusted accounts
- Revoke untrusted access from snapshots

**[Review policy settings →](https://hub.guardrails.turbot.com/policy-packs/aws_rds_enforce_manual_db_cluster_snapshots_are_shared_with_trusted_accounts/settings)**

## Getting Started

### Requirements

- [Terraform](https://developer.hashicorp.com/terraform/install)
- The following Guardrails mods need to be installed:
  - [@turbot/aws-rds](https://hub.guardrails.turbot.com/mods/aws/mods/aws-rds)

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
cd guardrails-samples/policy_packs/aws/rds/enforce_manual_db_cluster_snapshots_are_shared_with_trusted_accounts
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
resource "turbot_policy_setting" "aws_rds_db_cluster_snapshot_manual_trusted_access" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/aws-rds#/policy/types/dbClusterSnapshotManualTrustedAccess"
  # value    = "Check: Trusted Access > Accounts"
  value    = "Enforce: Trusted Access > Accounts"
}
```

Then re-apply the changes:

```sh
terraform plan
terraform apply
```
