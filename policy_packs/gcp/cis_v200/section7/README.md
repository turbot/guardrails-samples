---
categories: ["cis"]
---

# GCP CIS v2.0.0 - Section 7 - BigQuery

This section addresses Google CloudPlatform BigQuery. BigQuery is a serverless, highly-scalable, and cost-effective cloud data warehouse with an in-memory BI Engine and machine learning built in.

This policy pack can help you automate enforcement of GCP CIS benchmark section 7 best practices.

**[Review policy settings →](https://hub-guardrails-turbot-com-git-development-turbot.vercel.app/policy-packs/gcp/cis_v200/section7/settings)**

## Getting Started

### Requirements

- [Terraform](https://developer.hashicorp.com/terraform/tutorials/gcp-get-started/install-cli)
- Guardrails mods:
  - [@turbot/gcp-bigquery](https://hub-guardrails-turbot-com-git-development-turbot.vercel.app/gcp/mods/gcp-bigquery)

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
> Clone:

```sh
git clone https://github.com/turbot/guardrails-samples.git
cd guardrails-samples/policy_packs/gcp/cis_v200/section7
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
> By default, the policies are set to `Check` in the pack's policy settings. To enable automated enforcements, you can switch these policies settings by adding a comment to the `Check` setting and removing the comment from one of the listed enforcement options:

```hcl
resource "turbot_policy_setting" "gcp_bigquery_dataset_publicly_accessible" {
  resource = turbot_smart_folder.main.id
  type     = "tmod:@turbot/gcp-bigquery#/policy/types/datasetPubliclyAccessible"
  note     = "GCP CIS v2.0.0 - Control: 7.1"
  # value    = "Check: Dataset is not publicly accessible"
  value    = "Enforce: Dataset is not publicly accessible"
}

resource "turbot_policy_setting" "gcp_bigquery_table_approved" {
  resource = turbot_smart_folder.main.id
  type     = "tmod:@turbot/gcp-bigquery#/policy/types/tableApproved"
  note     = "GCP CIS v2.0.0 - Control: 7.2"
  # value    = "Check: Approved"
  value    = "Enforce: Delete unapproved if new"
}

resource "turbot_policy_setting" "gcp_bigquery_dataset_encryption_at_rest" {
  resource = turbot_smart_folder.main.id
  type     = "tmod:@turbot/gcp-bigquery#/policy/types/datasetEncryptionAtRest"
  note     = "GCP CIS v2.0.0 - Control: 7.3"
  # value    = "Check: Customer managed key"
  # value    = "Check: Encryption at Rest > Customer Managed Key"
  # value    = "Enforce: Customer managed key"
  value    = "Enforce: Encryption at Rest > Customer Managed Key"
}
```

Then re-apply the changes:

```sh
terraform plan
terraform apply
```
