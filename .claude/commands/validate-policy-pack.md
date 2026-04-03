Validate one or more policy packs for correctness and consistency.

If a path is provided, validate that pack: $ARGUMENTS
If no path is provided, validate all changed policy packs (use `git diff --name-only origin/main` to find them).

For each policy pack directory, check:

1. **Required files exist**: `main.tf`, `policies.tf` (or policy settings in main.tf), `providers.tf`, `README.md`

2. **main.tf structure**: Must define exactly one `turbot_policy_pack` resource named "main" with `title`, `description`, and `akas` fields.

3. **providers.tf**: Must require the `turbot/turbot` provider with `version = ">= 1.11.0"`.

4. **policies.tf**: Each `turbot_policy_setting` must reference `turbot_policy_pack.main.id` as its `resource`. The `type` field must use a valid `tmod:@turbot/` URI pattern.

5. **README.md**: Must have YAML frontmatter with `categories` and `primary_category`. Must include sections: Getting Started, Requirements, Credentials, Usage.

6. **Naming conventions**: Directory name should be snake_case starting with a verb (`enforce_`, `check_`, `deny_`). The `akas` value should match `<provider>_<service>_<dirname>`.

7. **Terraform formatting**: Run `terraform fmt -check` on all `.tf` files.

Report a summary table of pass/fail for each check per pack, and details for any failures.
