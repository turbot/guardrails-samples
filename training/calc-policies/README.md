# Calculated Policies — Training & Enablement

Material for teaching developers and customers to write **calculated policies**
in Turbot Guardrails, from a one-value tag template up to descendant aggregation.

## What's here

| File | Use it for |
| ---- | ---------- |
| [`TRAINING-RUNBOOK.md`](./TRAINING-RUNBOOK.md) | A timed, 2-hour facilitator script for a hands-on customer training. |
| [`AUTHORING-GUIDE.md`](./AUTHORING-GUIDE.md) | A reference to keep open while writing calc policies (concepts, output contracts, debugging). |
| [`EXAMPLES.md`](./EXAMPLES.md) | A simple→complex ladder of four worked examples (GraphQL + Nunjucks + rendered output + Terraform). |

## How they fit together

```
Concept  ──▶  AUTHORING-GUIDE.md   (the "how it works")
Practice ──▶  EXAMPLES.md          (4 worked examples, simple → complex)
Deliver  ──▶  TRAINING-RUNBOOK.md  (2-hour session built on the 7-min lab)
```

- The hands-on console flow uses the **`calc-policy` 7-minute lab** in the
  `guardrails-docs` repo.
- The production (Terraform) form lives in real packs under
  `policy_packs/**/policies.tf` — see the file links inside `EXAMPLES.md`.
- The repo-wide `CLAUDE.md` has a **Calculated Policies** section so any Claude
  Code session in this repo is fluent in the pattern.

## Suggested path for a new author

1. Skim `AUTHORING-GUIDE.md` §1–§3.
2. Reproduce Example #1 and #2 from `EXAMPLES.md` in the console builder.
3. Build an approval policy (Example #3), then an aggregation (Example #4).
4. Port your tested query + template into a `turbot_policy_setting` (`template_input` / `template`).
