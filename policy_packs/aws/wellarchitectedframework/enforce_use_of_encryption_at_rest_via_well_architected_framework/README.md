---
categories: ["networking", "security"]
primary_category: "security"
---

# Enforce Use of Encryption at Rest Via AWS Well-Architected Tool Well-Architected Framework Security

Enforcing the use of encryption at rest is crucial as it ensures that data is protected from unauthorized access and potential breaches, even when stored on disk. This aligns with the AWS Well-Architected Framework Security pillar, enhancing data confidentiality and integrity, and mitigating the risks associated with data exposure.

This [policy pack](https://turbot.com/guardrails/docs/concepts/resources/smart-folders) can help you configure the following settings for Well-Architected Framework security sec08:

- Enforce use of Encryption at rest

## Documentation

- **[Review Policy settings →](https://hub-guardrails-turbot-com-git-development-turbot.vercel.app/policy-packs/enforce_use_of_encryption_at_rest_via_well_architected_framework/settings)**

## Getting Started

### Requirements

- [Terraform](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)
- Guardrails mods:
  - [@turbot/aws-wellarchitected](https://hub-guardrails-turbot-com-git-development-turbot.vercel.app/aws/mods/aws-wellarchitected)
  - [@turbot/aws-wellarchitected-framework](https://hub-guardrails-turbot-com-git-development-turbot.vercel.app/aws/mods/aws-wellarchitected-framework)

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
cd guardrails-samples/policy_packs/aws/vpc/enforce_use_of_encryption_at_rest_via_well_architected_framework
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

> [!IMPORTANT]
> Attaching this policy pack in Guardrails will result in creation of resources in the target account. However, it is easy to remove those resources later, by setting the contents of the Stack's Source policy to `{}` (empty).

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
resource "turbot_policy_setting" "aws_wellarchitectedtool_wellarchitectedframework_security_sec08" {
  type = "tmod:@turbot/aws-wellarchitected-framework#/policy/types/sec08"
  resource = turbot_policy_pack.main.id
  # value    = "Check: Choices based on sub policies"
  value    = "Enforce: Choices based on sub policies"
}
```

Then re-apply the changes:

```sh
terraform plan
terraform apply
```
