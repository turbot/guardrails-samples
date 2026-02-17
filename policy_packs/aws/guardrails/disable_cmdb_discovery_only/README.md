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

Based on [Guardrails pricing](https://turbot.com/guardrails/pricing) of **$0.05 per control per month** (Cloud Plan):

**Example: Large enterprise with full CMDB enabled**

Before (all service mods with CMDB):
- EC2 resources: 75,000 controls
- S3 resources: 5,000 controls
- RDS resources: 2,000 controls
- Other services: 168,000 controls
- **Total: 250,000 controls → $12,500/month ($150K/year)**

After (this policy pack - discovery only):
- Infrastructure: ~100 controls (accounts, event handlers, SCPs)
- **Total: ~100 controls → $5/month ($60/year)**
- **Savings: $12,440/month (99.96% reduction)**

**Example: Mid-size company with selective CMDB**

Before (moderate service coverage):
- Mixed resources: 25,000 controls
- **Total: 25,000 controls → $1,250/month ($15K/year)**

After (this policy pack):
- Infrastructure only: ~100 controls
- **Total: ~100 controls → $5/month ($60/year)**
- **Savings: $1,245/month (99.6% reduction)**

## Getting Started

### Requirements

- [Terraform](https://developer.hashicorp.com/terraform/install)
- [Turbot CLI](https://turbot.com/guardrails/docs/reference/cli) configured with credentials
- Python 3.7+ with PyYAML: `pip install -r requirements.txt`
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

The discovery script queries your workspace to find all installed mods and generates a workspace-specific configuration.

**First time setup:**

```sh
git clone https://github.com/turbot/guardrails-samples.git
cd guardrails-samples/policy_packs/aws/guardrails/disable_cmdb_discovery_only

# Install Python dependencies
pip install -r requirements.txt

# Set your default workspace (uses Turbot CLI credentials)
turbot workspace set myworkspace.turbot.com
```

**Generate configuration:**

```sh
# Option 1: Use default workspace from ~/.config/turbot/credentials.yml
./discover.py > policies.yaml

# Option 2: Specify workspace explicitly
./discover.py your-workspace.turbot.com > policies.yaml

# Option 3: Use a specific profile from credentials
./discover.py --profile production > policies.yaml
```

**Note**: The discovery script queries all policy types in your workspace (typically 2,000-3,000+ items). This takes 2-3 minutes due to API pagination. Progress is displayed as it runs. This is a one-time cost - the generated YAML can be reused.

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
# Example results:
# Before: 250,000 controls ($12,500/month)
# After:  ~100 controls ($5/month)
# Savings: 99.96% cost reduction
```

## Multi-Workspace Deployment

Generate configurations for multiple workspaces:

```sh
# Using --profile (recommended - no need to change default)
./discover.py --profile production > policies-production.yaml
./discover.py --profile sandbox > policies-sandbox.yaml
./discover.py --profile dev > policies-dev.yaml

# Or by changing default workspace
turbot workspace set mycompany-production.turbot.com
./discover.py > policies-production.yaml

# Or specify workspace explicitly
./discover.py mycompany-third.turbot.com > policies-third.yaml

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

## Works With or Without Prevention Mod

This solution is **discovery-based** and works in all scenarios:

**Scenario 1: With Prevention Mod** (`@turbot/aws-prevention` installed)
- SCPs/RCPs discovered and tracked
- AI-powered prevention extraction and objective mapping
- Service resource CMDB disabled (cost savings)
- Result: Prevention recommendations + cost optimization

**Scenario 2: Without Prevention Mod** (minimal install)
- SCPs/RCPs still discovered and tracked via `@turbot/aws-iam`
- No AI analysis or objective mapping (prevention mod features)
- Service resource CMDB disabled (or not installed)
- Result: Basic SCP visibility + maximum cost optimization

**Scenario 3: Service Mods Without Prevention**
- All service mods installed, no prevention mod
- Service CMDB disabled via this policy pack
- No SCP/RCP tracking (aws-iam not required)
- Result: Discovery-only mode for all services

The discovery script automatically detects what's installed and generates appropriate configuration for your specific setup.

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

**Cost comparison** (based on $0.05/control/month):
- Minimal install: ~100 controls = **$5/month** ($60/year)
- Full service mods: ~250,000 controls = **$12,500/month** ($150K/year)
- **Savings: 99.96% reduction**

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
