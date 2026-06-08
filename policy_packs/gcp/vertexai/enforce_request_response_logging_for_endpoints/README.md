---
categories: ["ai", "logging", "security"]
primary_category: "ai"
---

# Enforce Request-Response Logging for GCP Vertex AI Endpoints

[GCP Vertex AI request-response logging](https://cloud.google.com/vertex-ai/docs/predictions/online-prediction-logging) captures a sample of the prediction requests and responses served by an endpoint to a BigQuery table. Enabling it gives you an audit trail of how deployed models are being used, which is valuable for monitoring model behavior, troubleshooting, abuse detection, and compliance evidence.

This [policy pack](https://turbot.com/guardrails/docs/concepts/policy-packs) can help you configure the following settings for GCP Vertex AI endpoints:

- Check that request-response logging is enabled

**[Review policy settings →](https://hub.guardrails.turbot.com/policy-packs/gcp_vertexai_enforce_request_response_logging_for_endpoints/settings)**

## Getting Started

### Requirements

- [Terraform](https://developer.hashicorp.com/terraform/install)
- Guardrails mods:
  - [@turbot/gcp-vertexai](https://hub.guardrails.turbot.com/mods/gcp/mods/gcp-vertexai)

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
cd guardrails-samples/policy_packs/gcp/vertexai/enforce_request_response_logging_for_endpoints
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

This control checks that request-response logging is enabled and raises an alarm when it is not. To disable the check entirely, you can set the policy to `Skip`:

```hcl
resource "turbot_policy_setting" "gcp_vertexai_endpoint_active_request_response_logging" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/gcp-vertexai#/policy/types/endpointActiveRequestResponseLogging"
  value    = "Skip"
}
```

Then re-apply the changes:

```sh
terraform plan
terraform apply
```
