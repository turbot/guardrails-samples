---
categories: ["ai", "security"]
primary_category: "ai"
---

# Enforce Approved Models for GCP Vertex AI

A registered model is what Vertex AI deployments and prediction endpoints serve. Restricting the registry to a reviewed set of models, and checking that every endpoint serves only reviewed models, keeps model choice within what has been assessed for provenance, licensing and data handling.

This [policy pack](https://turbot.com/guardrails/docs/concepts/policy-packs) can help you configure the following settings for GCP Vertex AI:

- Check that each Model Registry model is approved — by Model Garden provenance, by an approval label, by a time-boxed exception label, or by an explicit per-source-type allowlist
- Check that every model deployed on an endpoint is an approved model

**[Review policy settings →](https://hub.guardrails.turbot.com/policy-packs/gcp_vertexai_enforce_approved_models/settings)**

## What this pack does and does not cover

It governs **Model Registry models and the endpoints that serve them** — the self-deployed path (Model Garden one-click deploys, custom uploads, AutoML). It does **not** see calls to managed foundation-model APIs (`generateContent` on Gemini or partner models) or batch prediction jobs, because neither creates a registry model or an endpoint. For those, restrict models with the `vertexai.allowedModels` organization policy constraint, which blocks unapproved models at admission.

## How the model check works

`GCP > Vertex AI > Model > Allowed > Custom > Rules` decides in this order and returns the first match:

| Order | Signal | Decision | Control reason |
|---|---|---|---|
| 1 | `baseModelSource.modelGardenSource.publicModelName@versionId` is in `approvedModelGarden` | Allowed | `Approved Foundation Model` |
| 2 | label `LABEL_KEY = approved` | Allowed | `Approved by Label` (echoes `LABEL_KEY-ref`) |
| 3 | label `LABEL_KEY = exception` with a valid `LABEL_KEY-expires` (`YYYY-MM-DD`) | Allowed until that date | `Approved by Exception` / `Expired Exception` |
| 4 | `MODEL_GARDEN` model whose provenance pair is not listed | Not allowed | `Approved Foundation Model` |
| 5 | `modelSourceInfo.sourceType` not a key of `approvedBySource` | Not allowed | `Approved Model Source` |
| 6 | full `name` in `approvedBySource[sourceType]` | Allowed | `Approved Model` |
| 7 | anything else | Not allowed | `Approved Model` |

Provenance comes first because it is the only signal that says *which foundation model* a registry entry actually is. GCP writes `baseModelSource` when a Model Garden model is copied into the registry; the registry name it generates (for example `google-gemma3-gemma-3-1b-it-1790239863`) is not stable across deployments, the publisher name and version are. `modelSourceInfo.sourceType` describes how a model entered the registry, not whose weights it holds — an uploaded Llama registers as `CUSTOM` — so it is a gate for in-house models, not a provenance check.

Approval is keyed on the **pair** `publicModelName@versionId`. A new version of an approved foundation model is not approved until it is listed.

The check fails closed: an unreadable source type or name, an unlisted source type, an unlisted model and an exception without an expiry all return `Not allowed`.

### Labels

Two label keys, defined as constants at the top of the model template and marked `MAINTENANCE` — replace `guardrails-model-approval` with your own convention:

| Label | Value | Effect |
|---|---|---|
| `LABEL_KEY` | `approved` | Model is approved; `LABEL_KEY-ref` (a ticket id) is shown in the control reason |
| `LABEL_KEY` | `exception` | Model is approved **until** `LABEL_KEY-expires` (`YYYY-MM-DD`, mandatory) |

Guardrails calculated policies have no clock, so the template cannot know today's date by itself. Set the `TODAY` constant at apply time — for example `formatdate("YYYY-MM-DD", timestamp())` in Terraform — and re-apply on a schedule to enforce expiries. When `TODAY` is empty the exception is still honoured and the control reason says `expiry not checked`, so an unchecked expiry is visible rather than silently permanent.

## How the endpoint check works

`GCP > Vertex AI > Endpoint > Allowed > Custom > Rules` reads the endpoint's `deployedModels[]`, looks up the `Model > Allowed > Custom` control of each deployed model in the same project, and returns **one** result:

| Order | Condition | Decision | Control reason |
|---|---|---|---|
| 1 | endpoint label `LABEL_KEY = exception` | Allowed | `Endpoint Exception` |
| 2 | no deployments | Allowed | `No Deployments` |
| 3 | a deployed model has no `Model > Allowed` control | Not allowed | `Unresolved Deployment` |
| 4 | a deployed model's control is not `ok` | Not allowed | `Unapproved Deployment` (`n of m deployments unapproved`) |
| 5 | all controls `ok` | Allowed | `All Deployments Approved` |

The approval list is written once, in the model template; the endpoint template reads control state. Deployments are matched to models by full model name, never by endpoint id, because Model Garden endpoints carry a string name (`mg-endpoint-…`) but a numeric id in the model's own back-reference.

A mixed endpoint — one approved and one unapproved model — is `Not allowed`. The template returns a single object on purpose: the Allowed control treats an array of results as "allowed if any entry is allowed", which would let a mixed endpoint pass.

The template also compares each deployment's `modelVersionId` with the model's current `versionId` and appends `older-version` to the message. Today the mod does not store `versionId` on the Model record, so this is a no-op; `FAIL_ON_OLD_VERSION = false` keeps it a note rather than a failure until it can be trusted.

### Why the endpoint layer is check-only

The only enforcement the mod offers for `Endpoint > Allowed` is deleting the endpoint, and GCP refuses to delete an endpoint that still has models deployed — exactly the endpoints this check is about. Selective remediation needs an undeploy action the mod does not have yet ([turbot-mods #47927](https://github.com/turbotio/turbot-mods/issues/47927)). Leave `endpointAllowedCustom` at `Check: Allowed`.

## Getting Started

### Requirements

- [Terraform](https://developer.hashicorp.com/terraform/install)
- Guardrails mods:
  - [@turbot/gcp-vertexai](https://hub.guardrails.turbot.com/mods/gcp/mods/gcp-vertexai) v5.5.0 or later, with Model and Endpoint discovery and CMDB enabled

### Prerequisites in the mod

Three `gcp-vertexai` defects limit how current the data behind this pack is. None breaks the pack; each means a manual discovery or CMDB run is needed until it is fixed:

- [#47930](https://github.com/turbotio/turbot-mods/issues/47930) — model creation is not a real-time event; run `Model > Discovery` after registering a model.
- [#47925](https://github.com/turbotio/turbot-mods/issues/47925) — the Model CMDB refreshes only labels; provenance is captured at discovery and does not change after.
- [#47923](https://github.com/turbotio/turbot-mods/issues/47923) / [#47931](https://github.com/turbotio/turbot-mods/issues/47931) — deploy and undeploy are not real-time events; run `Endpoint > CMDB` after a deployment.

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
cd guardrails-samples/policy_packs/gcp/vertexai/enforce_approved_models
```

Before running Terraform, edit the model Rules template in `policies.tf`:

```jinja
{%- set LABEL_KEY = "guardrails-model-approval" -%}   {# your label convention #}
{%- set TODAY = "" -%}                                 {# inject YYYY-MM-DD at apply time #}

{%- set approvedModelGarden = [
  "publishers/google/models/gemma3@gemma-3-1b-it"     {# publisher model @ version #}
] -%}

{%- set approvedBySource = {
  "CUSTOM": [
    "projects/PROJECT_NUMBER/locations/LOCATION/models/MODEL_ID"
  ]
} -%}
```

`approvedModelGarden` entries come from the model's `baseModelSource.modelGardenSource` (`publicModelName` and `versionId`). `approvedBySource` entries come from `modelSourceInfo.sourceType` (key) and `name` (value) — use the exact full name, not a display name; Google may return a project number in this path even when the upload used a project ID. The same `LABEL_KEY` must be set in the endpoint template.

Run Terraform to create the policy pack in your workspace:

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

**Attach at the project or folder, not per model.** The endpoint check only works where both endpoints and models are under the attachment: a deployed model that is outside it has no `Model > Allowed` control and its endpoint reports `Unresolved Deployment`. A per-model attachment also means every new model has to be attached by hand before it is checked at all.

For more information, please see [Policy Packs](https://turbot.com/guardrails/docs/concepts/policy-packs).

### Enable Enforcement

> [!TIP]
> You can also update the policy settings in this policy pack directly in the Guardrails console.
>
> Please note your Terraform state file will then become out of sync and the policy settings should then only be managed in the console.

To delete unapproved **models** created within the last 60 minutes, change the model Custom policy in `policies.tf`:

```hcl
resource "turbot_policy_setting" "gcp_vertexai_model_allowed_custom" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/gcp-vertexai#/policy/types/modelAllowedCustom"
  value    = "Enforce: Delete if not allowed and resource is new"
}
```

To include existing models, use `Enforce: Delete if not allowed`. A model that is deployed cannot be deleted; undeploy it first. Review the approved lists and check-mode alarms before enabling deletion. Leave the endpoint Custom policy at `Check: Allowed` (see above).

Then re-apply the changes:

```sh
terraform plan
terraform apply
```

## Create resources for an end-to-end check

The minimum end-to-end set is:

1. A Model Garden self-deployment of an approved foundation model, for example `publishers/google/models/gemma3@gemma-3-1b-it` on `g2-standard-12` with one L4 (billable; destroy when done). This creates a registry model with provenance and an endpoint serving it.
2. Two registry-only custom fixtures uploaded with Google's sample container (see the `gcloud ai models upload` loop in the previous version of this README); list one in `approvedBySource.CUSTOM`.
3. After each creation, run the region's `Model > Discovery`, and after each deployment the endpoint's `CMDB`, until the mod issues above are fixed.

Expected: the foundation model and the listed fixture are `ok`, the unlisted fixture is `alarm`, the endpoint serving the foundation model is `ok`, and an endpoint serving both fixtures is `alarm` with `1 of 2 deployments unapproved`.
