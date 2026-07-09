# Calculated Policy Authoring Guide

A reference to keep open while writing calculated policies in Turbot Guardrails.
Pairs with the worked examples in [`EXAMPLES.md`](./EXAMPLES.md) and the
[`calc-policy` 7-minute lab](https://turbot.com/guardrails/docs/getting-started/7-minute-labs/calc-policy).

---

## 1. What a calculated policy is

Most policy settings take a **static value**. A **calculated** setting computes
its value at runtime from data in the Guardrails CMDB. It is a two-stage pipeline:

```
CMDB ──(GraphQL input query)──▶ JSON data ──(Nunjucks template)──▶ policy value
```

| Stage | Console label | Terraform attribute | Purpose |
| ----- | ------------- | ------------------- | ------- |
| 1 | Step 2: Query data using GraphQL | `template_input` | Pull the data you need |
| 2 | Step 3: Transform using Jinja2 Template | `template` | Shape it into the value the policy type expects |

**Any policy can be calculated.** The value is recomputed automatically whenever
the underlying CMDB data changes.

---

## 2. The GraphQL input query

The query language is a **super-set** of the Guardrails GraphQL API. Two things
make it special inside a calc policy:

### Context pivots (no IDs required)

The query is evaluated *in the context of the resource being governed*:

- `resource { ... }` / the resource alias (`bucket`, `function`, `vpc`, …) → **this** resource.
- `account { ... }` → the AWS account / Azure subscription / GCP project above it.
- `region { ... }` → the region this resource lives in.
- `folder { ... }` → the folder above it in the hierarchy.

```graphql
{
  region { Name }
  bucket { Name tags }
}
```

### `get(path: "...")` — the escape hatch

Some attributes exist in the CMDB but aren't in the schema. Read them with `get`:

```graphql
{
  bucket {
    tags
    grantee: get(path: "Acl.Grants[0].Grantee")
  }
}
```

### Aliases

Alias a node to control the name you reference in the template:

```graphql
{ item: function { tags: get(path: "Tags") } }   # → $.item.tags
```

### `descendants` / relatives (for aggregation)

Pull related resources to count or inspect them:

```graphql
{
  resource {
    VpcId: get(path: "VpcId")
    descendants(filter: "resourceTypeId:tmod:@turbot/aws-vpc-connect#/resource/types/transitGatewayAttachment level:self,descendant") {
      items { VpcId: get(path: "VpcId") }
    }
  }
}
```

> **Tip:** discover the schema via auto-complete in the console builder, the
> **Explore** tab on a resource, or the **Inspect** tab of the
> [mod docs on the Hub](https://hub.guardrails.turbot.com/#mods).

---

## 3. The Nunjucks template

[Nunjucks](https://mozilla.github.io/nunjucks/templating.html) is Jinja2-style
templating. The query result is the root object, addressed with `$.`.

```nunjucks
{{ $.bucket.tags['Department'] }}
{% if $.resource.metadata.createdBy %}...{% endif %}
{% for key in inputTagKeys %}...{% endfor %}
```

### Output formats by policy-type family

Calc policies must emit exactly what the target policy type's schema expects.

**A. Tags `*Template` policies** — emit a `key: value` map (YAML or JSON), or `[]` when empty:

```nunjucks
{% set tags_plan = {} -%}
{%- if $.resource.metadata.createdBy -%}
  {%- set tags_plan = setAttribute(tags_plan, "creator", $.resource.metadata.createdBy) -%}
{%- endif -%}
{%- if tags_plan | length < 1 -%}[]{%- else -%}{{ tags_plan | json }}{%- endif -%}
```

**B. Approved / Check `*Custom` policies** — emit a `{ title, result, message }` object via `{{ data | json }}`:

```nunjucks
{%- if condition -%}
  {% set data = { "title": "...", "result": "Approved", "message": "..." } -%}
{%- elif other -%}
  {% set data = { "title": "...", "result": "Not approved", "message": "..." } -%}
{%- else -%}
  {% set data = { "title": "...", "result": "Skip", "message": "No data yet" } -%}
{%- endif %}
{{ data | json }}
```

Common `result` values: `Approved`, `Not approved`, `Skip`. Always include a
`Skip` branch for "no data yet" so the control doesn't flap before discovery.

### Useful filters & helpers

| Helper | Use |
| ------ | --- |
| `| json` | render an object as JSON (required for `*Custom` output) |
| `| length` | count items / map keys |
| `setAttribute(obj, key, val)` | add a key to an object immutably |
| `.split('T')[0]` | trim an ISO timestamp to a date |
| `value in ['a','b']` | membership test in conditionals |

---

## 4. Whitespace control (read this before you fight the renderer)

`{%- ... -%}` trims whitespace around a tag. Calc policy output is validated
against the policy type's schema, and stray blank lines or indentation break
YAML/JSON. The repo convention:

- Use `-%}` and `{%-` on logic-only lines so they produce **no** output.
- Keep the single value-producing line (`{{ data | json }}`) clean.

---

## 5. Static vs calculated, in Terraform

A calc policy is just a `turbot_policy_setting` with `template_input` + `template`
instead of `value`:

```hcl
# static
resource "turbot_policy_setting" "tags" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/aws-s3#/policy/types/bucketTags"
  value    = "Check: Tags are correct"
}

# calculated
resource "turbot_policy_setting" "tags_template" {
  resource       = turbot_policy_pack.main.id
  type           = "tmod:@turbot/aws-s3#/policy/types/bucketTagsTemplate"
  template_input = <<-EOT
    { resource { metadata } }
  EOT
  template       = <<-EOT
    ...nunjucks...
  EOT
}
```

A working pack typically pairs the **enforcement** policy (`...Approved`,
`...Tags`) with its **calculated input** policy (`...ApprovedCustom`,
`...TagsTemplate`).

---

## 6. Debugging checklist

1. **Run the input query alone** in the console builder — confirm the right-hand
   results pane actually contains the data you reference.
2. **`$.` paths must match query aliases** — `item: function` → `$.item`, not `$.function`.
3. **Render preview** — the builder shows the rendered template *and* the final
   schema-validated value. A red validation error means your output shape is wrong
   (wrong keys, not JSON, stray whitespace).
4. **Test resource** — set a representative Test Resource; calc results depend on
   *that* resource's CMDB data and its ancestors.
5. **`Skip` early** — if data may be absent (resource just discovered), branch to
   `Skip` rather than emitting a broken value.
6. **Where you set it matters** — a setting on the resource affects only it; on an
   account/folder it affects every matching descendant, each computing *its own* value.

---

## 7. Further reading

- [Calculated Policies 7-minute lab](https://turbot.com/guardrails/docs/getting-started/7-minute-labs/calc-policy)
- [Nunjucks templating](https://mozilla.github.io/nunjucks/templating.html)
- [Guardrails GraphQL API reference](https://turbot.com/guardrails/docs/reference/graphql)
- [Guardrails Filter language reference](https://turbot.com/guardrails/docs/reference/filter)
- [Mod schemas on the Hub](https://hub.guardrails.turbot.com/#mods)
