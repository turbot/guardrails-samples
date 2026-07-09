# Calculated Policy Examples — Simple → Complex

A teaching ladder of four worked calculated policies. Each shows the **GraphQL
input query**, the **Nunjucks template**, a sample **rendered output**, and the
**Terraform** equivalent. All four are drawn from real packs in this repo — the
file path is linked under each example so learners can open the source.

> Read [`AUTHORING-GUIDE.md`](./AUTHORING-GUIDE.md) first for the concepts
> (`$.` paths, context pivots, `get(path:)`, output formats, whitespace).

| # | Difficulty | Skill introduced | Policy family |
| - | ---------- | ---------------- | ------------- |
| 1 | 🟢 Simple | Read a value, format a map | Tags template |
| 2 | 🟢🟢 Simple+ | Conditionals on resource metadata | Tags template |
| 3 | 🟡 Medium | Loop + required-list check, `{title,result,message}` | Approved/Custom |
| 4 | 🔴 Complex | Aggregate over `descendants` | Approved/Custom |

---

## 1 🟢 Static tag map (the "hello world")

**Goal:** set a fixed set of tags via a template. Introduces the pipeline and
the YAML `key: value` output shape — no logic yet.

**GraphQL input:**
```graphql
{ bucket { Name tags } }
```

**Template:**
```yaml
Company: "Vandelay Industries"
Department: "Sales"
Cost Center: "314159"
```

**Rendered value:**
```yaml
Company: "Vandelay Industries"
Department: "Sales"
Cost Center: "314159"
```

This is the literal starting point of the 7-minute lab. The next example adds
the conditional logic the lab builds toward.

---

## 2 🟢🟢 Conditional tags from CMDB metadata

**Goal:** stamp `creator` and `creationTime` tags pulled from the resource's
Guardrails metadata, only when present. Introduces `$.` paths, `if`,
`setAttribute`, `.split()`, and the empty-`[]` convention.

📁 `policy_packs/aws/s3/enforce_creator_and_creationtime_tags_for_buckets/policies.tf`

**GraphQL input:**
```graphql
{
  resource {
    metadata
  }
}
```

**Template:**
```nunjucks
{% set tags_plan = {} -%}

{%- if $.resource.metadata.createdBy -%}
  {%- set tags_plan = setAttribute(tags_plan, "creator", $.resource.metadata.createdBy) -%}
{%- endif -%}

{%- if $.resource.metadata.createTimestamp -%}
  {%- set tags_plan = setAttribute(tags_plan, "creationTime", $.resource.metadata.createTimestamp.split('T')[0]) -%}
{%- endif -%}

{%- if tags_plan | length < 1 -%}
  []
{%- else -%}
  {{ tags_plan | json }}
{%- endif -%}
```

**Rendered value:**
```json
{ "creator": "alice@example.com", "creationTime": "2026-01-14" }
```

**Why it matters:** the value adapts per resource. A freshly discovered bucket
with no metadata renders `[]` (set nothing) instead of breaking.

---

## 3 🟡 Approved check over a required-tag list

**Goal:** mark a resource Approved only if it carries every required tag.
Introduces the `{ title, result, message }` output contract for
`*ApprovedCustom` policies, plus looping over a configurable list.

📁 `policy_packs/aws/lambda/enforce_functions_use_approved_tags/policies.tf`

**GraphQL input:**
```graphql
{
  item: function {
    tags: get(path: "Tags")
  }
}
```

**Template:**
```nunjucks
{%- set tags = $.item.tags -%}
{%- set inputTagKeys = ["name", "environment"] -%}
{%- set tagsLength = tags | length -%}
{%- set allTagsPresent = true -%}
{%- set flag = true -%}

{%- if tagsLength > 0 -%}
  {%- for key in inputTagKeys -%}
    {%- if flag and not key in tags -%}
      {%- set allTagsPresent = false -%}
      {%- set flag = false -%}
    {%- endif -%}
  {%- endfor -%}
{%- endif -%}

{%- if tagsLength > 0 and allTagsPresent -%}
  {%- set data = {
      "title": "Approved Tags",
      "result": "Approved",
      "message": "Function has approved tags"
  } -%}
{%- elif tagsLength == 0 or not allTagsPresent -%}
  {%- set data = {
      "title": "Approved Tags",
      "result": "Not approved",
      "message": "Function is missing one or more required tags"
  } -%}
{%- endif %}

{{ data | json }}
```

**Rendered value:**
```json
{ "title": "Approved Tags", "result": "Not approved", "message": "Function is missing one or more required tags" }
```

**Pair it:** this `functionApprovedCustom` template feeds the
`functionApproved` policy (`Check: Approved` / `Enforce: Delete unapproved if new`).
The `inputTagKeys` list is the one knob a customer customizes.

---

## 4 🔴 Aggregate over descendants

**Goal:** approve a VPC only if it has at least one Transit Gateway attachment.
Introduces relationship traversal (`descendants` with a filter) and aggregation
(`| length`) — the canonical "complex" calc policy.

📁 `policy_packs/aws/vpc/enforce_vpcs_have_transit_gateways_attached/policies.tf`

**GraphQL input:**
```graphql
{
  resource {
    VpcId: get(path: "VpcId")
    descendants(filter: "resourceTypeId:tmod:@turbot/aws-vpc-connect#/resource/types/transitGatewayAttachment level:self,descendant") {
      items {
        VpcId: get(path: "VpcId")
      }
    }
  }
}
```

**Template:**
```nunjucks
{%- if $.resource.VpcId and $.resource.descendants.items | length == 0 %}
  {% set data = {
      "title": "Transit Gateway Attachment",
      "result": "Not approved",
      "message": "Transit Gateway is not attached to VPC"
  } -%}
{%- elif $.resource.VpcId and $.resource.descendants.items | length > 0 %}
  {% set data = {
      "title": "Transit Gateway Attachment",
      "result": "Approved",
      "message": "Transit Gateway is attached to VPC"
  } -%}
{%- else %}
  {% set data = {
      "title": "Transit Gateway Attachment",
      "result": "Skip",
      "message": "No data for VPC yet"
  } -%}
{%- endif %}

{{ data | json }}
```

**Rendered value:**
```json
{ "title": "Transit Gateway Attachment", "result": "Approved", "message": "Transit Gateway is attached to VPC" }
```

**What's new vs #3:** the decision depends on *related* resources, not the
resource's own attributes. The explicit `Skip` branch handles the window before
descendants are discovered.

---

## Where to go next

- Re-implement #2 for **Azure** (`virtualMachine` tags) or **GCP** to prove the
  pattern is provider-agnostic.
- Take #4 and aggregate a **count threshold** (e.g. "≥ 2 subnets") instead of a
  boolean presence check.
- Browse more live examples: any pack containing `template_input` in
  `policy_packs/**/policies.tf`.
