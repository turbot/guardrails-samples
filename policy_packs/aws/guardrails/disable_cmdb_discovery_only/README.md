---
categories: ["cost-optimization", "configuration"]
primary_category: "cost-optimization"
type: "featured"
---

# Disable CMDB Controls (Discovery Only Mode)

Reduce Guardrails billing costs by disabling CMDB controls for AWS service resources while preserving critical infrastructure like event handlers and prevention discovery.

This [policy pack](https://turbot.com/guardrails/docs/concepts/policy-packs) uses auto-discovery to generate workspace-specific configurations that disable CMDB for high-volume resources (EC2, S3, RDS, etc.) while keeping discovery controls active.

**[Review policy settings →](https://hub.guardrails.turbot.com/policy-packs/aws_guardrails_disable_cmdb_discovery_only/settings)**

## Use Case

Perfect for customers who want to:
- Start with discovery-only visibility (low cost)
- Use Turbot Pipes for resource visibility
- Defer detailed CMDB tracking until governance needs are defined
- Operate in prevention-first mode (SCPs/RCPs instead of runtime controls)
- Reduce costs during initial onboarding

## Cost Impact

**Example: Customer with 250,000 billable controls**

Before (full CMDB enabled):
- EC2 Instances: 75,000 controls
- S3 Buckets: 5,000 controls
- RDS: 2,000 controls
- IAM: 450 controls
- **Total: 250,000 controls → ~$6,000/month**

After (this policy pack):
- Account/Org/OU: ~50 controls
- Event Handlers: ~30 controls
- SCPs/RCPs: ~20 controls
- **Total: ~100 controls → ~$50/month (98% reduction)**

## Getting Started

### Requirements

- [Terraform](https://developer.hashicorp.com/terraform/install)
- [Turbot CLI](https://turbot.com/guardrails/docs/reference/cli)
- Guardrails mods:
  - [@turbot/turbot](https://hub.guardrails.turbot.com/mods/turbot/mods/turbot)
  - [@turbot/aws](https://hub.guardrails.turbot.com/mods/aws/mods/aws)
  - Any AWS service mods already installed

### Credentials

To create a policy pack through Terraform:

- Ensure you have `Turbot/Admin` permissions (or higher) in Guardrails
- [Create access keys](https://turbot.com/guardrails/docs/guides/iam/access-keys#generate-a-new-guardrails-api-access-key) in Guardrails

And then set your credentials:

```sh
export TURBOT_WORKSPACE=myworkspace.acme.com
export TURBOT_ACCESS_KEY=acce6ac5-access-key-here
export TURBOT_SECRET_KEY=a8af61ec-secret-key-here
```

Please see [Turbot Guardrails Provider authentication](https://registry.terraform.io/providers/turbot/turbot/latest/docs#authentication) for additional authentication methods.

## Usage

### Step 1: Auto-Discover Installed Mods

The discovery script queries your workspace to find all installed mods and generates a workspace-specific configuration:

```sh
git clone https://github.com/turbot/guardrails-samples.git
cd guardrails-samples/policy_packs/aws/guardrails/disable_cmdb_discovery_only

# Generate configuration for your workspace
./discover.py your-workspace.turbot.com > policies.yaml
```

This creates a `policies.yaml` file with three sections:
- `event_handlers` - Event handlers (always enabled)
- `prevention_cmdb` - SCP/RCP CMDB (enabled for prevention discovery)
- `service_cmdb_skip` - Service resource CMDB (disabled to reduce cost)

### Step 2: Review and Customize

Review the generated `policies.yaml`:

```sh
cat policies.yaml
```

**Optional**: Comment out any policies you want to keep enabled:

```yaml
service_cmdb_skip:
  # Keep S3 CMDB enabled for governance
  # s3_bucket:
  #   type: "tmod:@turbot/aws-s3#/policy/types/bucketCmdb"
  #   note: "S3 Buckets"

  # Disable everything else
  ec2_instance:
    type: "tmod:@turbot/aws-ec2#/policy/types/instanceCmdb"
    note: "EC2 Instances"
```

### Step 3: Deploy Policy Pack

Run the Terraform to create the policy pack in your workspace:

```sh
terraform init
terraform plan
```

Review the plan to ensure it matches your expectations, then apply:

```sh
terraform apply
```

### Step 4: Attach Policy Pack

Log into your Guardrails workspace and [attach the policy pack to a resource](https://turbot.com/guardrails/docs/guides/policy-packs#attach-a-policy-pack-to-a-resource).

If this policy pack is attached to a Guardrails folder, its policies will be applied to all accounts and resources in that folder. The policy pack can also be attached to multiple resources.

For more information, please see [Policy Packs](https://turbot.com/guardrails/docs/concepts/policy-packs).

### Step 5: Monitor Results

Watch the control count drop in the [billing portal](https://guardrails.turbot.com):

```sh
# Before: 250,000 controls
# After:  ~100-200 controls
# Savings: ~98% cost reduction
```

## Multi-Workspace Deployment

Generate configurations for multiple workspaces:

```sh
# Production workspace
./discover.py mycompany-production.turbot.com > policies-production.yaml

# Sandbox workspace
./discover.py mycompany-sandbox.turbot.com > policies-sandbox.yaml

# Deploy to production
terraform workspace new production
ln -sf policies-production.yaml policies.yaml
terraform apply

# Deploy to sandbox
terraform workspace new sandbox
ln -sf policies-sandbox.yaml policies.yaml
terraform apply
```

## What Gets Disabled

The auto-discovery script automatically categorizes policies:

**✅ Always Enabled (Critical Infrastructure):**
- Event Handlers (regional and global)
- Account CMDB
- Organization/OU CMDB
- SCP/RCP CMDB (for prevention discovery)

**❌ Disabled by Default (Service Resources):**
- EC2 resources (Instances, Volumes, AMIs, etc.)
- S3 Buckets
- RDS DB Instances/Clusters
- Lambda Functions
- IAM Users/Roles/Groups/Policies
- DynamoDB Tables
- ECS Clusters/Services
- And all other service resource CMDB controls

**⚠️ Customizable:**
- Edit `policies.yaml` to selectively enable specific resource types
- Comment out entries to keep CMDB enabled for those resources

## How It Works

1. **Discovery Script** (`discover.py`) queries your workspace via GraphQL
2. **Filters** installed mods by category (critical vs service)
3. **Generates** workspace-specific YAML configuration
4. **Terraform** reads the YAML and creates policy settings dynamically
5. **for_each** loops create settings from the YAML structure

## Files

- `main.tf` - Terraform configuration (reads policies.yaml)
- `providers.tf` - Terraform provider configuration
- `discover.py` - Auto-discovery script (Python 3)
- `policies-example.yaml` - Example configuration
- `README.md` - This file

## Prevention-First Mode

If you're following a prevention-first approach:

1. Install minimal mods: `@turbot/turbot`, `@turbot/aws`, `@turbot/aws-iam`
2. Generate minimal config: `./discover.py workspace > policies.yaml`
3. Deploy this policy pack (only ~5-10 policies)
4. Use Turbot Pipes for visibility
5. Create SCPs/RCPs based on Pipes findings
6. Later, selectively install service mods as needed

This reduces costs to ~$50-100/month vs $6,000/month with full service mods.

## Troubleshooting

**Q: Terraform errors on missing policy types**

A: The policy type doesn't exist because the mod isn't installed. Either:
- Install the mod: `turbot install @turbot/aws-<service>`
- Remove the entry from `policies.yaml`

**Q: How do I re-enable CMDB for specific resources?**

A: Either:
- Remove the policy setting from the pack
- Create a second policy pack that sets it to "Enforce: Enabled"
- Set it directly in the Guardrails console (overrides pack)

**Q: Will this break my existing controls?**

A: No. Setting CMDB to "Skip" pauses updates but doesn't delete existing data. Controls that depend on CMDB will show as "TBD" until CMDB is re-enabled.

## Advanced: Programmatic Updates

Re-generate configurations as mods change:

```sh
#!/bin/bash
# regenerate-configs.sh

for workspace in production sandbox dev; do
  echo "Regenerating config for $workspace..."
  ./discover.py mycompany-$workspace.turbot.com > policies-$workspace.yaml
done

terraform workspace select production
terraform plan
```

## Support

For questions or issues:
- [Guardrails Documentation](https://turbot.com/guardrails/docs)
- [GitHub Issues](https://github.com/turbot/guardrails-samples/issues)
- [Turbot Support](https://support.turbot.com)
