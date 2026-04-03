Review a baseline configuration for correctness and CI compatibility.

If a path is provided, review that baseline: $ARGUMENTS
If no path is provided, review all changed baselines (use `git diff --name-only origin/main` to find them).

Check the following:

1. **Terraform validity**: Run `terraform fmt -check` and `terraform validate` (after `terraform init` if needed).

2. **Provider configuration**: Verify the turbot provider is configured correctly.

3. **Variable definitions**: Ensure `variables.tf` exists if `main.tf` references `var.*`. Check that variables have descriptions and sensible defaults.

4. **CI compatibility**: The baselines workflow processes folders in this order:
   - `baselines/guardrails/folder_hierarchy` (first)
   - `baselines/guardrails/turbot_profiles` (second)
   - `_mods` folders (with `-parallelism=1`)
   - Remaining folders
   
   Verify the baseline doesn't have dependencies that would break this ordering. If a `default.tfvars` exists, confirm it's referenced properly.

5. **State key**: The CI generates S3 state keys from the folder path. Ensure the folder path is clean (no spaces or special characters).

Report findings with pass/fail status and actionable recommendations.
