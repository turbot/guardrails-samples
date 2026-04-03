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
