---
categories: ["access management", "security"]
primary_category: "access management"
---

# Enforce Trusted Domains to Access GCP IAM Project Policy

Enforcing trusted domains to access GCP IAM project policies is essential for ensuring that only authorized and verified domains can interact with your project's IAM policies. This measure helps prevent unauthorized access, enhances security by limiting access to trusted entities, and ensures compliance with security best practices and regulatory requirements.

This [policy pack](https://turbot.com/guardrails/docs/concepts/resources/smart-folders) can help you configure the following settings for project policy:

- Set a list of trusted domains
- Revoke untrusted access from project IAM policy

**[Review policy settings →](https://hub-guardrails-turbot-com-git-development-turbot.vercel.app/policy-packs/enforce_trusted_domains_to_access_project_iam_policy/settings)**

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
cd guardrails-samples/policy_packs/gcp/iam/enforce_trusted_domains_to_access_project_iam_policy
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
resource "turbot_policy_setting" "gcp_iam_project_iam_policy_trusted_access" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/gcp-iam#/policy/types/projectIamPolicyTrustedAccess"
  # value    = "Check: Trusted Access > *"
  value = "Enforce: Trusted Access > *"
}
```

Then re-apply the changes:

```sh
terraform plan
terraform apply
```
