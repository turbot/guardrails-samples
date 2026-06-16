# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is the **Turbot Guardrails Samples** repository — a collection of sample policy packs, baselines, API examples, utilities, and GraphQL queries for the [Turbot Guardrails](https://turbot.com/guardrails) cloud governance platform. It is primarily Infrastructure-as-Code (Terraform/HCL) with supporting Python and Node.js scripts.

## Repository Structure

- **`policy_packs/`** — Terraform policy configurations organized by cloud provider (`aws/`, `azure/`, `gcp/`, `github/`). Each pack has `main.tf` defining `turbot_policy_pack` and `turbot_policy_setting` resources.
- **`baselines/`** — Terraform templates for workspace setup and cloud provider onboarding (`guardrails/`, `aws/`, `azure/`, `gcp/`, `servicenow/`). Applied via CI in a specific order: `folder_hierarchy` → `turbot_profiles` → `_mods` folders → remaining.
- **`queries/`** — GraphQL queries (`.graphql` files) for compliance reporting, organized by domain (`controls/`, `policies/`, `resources/`, `notifications/`, etc.).
- **`api_examples/`** — Python and Node.js examples for calling the Guardrails GraphQL API.
- **`guardrails_utilities/`** — Support scripts: `python_utils/` (batch operations, imports), `shell_utils/`, `env_health_checks/`, `materialization_utils/`, `workspace_usage/`.
- **`mod_examples/`** — Custom mod examples (e.g., `firehose-aws-sns/`).
- **`enterprise_installation/`** — Helpers for complex enterprise installs (Lambda imports, IAM role templates, bastion host).

## Common Commands

### Terraform (policy packs and baselines)

```bash
cd policy_packs/aws/<pack_name>    # or baselines/<provider>/<config>
terraform init
terraform plan                      # dry run
terraform apply                     # apply changes
```

Folders ending in `_mods` must use `-parallelism=1`. If a `default.tfvars` file exists, pass it with `--var-file=default.tfvars`.

Required environment variables for Guardrails provider:
- `TURBOT_WORKSPACE`, `TURBOT_ACCESS_KEY`, `TURBOT_SECRET_KEY`

### Python utilities

```bash
cd guardrails_utilities/<utility_dir>
pip install -r requirements.txt     # where requirements.txt exists
python <script>.py
```

The `turbot` package under `guardrails_utilities/python_utils/turbot/` is installed via `pip install -e .` (setuptools).

### Account offboarding (remove an AWS account from a workspace)

When an AWS account cannot be deleted directly from the Guardrails console, use
`guardrails_utilities/python_utils/remove_aws_account/delete_resources.py` — the canonical
offboarding tool. It authenticates via a `~/.config/turbot/credentials.yml` profile (`-p`) and
targets an account by AKA (`-a "arn:aws:::<accountId>"`). Run it **staged**, never as one bulk delete:

```bash
cd guardrails_utilities/python_utils/remove_aws_account
python3 delete_resources.py -p <profile> -a "arn:aws:::<acct>"               # 1. check (no writes)
python3 delete_resources.py -p <profile> -a "arn:aws:::<acct>" --disable     # 2. disable CMDB → wait ~1h
python3 delete_resources.py -p <profile> -a "arn:aws:::<acct>" --delete      # 3. delete leftover resources
python3 delete_resources.py -p <profile> -a "arn:aws:::<acct>" --delete-acct # 4. delete the account
```

Validate resource/control counts before and between stages (console or GraphQL). The optional
`main.tf` in that dir removes Turbot event handlers — apply it only if the account stays live.
The operator wrapper that resolves the target, maps the workspace host to a profile, and gates each
destructive stage lives in the `ops` repo skill `offboard-aws-account`.

### Tests (pytest)

```bash
cd guardrails_utilities/python_utils/turbot_error_report
pip install -r requirements.txt     # pytest>=7.0.0, pytest-mock>=3.10.0
pytest tests/                       # run all tests
pytest tests/test_turbot_error_report.py  # single test file
```

Testing coverage is limited to `turbot_error_report`. There is no repo-wide test suite.

### Node.js API examples

```bash
cd api_examples/node/<example>
npm install
node index.js
```

## CI/CD

- **Baselines workflow** (`.github/workflows/baselines.yml`): Triggers on push to `main` (changes in `baselines/**`) or manual dispatch. Supports dry-run mode and "all" vs "changed" folder selection. Uses S3 backend with DynamoDB locking for Terraform state.
- **Stale workflow** (`.github/workflows/stale.yml`): Daily cleanup of stale issues/PRs.
- GitHub Actions are pinned to commit SHAs (not tags) for security.

## Key Patterns

- **Terraform resources** use the `turbot` provider — primary resource types are `turbot_policy_pack`, `turbot_policy_setting`, `turbot_policy_value`, `turbot_mod`, `turbot_folder`, `turbot_smart_folder`, and `turbot_local_directory_user`.
- **Policy packs** follow a consistent structure: `main.tf` (pack + policy settings), `providers.tf` (provider config), `variables.tf` (input variables), optional `README.md`.
- **GraphQL queries** interact with the Guardrails API for controls, resources, policies, and notifications — typically using cursor-based paging.

## Calculated Policies

Any policy in Guardrails can be **calculated** instead of set to a static value: its value is computed at runtime from CMDB data. A calculated policy is a two-stage pipeline:

1. **GraphQL input query** — pulls data from the CMDB. In the console this is "Step 2"; in Terraform it is the `template_input` attribute on a `turbot_policy_setting`.
2. **Nunjucks (Jinja2-style) template** — transforms the query result into the value the policy type expects. In the console this is "Step 3"; in Terraform it is the `template` attribute.

### Terraform shape

```hcl
resource "turbot_policy_setting" "example" {
  resource       = turbot_policy_pack.main.id
  type           = "tmod:@turbot/aws-s3#/policy/types/bucketTagsTemplate"
  template_input = <<-EOT
    { resource { metadata } }
  EOT
  template       = <<-EOT
    {{ ... nunjucks ... }}
  EOT
}
```

### Conventions used in this repo

- **`$.` prefix** — inside the template, query results are addressed from the root as `$.resource.metadata`, `$.bucket.tags`, etc. Aliases in the query (`item: function { ... }`) become `$.item`.
- **Context pivots** — in a calc policy the GraphQL is a *super-set* of the API: `resource` / `bucket` / `function` pivot to *the resource being evaluated*, and `account`, `region`, and `folder` pivot to ancestors of that resource in the hierarchy. No IDs needed.
- **`get(path: "...")`** — escape hatch to read CMDB attributes not in the schema, e.g. `grantee: get(path: "Acl.Grants[0].Grantee")`.
- **Approved/Check policies** — `*ApprovedCustom` / `*Custom` templates must emit a `{ "title", "result", "message" }` object rendered with `{{ data | json }}`. Valid `result` values include `Approved`, `Not approved`, `Skip`.
- **Tags templates** — `*TagsTemplate` policies emit a YAML/JSON map of `key: value`; emit `[]` when there is nothing to set.
- **`-%}` / `{%-` whitespace trimming** is used heavily to keep rendered output clean.

### Reference examples in the repo (simple → complex)

- `policy_packs/aws/s3/enforce_creator_and_creationtime_tags_for_buckets/policies.tf` — tag template from `metadata`.
- `policy_packs/aws/lambda/enforce_functions_use_approved_tags/policies.tf` — conditional approval over a required-tag list.
- `policy_packs/aws/vpc/enforce_vpcs_have_transit_gateways_attached/policies.tf` — aggregation over `descendants` (the canonical "complex" example).

### Teaching / training material

`training/calc-policies/` contains a 2-hour training runbook, an authoring guide, and a simple→complex worked-example ladder. The hands-on console flow is the `calc-policy` 7-minute lab in the `guardrails-docs` repo.
