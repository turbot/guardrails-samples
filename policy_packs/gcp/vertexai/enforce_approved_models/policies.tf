# GCP > Vertex AI > Model > Allowed > Custom
resource "turbot_policy_setting" "gcp_vertexai_model_allowed_custom" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/gcp-vertexai#/policy/types/modelAllowedCustom"
  value    = "Check: Allowed"
  # value    = "Enforce: Delete if not allowed and resource is new"
  # value    = "Enforce: Delete if not allowed"
}

# GCP > Vertex AI > Model > Allowed > Custom > Rules
resource "turbot_policy_setting" "gcp_vertexai_model_allowed_custom_rules" {
  resource       = turbot_policy_pack.main.id
  type           = "tmod:@turbot/gcp-vertexai#/policy/types/modelAllowedCustomRules"
  template_input = <<-EOT
    {
      item: model {
        name: get(path: "name")
        versionId: get(path: "versionId")
        sourceType: get(path: "modelSourceInfo.sourceType")
        publicModelName: get(path: "baseModelSource.modelGardenSource.publicModelName")
        baseVersionId: get(path: "baseModelSource.modelGardenSource.versionId")
        labels: get(path: "labels")
      }
    }
  EOT

  # MAINTENANCE: the approval list lives in this template and nowhere else. Edit
  # approvedModelGarden (foundation models by publisher name and version) and
  # approvedBySource (in-house models by source type and full name). Replace the
  # LABEL_KEY placeholder with your label convention before applying.
  template = <<-EOT
    {#- Label convention. LABEL_KEY holds "approved" or "exception". The -ref suffix
        carries a ticket reference and is echoed in the control reason. The -expires
        suffix carries a YYYY-MM-DD date and is mandatory for exceptions, because an
        exception with no end date is an approval nobody reviewed. -#}
    {%- set LABEL_KEY = "guardrails-model-approval" -%}
    {%- set REF_KEY = LABEL_KEY + "-ref" -%}
    {%- set EXPIRES_KEY = LABEL_KEY + "-expires" -%}

    {#- Guardrails calculated policies have no clock: there is no "now" in the template
        or the input query. Expiry is therefore compared against TODAY, a YYYY-MM-DD
        string the deployment pipeline injects at apply time (Terraform:
        formatdate("YYYY-MM-DD", timestamp())), which re-renders on every apply. Empty
        means "do not compare"; the control reason then says so, so an unchecked expiry
        is visible rather than a silent permanent approval. -#}
    {%- set TODAY = "" -%}

    {#- Tier 0, provenance. GCP writes baseModelSource when a Model Garden model is
        copied into the registry, so publicModelName@versionId names the actual
        foundation model and version regardless of the registry name, which Google
        generates. This is the only tier that can say WHICH foundation model is in use.
        Keyed on the pair, not the name, so a new version of an approved model is not
        approved by default. -#}
    {%- set approvedModelGarden = [
      "publishers/google/models/gemma3@gemma-3-1b-it"
    ] -%}

    {#- Tier 3, explicit names, nested under source type so a model is only approved
        FOR ITS OWN SOURCE TYPE. Flat lists would also approve a pairing nobody
        reviewed, such as an approved model id that was deleted and re-registered from
        MARKETPLACE. This is the tier for in-house models (CUSTOM, AUTOML, BQML), which
        carry no provenance. Names are the full CMDB resource name, matched EXACTLY and
        CASE-SENSITIVELY. -#}
    {%- set approvedBySource = {
      "CUSTOM": [
        "projects/1035367865236/locations/us-central1/models/guardrails-approved-model-test"
      ]
    } -%}

    {%- set modelName = $.item.name -%}
    {%- set modelSource = $.item.sourceType -%}
    {%- set labels = $.item.labels or {} -%}
    {%- set fm = "" -%}
    {%- if $.item.publicModelName and $.item.baseVersionId -%}
      {%- set fm = $.item.publicModelName + "@" + $.item.baseVersionId -%}
    {%- endif -%}

    {#- Decision order: provenance, then label, then exception, then explicit name.
        Every branch returns ONE object; the Allowed control treats an array as
        "allowed if any entry is allowed", which would let a mixed result pass.
        The policy schema caps message at 128 characters, so long names are truncated
        rather than interpolated in full; the control's resource identifies the model. -#}
    {%- if modelSource == "MODEL_GARDEN" and fm and (fm in approvedModelGarden) -%}
      {%- set data = {
        "title": "Approved Foundation Model",
        "result": "Allowed",
        "message": "Foundation model " + (fm | truncate(96)) + " is approved"
      } -%}

    {%- elif labels[LABEL_KEY] == "approved" -%}
      {%- set ref = labels[REF_KEY] -%}
      {%- set data = {
        "title": "Approved by Label",
        "result": "Allowed",
        "message": "Approved by label" + (", ref " + (ref | truncate(60)) if ref else "")
      } -%}

    {%- elif labels[LABEL_KEY] == "exception" -%}
      {%- set expires = labels[EXPIRES_KEY] -%}
      {%- if not expires or (expires | length) != 10 -%}
        {%- set data = {
          "title": "Expired Exception",
          "result": "Not allowed",
          "message": "Exception label has no valid expiry date (YYYY-MM-DD)"
        } -%}
      {%- elif TODAY and expires < TODAY -%}
        {%- set data = {
          "title": "Expired Exception",
          "result": "Not allowed",
          "message": "Exception expired on " + expires
        } -%}
      {%- else -%}
        {%- set data = {
          "title": "Approved by Exception",
          "result": "Allowed",
          "message": "Exception until " + expires + (", expiry not checked" if not TODAY else "")
        } -%}
      {%- endif -%}

    {#- A Model Garden model with provenance that is simply not on the list is a
        foundation-model rejection, not a source-type rejection; say so. -#}
    {%- elif modelSource == "MODEL_GARDEN" and fm -%}
      {%- set data = {
        "title": "Approved Foundation Model",
        "result": "Not allowed",
        "message": "Foundation model " + (fm | truncate(92)) + " is not approved"
      } -%}

    {#- Fail closed on both remaining tiers: an unreadable source type or name, an
        unapproved source type, and a name absent from its source type's list all
        return "Not allowed". Tier 1 tests key membership rather than an empty list,
        because an empty array is truthy in Nunjucks. -#}
    {%- elif not modelSource or not (modelSource in approvedBySource) -%}
      {%- set data = {
        "title": "Approved Model Source",
        "result": "Not allowed",
        "message": "Model source type " + (modelSource | default("<unknown>", true)) + " is not an approved source"
      } -%}

    {%- elif modelName and modelName in approvedBySource[modelSource] -%}
      {%- set data = {
        "title": "Approved Model",
        "result": "Allowed",
        "message": "Model is in the approved list for source type " + modelSource
      } -%}

    {%- else -%}
      {%- set data = {
        "title": "Approved Model",
        "result": "Not allowed",
        "message": "Model is not in the approved list for source type " + modelSource
      } -%}
    {%- endif -%}

    {{ data | json }}
  EOT
}

# GCP > Vertex AI > Endpoint > Allowed > Custom
#
# Check-only on purpose. The mod's only enforcement for this control is the endpoint
# delete action, and GCP refuses to delete an endpoint while models are deployed on
# it, so enforcement would fail on exactly the endpoints that matter. Selective
# remediation needs an undeploy action the mod does not have yet (turbot-mods #47927).
resource "turbot_policy_setting" "gcp_vertexai_endpoint_allowed_custom" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/gcp-vertexai#/policy/types/endpointAllowedCustom"
  value    = "Check: Allowed"
}

# GCP > Vertex AI > Endpoint > Allowed > Custom > Rules
#
# Two stanzas. The first reads the endpoint's project id; the second uses it to scope
# the query to the Model > Allowed > Custom controls of that project, so the endpoint
# decision is derived from the model layer's decisions and the approval list is
# written once, in the model template.
resource "turbot_policy_setting" "gcp_vertexai_endpoint_allowed_custom_rules" {
  resource       = turbot_policy_pack.main.id
  type           = "tmod:@turbot/gcp-vertexai#/policy/types/endpointAllowedCustomRules"
  template_input = <<-EOT
    - |
      {
        endpoint {
          metadata
        }
      }
    - |
      {
        endpoint {
          name: get(path: "name")
          labels: get(path: "labels")
          deployedModels: get(path: "deployedModels")
        }
        modelControls: controls(filter: "controlTypeId:tmod:@turbot/gcp-vertexai#/control/types/modelAllowedCustom resource:'gcp://cloudresourcemanager.googleapis.com/projects/{{ $.endpoint.metadata.gcp.projectId }}' limit:1000") {
          items {
            state
            reason
            resource {
              name: get(path: "name")
              versionId: get(path: "versionId")
            }
          }
        }
      }
  EOT

  template = <<-EOT
    {#- Same label convention as the model template. An endpoint-level exception
        exempts everything serving on it, so it is deliberately coarse; prefer a model
        exception when only one model needs it. -#}
    {%- set LABEL_KEY = "guardrails-model-approval" -%}
    {%- set REF_KEY = LABEL_KEY + "-ref" -%}

    {#- A deployment can serve an older version of a model than the registry's current
        one. Today the CMDB Model record carries no versionId, so this comparison is a
        no-op; the switch exists so the behaviour is explicit once it does. -#}
    {%- set FAIL_ON_OLD_VERSION = false -%}

    {%- set labels = $.endpoint.labels or {} -%}
    {%- set deployments = $.endpoint.deployedModels or [] -%}
    {%- set controls = ($.modelControls.items if $.modelControls and $.modelControls.items else []) -%}

    {#- Accumulators are arrays mutated with push, so the result does not depend on how
        the Nunjucks build scopes `set` inside a for-loop (it differs between versions;
        the Guardrails build was verified to let it survive, but push works in all). -#}
    {%- set unresolved = [] -%}
    {%- set unapproved = [] -%}
    {%- set older = [] -%}

    {%- if labels[LABEL_KEY] == "exception" -%}
      {%- set ref = labels[REF_KEY] -%}
      {%- set data = {
        "title": "Endpoint Exception",
        "result": "Allowed",
        "message": "Endpoint is exempted by label" + (", ref " + (ref | truncate(60)) if ref else "")
      } -%}

    {#- An endpoint with nothing deployed serves nothing, so it cannot be serving an
        unapproved model. Returning Not allowed here would alarm on every idle endpoint
        and drown the real signal. -#}
    {%- elif (deployments | length) == 0 -%}
      {%- set data = {
        "title": "No Deployments",
        "result": "Allowed",
        "message": "Nothing is serving on this endpoint"
      } -%}

    {%- else -%}
      {#- Match each deployment to a model by full resource name. DeployedModel.model
          may carry an @version suffix, which is stripped for the match. Never match by
          endpoint id: Model Garden endpoints have a string name (mg-endpoint-...) but
          appear under a numeric id in the model's own deployedModels back-reference. -#}
      {%- for d in deployments -%}
        {%- set target = (d.model or "").split("@")[0] -%}
        {%- set hits = [] -%}
        {%- for c in controls -%}
          {%- if c.resource and c.resource.name == target -%}
            {%- set _ = hits.push(c) -%}
          {%- endif -%}
        {%- endfor -%}
        {#- No control means the model is outside the pack's attachment or was never
            discovered. Fail closed: unknown is not approved. -#}
        {%- if (hits | length) == 0 -%}
          {%- set _ = unresolved.push(target) -%}
        {%- else -%}
          {%- set c = hits[0] -%}
          {%- if c.state != "ok" -%}
            {%- set _ = unapproved.push(target) -%}
          {%- endif -%}
          {%- if c.resource.versionId and d.modelVersionId and c.resource.versionId != d.modelVersionId -%}
            {%- set _ = older.push(target) -%}
          {%- endif -%}
        {%- endif -%}
      {%- endfor -%}

      {%- set total = deployments | length -%}
      {%- set note = (" older-version" if (older | length) > 0 else "") -%}

      {#- One aggregate object. Unresolved outranks unapproved because it means the
          check could not even be made; both outrank the version note. -#}
      {%- if (unresolved | length) > 0 -%}
        {%- set data = {
          "title": "Unresolved Deployment",
          "result": "Not allowed",
          "message": (unresolved | length) + " of " + total + " deployments have no Model Allowed control" + note
        } -%}
      {%- elif (unapproved | length) > 0 -%}
        {%- set data = {
          "title": "Unapproved Deployment",
          "result": "Not allowed",
          "message": (unapproved | length) + " of " + total + " deployments unapproved" + note
        } -%}
      {%- elif FAIL_ON_OLD_VERSION and (older | length) > 0 -%}
        {%- set data = {
          "title": "Older Version Deployed",
          "result": "Not allowed",
          "message": (older | length) + " of " + total + " deployments serve an older model version"
        } -%}
      {%- else -%}
        {%- set data = {
          "title": "All Deployments Approved",
          "result": "Allowed",
          "message": total + " of " + total + " deployments approved" + note
        } -%}
      {%- endif -%}
    {%- endif -%}

    {{ data | json }}
  EOT
}
