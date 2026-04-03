Create a new Guardrails policy pack based on the user's description: $ARGUMENTS

Follow the established patterns in this repo exactly:

1. Determine the cloud provider (aws, azure, gcp, github) and service from the user's request.

2. Create the directory under `policy_packs/<provider>/<service>/<pack_name>` using snake_case naming that starts with a verb (e.g., `enforce_`, `check_`, `deny_`).

3. Generate these files by referencing existing packs in the same provider/service as templates:

   **main.tf** - Define the `turbot_policy_pack` resource:
   ```hcl
   resource "turbot_policy_pack" "main" {
     title       = "<Title Case Name>"
     description = "<One-line description>"
     akas        = ["<provider>_<service>_<pack_name>"]
   }
   ```

   **policies.tf** - Define `turbot_policy_setting` resources using `tmod:@turbot/<provider>-<service>#/policy/types/<policyType>` URIs. Include commented-out enforcement alternatives.

   **providers.tf** - Standard turbot provider block:
   ```hcl
   terraform {
     required_providers {
       turbot = {
         source  = "turbot/turbot"
         version = ">= 1.11.0"
       }
     }
   }
   provider "turbot" {}
   ```

   **README.md** - Follow the exact structure from existing packs: frontmatter with categories, description, policy settings overview, Getting Started (Requirements, Credentials), Usage (Install, Apply, Enable Enforcement).

4. Default policy values to `Check` mode (not `Enforce`) with enforcement options as comments.

5. Run `terraform fmt` on all generated `.tf` files.

If unsure about the correct `tmod:` policy type URI for the requested policy, look at similar existing packs in the repo to find the right pattern. Ask the user rather than guessing URIs.
