---
categories: ["security"]
primary_category: "security"
---

# Enforce AWS ECR Repositories Are Private

Ensuring that Amazon Elastic Container Registry (ECR) repositories are not publicly accessible is crucial for maintaining the security of your container images. This policy pack enforces that all ECR repositories are private, preventing unauthorized access and potential security risks.

This [policy pack](https://turbot.com/guardrails/docs/concepts/policy-packs) helps you configure the following settings for AWS ECR:

- **Check** if any ECR repositories are publicly accessible.
- **Enforce** that new unapproved public repositories are deleted automatically.

**[Review policy settings →](https://hub.guardrails.turbot.com/policy-packs/aws_ecr_enforce_private_repositories/settings)**

## Getting Started

### Requirements

- [Terraform](https://developer.hashicorp.com/terraform/downloads)
- The following Guardrails mod must be installed:
  - [@turbot/aws-ecr](https://hub.guardrails.turbot.com/mods/aws/mods/aws-ecr)

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
cd guardrails-samples/policy_packs/aws/ecr/enforce_private_repositories
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
resource "turbot_policy_setting" "aws_ecr_public_repository_approved" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/aws-ecr#/policy/types/publicRepositoryApproved"
  # value    = "Check: Approved"
  value    = "Enforce: Delete unapproved if new"
}
```

Then re-apply the changes:

```sh
terraform plan
terraform apply
```
