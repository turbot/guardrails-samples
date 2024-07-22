---
categories: ["access management", "cis", "compliance", "data protection"]
primary_category: "compliance"
---

# GCP CIS v2.0.0 - Section 1 - Identity and Access Management

This section covers recommendations addressing Identity and Access Management on Google Cloud Platform.

This [policy pack](https://turbot.com/guardrails/docs/concepts/resources/policy-packs) can help you automate the enforcement of GCP CIS benchmark section 1 best practices.

**[Review policy settings →](https://hub-guardrails-turbot-com-git-development-turbot.vercel.app/policy-packs/gcp_cis_v200_section1/settings)**

## Getting Started

### Requirements

- [Terraform](https://developer.hashicorp.com/terraform/tutorials/gcp-get-started/install-cli)
- Guardrails mods:
  - [@turbot/gcp-dataproc](https://hub-guardrails-turbot-com-git-development-turbot.vercel.app/mods/gcp/mods/gcp-dataproc)
  - [@turbot/gcp-iam](https://hub-guardrails-turbot-com-git-development-turbot.vercel.app/mods/gcp/mods/gcp-iam)
  - [@turbot/gcp-kms](https://hub-guardrails-turbot-com-git-development-turbot.vercel.app/mods/gcp/mods/gcp-kms)

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
cd guardrails-samples/policy_packs/gcp/cis_v200/section1
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

For more information, please see [Policy Packs](https://turbot.com/guardrails/docs/concepts/resources/policy-packs).

### Enable Enforcement

> [!TIP]
> You can also update the policy settings in this policy pack directly in the Guardrails console.
>
> Please note your Terraform state file will then become out of sync and the policy settings should then only be managed in the console.
> By default, the policies are set to `Check` in the pack's policy settings. To enable automated enforcements, you can switch these policies settings by adding a comment to the `Check` setting and removing the comment from one of the listed enforcement options:

```hcl
resource "turbot_policy_setting" "gcp_iam_service_account_key_approved" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/gcp-iam#/policy/types/serviceAccountKeyApproved"
  note     = "GCP CIS v2.0.0 - Control: 1.4"
  # value    = "Check: Approved"
  value    = "Enforce: Delete unapproved if new"
}

resource "turbot_policy_setting" "gcp_iam_service_account_approved" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/gcp-iam#/policy/types/serviceAccountApproved"
  note     = "GCP CIS v2.0.0 - Control: 1.5"
  # value    = "Check: Approved"
  value    =  "Enforce: Delete unapproved if new"
}

resource "turbot_policy_setting" "gcp_iam_project_user_approved" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/gcp-iam#/policy/types/projectUserApproved"
  note     = "GCP CIS v2.0.0 - Control: 1.6, 1.8 and 1.11"
  # value    = "Check: Approved"
  value    =  "Enforce: Delete unapproved if new"
}

resource "turbot_policy_setting" "gcp_iam_service_account_key_active" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/gcp-iam#/policy/types/serviceAccountKeyActive"
  note     = "GCP CIS v2.0.0 - Control: 1.7"
  # value    = "Check: Active"
  value    =  "Enforce: Delete inactive with 90 days warning"
}

resource "turbot_policy_setting" "gcp_kms_crypto_key_policy_trusted_access" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/gcp-kms#/policy/types/cryptoKeyPolicyTrustedAccess"
  note     = "GCP CIS v2.0.0 - Control: 1.9"
  # value    = "Check: Trusted Access > *"
  value    = "Enforce: Trusted Access > *"
}

resource "turbot_policy_setting" "gcp_kms_crypto_key_approved" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/gcp-kms#/policy/types/cryptoKeyApproved"
  note     = "GCP CIS v2.0.0 - Control: 1.10"
  value    = "Check: Approved"
}

resource "turbot_policy_setting" "gcp_iam_api_key_approved" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/gcp-iam#/policy/types/apiKeyApproved"
  note     = "GCP CIS v2.0.0 - Control: 1.12, 1.13 and 1.14"
  # value    = "Check: Approved"
  value    = "Enforce: Delete unapproved if new"
}

resource "turbot_policy_setting" "gcp_iam_service_account_key_active" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/gcp-iam#/policy/types/apiKeyActive"
  note     = "GCP CIS v2.0.0 - Control: 1.15"
  # value    = "Check: Active"
  value    =  "Enforce: Delete inactive with 90 days warning"
}

resource "turbot_policy_setting" "gcp_dataproc_cluster_approved" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/gcp-dataproc#/policy/types/clusterApproved"
  note     = "GCP CIS v2.0.0 - Control: 1.17"
  # value    = "Check: Approved"
  value    = "Enforce: Delete unapproved if new"
}
```

Then re-apply the changes:

```sh
terraform plan
terraform apply
```
