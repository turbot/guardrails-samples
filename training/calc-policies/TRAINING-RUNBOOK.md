# Calculated Policies — 2-Hour Training Runbook

A facilitator script for delivering a hands-on calculated-policy training to a
customer. Built on top of the
[`calc-policy` 7-minute lab](https://turbot.com/guardrails/docs/getting-started/7-minute-labs/calc-policy)
and the worked examples in [`EXAMPLES.md`](./EXAMPLES.md).

| | |
| --- | --- |
| **Audience** | Cloud / platform engineers who will author and ship policies |
| **Duration** | ~2 hours (120 min) including Q&A |
| **Format** | Live console demo + 2 hands-on exercises + Terraform bridge |
| **Outcome** | Attendees can build, test, and ship simple→complex calc policies |

---

## Before the session — facilitator prep

- [ ] Confirm each attendee can log into the Guardrails console as `Turbot/Admin` or `Turbot/Owner`.
- [ ] Confirm the `aws` and `aws-s3` mods are installed in the training workspace.
- [ ] Pre-create **one S3 bucket per attendee** (or a shared one) with a few tags, so there is a real Test Resource.
- [ ] Have `policy_packs/aws/.../policies.tf` examples open (see [`EXAMPLES.md`](./EXAMPLES.md)) for the Terraform segment.
- [ ] Share the [`AUTHORING-GUIDE.md`](./AUTHORING-GUIDE.md) link as the take-home reference.
- [ ] Decide: are attendees shipping via console only, or via Terraform too? (Drives how deep segment 6 goes.)

---

## Agenda at a glance

| Time | Segment | Mode |
| ---- | ------- | ---- |
| 0:00–0:15 | 1. Concept: why calculated policies | Talk |
| 0:15–0:35 | 2. Live demo: S3 Tags Template | Demo |
| 0:35–1:00 | 3. Exercise 1: build the tag template | Hands-on |
| 1:00–1:20 | 4. GraphQL deep-dive: pivots, get(), descendants | Talk + demo |
| 1:20–1:45 | 5. Exercise 2: conditional approval policy | Hands-on |
| 1:45–1:55 | 6. Ship it as Terraform | Demo |
| 1:55–2:00 | 7. Wrap-up & Q&A | Discussion |

---

## Segment 1 — Concept (0:00–0:15)

**Goal:** everyone understands *what* a calc policy is and *when* to reach for one.

Talking points:
- Static value vs **calculated** value — "any policy in Guardrails can be calculated."
- The two-stage pipeline: **GraphQL input query → Nunjucks template → policy value.**
- Recomputes automatically when CMDB data changes.
- Where you set it matters: resource vs account/folder (each descendant computes *its own* value).

Draw this on screen:
```
CMDB ──(GraphQL)──▶ JSON ──(Nunjucks)──▶ policy value
```

**Checkpoint:** "Give me one policy in your environment that can't be a single static value." (Collect 1–2 answers — use them later.)

---

## Segment 2 — Live demo (0:15–0:35)

**Goal:** show the full console flow end-to-end before anyone touches it.

Follow the 7-minute lab live for `AWS > S3 > Bucket > Tags > Template`:
1. **Policies → New Policy Setting**, select the policy type, pick a Test Resource bucket.
2. **Enable calculated mode → Launch calculated policy builder.**
3. Paste the **Step 2** query: `{ bucket { Name tags } }`. Point out the live results pane on the right.
4. Paste the **Step 3** Nunjucks template (the conditional tag example from the lab).
5. Walk the **rendered output** and **schema-validated value** panes at the bottom.
6. **Create**, then show the resulting control re-evaluate.

Narrate: "Step 2 is *what data*, Step 3 is *what shape*. The right-hand panes are your feedback loop."

---

## Segment 3 — Exercise 1 (0:35–1:00)

**Goal:** muscle memory for the builder; output = a tags map.

Attendees reproduce the demo on **their own** bucket, then extend it:
- Build the `bucketTagsTemplate` calc policy from scratch.
- Add a conditional: if `Environment` tag isn't one of `Dev/QA/Prod`, output `Non-Compliant Tag`.
- Confirm the rendered value changes when they change the Test Resource's tags.

Facilitator circulates. Common stumbles to watch for:
- Referencing `$.bucket.tags` when the query aliased the node differently.
- Broken YAML from missing whitespace trims — point them to `{%- -%}`.

**Checkpoint:** everyone has a green (schema-valid) rendered value.

---

## Segment 4 — GraphQL deep-dive (1:00–1:20)

**Goal:** unlock data beyond the resource's own attributes.

Demo, building on the lab's "Expand your query" section:
- **Context pivots** — add `region { Name }`, `account { ... }`, `folder { ... }` and explain they pivot to ancestors automatically.
- **`get(path: "...")`** — add `grantee: get(path: "Acl.Grants[0].Grantee")` for attributes not in the schema.
- **`descendants(filter: ...)`** — preview the VPC/Transit-Gateway example (Example #4) to show aggregation.
- Show **where to find schemas**: Explore tab, Hub Inspect tab, builder auto-complete.

**Checkpoint:** "Where would you look up the field name for X?" (Answer: Explore tab / Hub Inspect.)

---

## Segment 5 — Exercise 2 (1:20–1:45)

**Goal:** write a real *approval* policy with the `{title, result, message}` contract.

Use **Example #3** (required-tag approval) as the template. Attendees:
- Pick an `*ApprovedCustom` policy type (Lambda function, or S3 bucket approved).
- Query the resource's tags with `get(path: "Tags")`.
- Loop over a required-tag list and emit `Approved` / `Not approved`.
- Add a `Skip` branch for "no data yet."

Stretch goal (fast finishers): make the required-tag list driven by a higher-level
policy value instead of hard-coding it.

**Checkpoint:** rendered output is a valid `{ "title", "result", "message" }` JSON object; control shows Approved/Not approved as expected.

---

## Segment 6 — Ship it as Terraform (1:45–1:55)

**Goal:** connect the console skill to how they'll actually deploy at scale.

- Open `policy_packs/aws/lambda/enforce_functions_use_approved_tags/policies.tf`.
- Map the console builder to HCL: **Step 2 → `template_input`**, **Step 3 → `template`**.
- Show the pack pairs an **enforcement** policy with its **calculated input** policy.
- Mention the apply flow from the repo: `terraform init / plan / apply` with `TURBOT_WORKSPACE`, `TURBOT_ACCESS_KEY`, `TURBOT_SECRET_KEY`.

Key message: "What you tested in the builder is copy-paste ready into a policy pack — same query, same template, version-controlled."

---

## Segment 7 — Wrap-up & Q&A (1:55–2:00)

- Recap the pipeline and the two output contracts (tags map vs `{title,result,message}`).
- Hand out references: [`AUTHORING-GUIDE.md`](./AUTHORING-GUIDE.md), [`EXAMPLES.md`](./EXAMPLES.md), the 7-minute lab, Nunjucks + GraphQL docs.
- Revisit the policies attendees named in Segment 1 — "which of those could you build now?"

---

## Facilitator cheat-sheet

| Symptom | Likely cause | Fix |
| ------- | ------------ | --- |
| Empty results pane | No/incomplete Test Resource, or wrong field name | Pick a real resource; check Explore tab for field names |
| `$.x is undefined` | `$.` path doesn't match query alias | Match alias exactly (`item: function` → `$.item`) |
| Red schema validation | Output shape wrong (keys / not JSON / whitespace) | Use `{{ data | json }}`; trim with `{%- -%}` |
| Control flaps / errors before discovery | No `Skip` branch | Add an `else → Skip` branch |
| Setting affects too many resources | Set too high in hierarchy | Set on the resource, not account/folder |

---

## Take-home references

- [`AUTHORING-GUIDE.md`](./AUTHORING-GUIDE.md) — concepts & debugging
- [`EXAMPLES.md`](./EXAMPLES.md) — simple→complex worked examples
- [Calculated Policies 7-minute lab](https://turbot.com/guardrails/docs/getting-started/7-minute-labs/calc-policy)
- [Nunjucks templating](https://mozilla.github.io/nunjucks/templating.html)
- [Guardrails GraphQL reference](https://turbot.com/guardrails/docs/reference/graphql)
