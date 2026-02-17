# =============================================================================
# YAML-Driven Policy Pack
# =============================================================================
# Reads configuration from cmdb-policies.yaml
# Enables easy customization per workspace without changing Terraform
# =============================================================================

# Load configuration from YAML
locals {
  policies = yamldecode(file("${path.module}/cmdb-policies.yaml"))
}

resource "turbot_policy_pack" "main" {
  title       = "Disable CMDB Controls (Cost Optimization)"
  description = "Disables service CMDB controls while preserving critical infrastructure and prevention discovery. Configuration loaded from cmdb-policies.yaml."
}

# =============================================================================
# Event Handlers (from YAML event_handlers section)
# =============================================================================

resource "turbot_policy_setting" "event_handlers" {
  for_each = local.policies.event_handlers != null ? local.policies.event_handlers : {}

  resource = turbot_policy_pack.main.id
  type     = each.value.type
  value    = each.value.value
  note     = each.value.note
}

# =============================================================================
# Prevention CMDB (from YAML prevention_cmdb section)
# =============================================================================

resource "turbot_policy_setting" "prevention_cmdb" {
  for_each = local.policies.prevention_cmdb != null ? local.policies.prevention_cmdb : {}

  resource = turbot_policy_pack.main.id
  type     = each.value.type
  value    = each.value.value
  note     = each.value.note
}

# =============================================================================
# Service CMDB Skip (from YAML service_cmdb_skip section)
# =============================================================================

resource "turbot_policy_setting" "service_cmdb_skip" {
  for_each = local.policies.service_cmdb_skip != null ? local.policies.service_cmdb_skip : {}

  resource = turbot_policy_pack.main.id
  type     = each.value.type
  value    = "Skip"
  note     = each.value.note
}

# =============================================================================
# Benefits of YAML-Driven Approach
# =============================================================================
#
# 1. Separation of Concerns:
#    - Terraform handles infrastructure (how)
#    - YAML defines configuration (what)
#
# 2. Per-Workspace Configs:
#    - policies-production.yaml
#    - policies-sandbox.yaml
#    - policies-dev.yaml
#
# 3. Non-Technical Editing:
#    - YAML is easier for non-Terraform users
#    - Can be edited in GitHub UI
#
# 4. Version Control:
#    - Track policy changes separately from infrastructure changes
#    - Clear diffs on policy additions/removals
#
# 5. Validation:
#    - Can validate YAML against JSON schema
#    - Can auto-generate from discovery scripts
#
# =============================================================================

# Example usage with multiple workspaces:
#
# terraform workspace new production
# ln -s cmdb-policies-production.yaml cmdb-policies.yaml
# terraform apply
#
# terraform workspace new sandbox
# ln -s cmdb-policies-sandbox.yaml cmdb-policies.yaml
# terraform apply
#
