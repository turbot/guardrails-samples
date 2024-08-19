---
categories: [ "data protection", "security" ]
primary_category: "data protection"
type: "featured"
---

# Alert on GCP BigQuery Datasets with Unauthorized Access

Alerting when a GCP BigQuery datasets has unauthorized access is crucial to protect sensitive and proprietary data from
unauthorized access and potential breaches. By alerting on unauthorized access, organizations can maintain data privacy,
comply with regulatory requirements, and safeguard against malicious activities.

This [policy pack](https://turbot.com/guardrails/docs/concepts/policy-packs) can help you configure the following
settings for BigQuery datasets:

- Alert when unapproved access has been granted to a BigQuery DataSet
- Specify a regex to identify unauthorized access.

*

*[Review policy settings →](https://hub.guardrails.turbot.com/policy-packs/gcp_bigquery_alert_dataset_unapproved_access)
**

## Getting Started

### Requirements

- [Terraform](https://developer.hashicorp.com/terraform/install)
- Guardrails mods:
    - [@turbot/gcp-bigquery](https://hub.guardrails.turbot.com/mods/gcp/mods/gcp-bigquery)

### Credentials

To create a policy pack through Terraform:

- Ensure you have `Turbot/Admin` permissions (or higher) in Guardrails
- [Create access keys](https://turbot.com/guardrails/docs/guides/iam/access-keys#generate-a-new-guardrails-api-access-key)
  in Guardrails

And then set your credentials:

```sh
export TURBOT_WORKSPACE=myworkspace.acme.com
export TURBOT_ACCESS_KEY=acce6ac5-access-key-here
export TURBOT_SECRET_KEY=a8af61ec-secret-key-here
```

Please
see [Turbot Guardrails Provider authentication](https://registry.terraform.io/providers/turbot/turbot/latest/docs#authentication)
for additional authentication methods.

## Usage

### Install Policy Pack

> [!NOTE]
> By default, installed policy packs are not attached to any resources.
>
> Policy packs must be attached to resources in order for their policy settings to take effect.

Clone:

```sh
git clone https://github.com/turbot/guardrails-samples.git
cd guardrails-samples/policy_packs/gcp/bigquery/alert_dataset_unapproved_access
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

### Adjust Regex to Needs

In the `GCP > BigQuery > DataSet > Apporved > Custom` policy setting, a regex is set to identify unapproved access. If an identity matches the regex then it is unapproved. 

The default value is:

```jinja2
    {% set forbidden_regex = r/(?=.*dev-)(?=.*dtap)/g -%}
```

The regex should be adjusted to meet your needs. 

### Apply Policy Pack

Log into your Guardrails workspace
and [attach the policy pack to a resource](https://turbot.com/guardrails/docs/guides/policy-packs#attach-a-policy-pack-to-a-resource).

If this policy pack is attached to a Guardrails folder, its policies will be applied to all accounts and resources in
that folder. The policy pack can also be attached to multiple resources.

For more information, please see [Policy Packs](https://turbot.com/guardrails/docs/concepts/policy-packs).

### Enable Enforcement

> [!WARN]
> By default, the policies are set to `Check` in the pack's policy settings. This policy setting should never be set to
`Enforce`. If set to `Enforce` then Guardrails will attempt to destroy the DataSet that has unapproved access.

There is no enforcement for this policy pack. 
