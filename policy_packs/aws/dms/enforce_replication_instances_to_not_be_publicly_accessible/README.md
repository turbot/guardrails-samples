---
categories: ["Security"]
---

# Enforce AWS DMS Replication Instances to Restrict Public Access

Enforcing AWS DMS Replication Instances to restrict public access is crucial to protect sensitive data during migration processes. This measure minimizes the risk of unauthorized access, potential data breaches, and ensures compliance with security best practices and regulatory requirements.

This [policy pack](https://turbot.com/guardrails/docs/concepts/resources/smart-folders) can help you configure the following settings for DMS replication instances:

- Stop/Terminate replication instances which have public access enabled

**[Review policy settings →](https://hub-guardrails-turbot-com-git-development-turbot.vercel.app/policy-packs/enforce_replication_instances_to_not_be_publicly_accessible/settings)**

## Getting Started

### Requirements

- [Terraform](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)
- The following Guardrails mods need to be installed:
  - [@turbot/aws-dms](https://hub-guardrails-turbot-com-git-development-turbot.vercel.app/aws/mods/aws-dms)

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
cd guardrails-samples/policy_packs/aws/dms/enforce_replication_instances_to_not_be_publicly_accessible
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
resource "turbot_policy_setting" "aws_dms_replication_instance_approved" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/aws-dms#/policy/types/replicationInstanceApproved"
  # value    = "Check: Approved"
  value    = "Enforce: Stop unapproved"
  # value    = "Enforce: Stop unapproved if new"
  # value    = "Enforce: Delete unapproved if new"
}
```

Then re-apply the changes:

```sh
terraform plan
terraform apply
```
