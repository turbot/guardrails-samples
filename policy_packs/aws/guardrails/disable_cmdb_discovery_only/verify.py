#!/usr/bin/env python3
"""
Verify CMDB Policy Pack Deployment

Shows before/after stats for CMDB policies and estimates cost impact.

Usage:
    ./verify.py --profile procare    # Uses profile from credentials
    ./verify.py myworkspace.turbot.com
"""

import subprocess
import json
import sys
import argparse

def query_graphql(profile=None, workspace=None, query=None):
    """Execute GraphQL query against workspace."""
    cmd = ["turbot", "graphql", "--format", "json"]

    if profile:
        cmd.extend(["--profile", profile])
    elif workspace:
        cmd.extend(["--workspace", workspace])

    cmd.extend(["--query", query])

    result = subprocess.run(
        cmd,
        capture_output=True,
        text=True
    )

    if result.returncode != 0:
        print(f"Error: {result.stderr}", file=sys.stderr)
        sys.exit(1)

    return json.loads(result.stdout)

def verify_cmdb_disabled(profile=None, workspace=None):
    """Verify CMDB policies are disabled and show before/after stats."""

    # Query 1: Check if policy pack exists and is attached
    pack_query = """
    {
      policyPacks(filter: "title:\\"Disable CMDB Controls (Cost Optimization)\\"") {
        items {
          title
          policySettings {
            metadata {
              stats {
                total
              }
            }
          }
          attachedResources {
            items {
              title
            }
          }
        }
      }
    }
    """

    # Query 2: Total CMDB policy types available (baseline)
    policy_types_query = """
    {
      policyTypes(
        filter: "Cmdb controlCategoryId:\\"tmod:@turbot/turbot#/control/categories/cmdb\\" limit:1000"
      ) {
        metadata {
          stats {
            total
          }
        }
      }
    }
    """

    # Query 3: Current policy value settings
    policy_values_query = """
    {
      enabled: policyValues(
        filter: "policyTypeId:Cmdb value:\\"Enforce: Enabled\\""
      ) {
        items {
          type {
            uri
            title
          }
          resource {
            title
            trunk {
              title
            }
          }
        }
        metadata {
          stats {
            total
          }
        }
      }
      skipped: policyValues(
        filter: "policyTypeId:Cmdb value:Skip"
      ) {
        metadata {
          stats {
            total
          }
        }
      }
    }
    """

    # Query 4: Check if any AWS accounts exist
    accounts_query = """
    {
      resources(filter: "resourceTypeId:tmod:@turbot/aws#/resource/types/account limit:1") {
        metadata {
          stats {
            total
          }
        }
      }
    }
    """

    # Query 5: Check actual control states (most accurate for policy packs)
    control_states_query = """
    {
      skipped: controls(filter: "controlCategoryId:\\"tmod:@turbot/turbot#/control/categories/cmdb\\" state:skipped") {
        metadata {
          stats {
            total
          }
        }
      }
      ok: controls(filter: "controlCategoryId:\\"tmod:@turbot/turbot#/control/categories/cmdb\\" state:ok") {
        metadata {
          stats {
            total
          }
        }
      }
      total: controls(filter: "controlCategoryId:\\"tmod:@turbot/turbot#/control/categories/cmdb\\"") {
        metadata {
          stats {
            total
          }
        }
      }
    }
    """

    print(f"# Querying CMDB policies and deployment status...", file=sys.stderr)

    pack_data = query_graphql(profile=profile, workspace=workspace, query=pack_query)
    types_data = query_graphql(profile=profile, workspace=workspace, query=policy_types_query)
    values_data = query_graphql(profile=profile, workspace=workspace, query=policy_values_query)
    accounts_data = query_graphql(profile=profile, workspace=workspace, query=accounts_query)
    controls_data = query_graphql(profile=profile, workspace=workspace, query=control_states_query)

    # Extract data
    pack_items = pack_data["policyPacks"]["items"]
    pack_exists = len(pack_items) > 0
    pack_attached = pack_exists and len(pack_items[0]["attachedResources"]["items"]) > 0
    pack_settings_count = pack_items[0]["policySettings"]["metadata"]["stats"]["total"] if pack_exists else 0

    total_policies = types_data["policyTypes"]["metadata"]["stats"]["total"]
    enabled_count = values_data["enabled"]["metadata"]["stats"]["total"]
    skipped_count = values_data["skipped"]["metadata"]["stats"]["total"]
    accounts_count = accounts_data["resources"]["metadata"]["stats"]["total"]

    # Control states (actual runtime state - most accurate)
    controls_skipped = controls_data["skipped"]["metadata"]["stats"]["total"]
    controls_ok = controls_data["ok"]["metadata"]["stats"]["total"]
    controls_total = controls_data["total"]["metadata"]["stats"]["total"]

    # Calculate before/after
    not_explicitly_set = total_policies - enabled_count - skipped_count

    print("\n" + "=" * 70)
    print("CMDB POLICY PACK - BEFORE/AFTER COMPARISON")
    print("=" * 70)

    print("\n📦 POLICY PACK STATUS:")
    if pack_exists:
        print(f"   Policy pack: ✅ Deployed ({pack_settings_count} settings)")
        if pack_attached:
            attach_to = pack_items[0]["attachedResources"]["items"][0]["title"]
            print(f"   Attached to: ✅ {attach_to}")
        else:
            print(f"   Attached to: ❌ Not attached")
    else:
        print(f"   Policy pack: ❌ Not found")

    print(f"\n📊 WORKSPACE STATISTICS:")
    print(f"   AWS accounts imported:             {accounts_count}")
    print(f"   Total CMDB policy types available: {total_policies}")

    print(f"\n📋 POLICY CONFIGURATION:")
    if pack_exists and pack_attached:
        print(f"   Policy pack settings:              {pack_settings_count} policies configured")
        print(f"   Policies inheriting from pack:     {not_explicitly_set} of {total_policies}")
        print(f"   Policies with explicit overrides:  {enabled_count} enabled / {skipped_count} skipped")
    else:
        print(f"   Total CMDB policy types:           {total_policies}")
        print(f"   Policies explicitly enabled:       {enabled_count}")
        print(f"   Policies set to Skip:              {skipped_count}")
        print(f"   Not explicitly configured:         {not_explicitly_set}")

    print(f"\n🎯 CONTROL STATES (actual runtime state):")
    print(f"   Controls in 'skipped' state:       {controls_skipped:,}")
    print(f"   Controls in 'ok' state:            {controls_ok:,}")
    print(f"   Total CMDB controls:               {controls_total:,}")

    # Determine deployment status
    if pack_exists and pack_attached and accounts_count == 0:
        status = "DEPLOYED - AWAITING ACCOUNT IMPORT"
        print(f"\n📍 STATUS: {status}")
        print(f"\n✅ Policy pack is deployed and ready!")
        print(f"\n   No AWS accounts detected yet.")
        print(f"   When you import AWS accounts:")
        print(f"   - Discovery will find resources (EC2, S3, RDS, etc.)")
        print(f"   - CMDB controls will be automatically disabled by the pack")
        print(f"   - You'll avoid CMDB costs from day one!")
        print(f"\n   Next steps:")
        print(f"   1. Import AWS accounts into the '{attach_to}' folder")
        print(f"   2. Wait for discovery to complete")
        print(f"   3. Run ./verify.py again to see policies being skipped")
        return 0  # Success - pack is deployed correctly

    elif not pack_exists:
        status = "BEFORE DEPLOYMENT"
        print(f"\n📍 STATUS: {status}")
        print(f"\n⚠️  Policy pack not found in workspace")
        print(f"\n   Run: terraform apply -var=\"turbot_profile=<profile>\"")
        print(f"\n   Expected after deployment:")
        print(f"   - ~{total_policies - 10} policies will be set to Skip")
        print(f"   - ~5-10 critical policies will remain enabled")
        print(f"   - Significant cost reduction")

    elif pack_exists and not pack_attached:
        status = "DEPLOYED - NOT ATTACHED"
        print(f"\n📍 STATUS: {status}")
        print(f"\n⚠️  Policy pack exists but is not attached to any resource")
        print(f"\n   Next steps:")
        print(f"   1. Log into Guardrails console")
        print(f"   2. Go to Policies → Policy Packs")
        print(f"   3. Find: 'Disable CMDB Controls (Cost Optimization)'")
        print(f"   4. Click 'Attach' and select a folder/resource")
        return 1
    elif pack_exists and pack_attached and controls_total > 0 and controls_skipped > (controls_total * 0.90):
        # If pack is attached and >90% of controls are skipped, it's working
        status = "AFTER DEPLOYMENT"
        print(f"\n📍 STATUS: {status}")
        print(f"\n✅ SUCCESS! CMDB controls are disabled")

        skipped_percentage = (controls_skipped / controls_total * 100) if controls_total > 0 else 0
        print(f"\n   Control breakdown:")
        print(f"   - {controls_skipped:,} controls skipped ({skipped_percentage:.1f}%)")
        print(f"   - {controls_ok:,} controls active (critical infrastructure)")
        print(f"   - {controls_total:,} total CMDB controls")

        if skipped_count == 0:
            print(f"\n   ℹ️  Note: Policy pack uses inheritance - no explicit policy")
            print(f"      values are created, but policies are enforced via the pack.")
    elif pack_exists and pack_attached and controls_total > 0 and controls_skipped > 100:
        # Pack attached, some controls skipped but not >90% - still propagating
        status = "PARTIAL DEPLOYMENT"
        print(f"\n📍 STATUS: {status}")
        print(f"\n⏳ Policy pack is deployed but still propagating")

        skipped_percentage = (controls_skipped / controls_total * 100) if controls_total > 0 else 0
        print(f"\n   Current progress:")
        print(f"   - {controls_skipped:,} controls skipped ({skipped_percentage:.1f}%)")
        print(f"   - {controls_ok:,} controls still active")
        print(f"   - {controls_total:,} total CMDB controls")
        print(f"\n   ⏱️  Large workspaces can take 15-30 minutes to fully propagate.")
        print(f"   Run this script again in a few minutes to check progress.")
    else:
        status = "PARTIAL DEPLOYMENT"
        print(f"\n📍 STATUS: {status}")
        print(f"\n⚠️  Policy pack may be partially deployed")
        if controls_total == 0:
            print(f"\n   No CMDB controls found yet. This could mean:")
            print(f"   - No AWS accounts imported")
            print(f"   - Resources haven't been discovered yet")
            print(f"   - No service mods installed")
        else:
            print(f"   - {controls_skipped:,} controls skipped")
            print(f"   - {controls_ok:,} controls still active (expected ~5-10% of total)")

    # Cost impact estimation
    print(f"\n💰 COST IMPACT (at $0.05/control/month):")
    if controls_total > 0:
        # Use actual control counts
        current_cost = controls_ok * 0.05
        before_cost = controls_total * 0.05
        savings_monthly = before_cost - current_cost
        savings_annual = savings_monthly * 12

        print(f"   Before deployment:  {controls_total:,} controls = ${before_cost:,.2f}/month")
        print(f"   After deployment:   {controls_ok:,} controls = ${current_cost:,.2f}/month")
        print(f"   Monthly savings:    ${savings_monthly:,.2f}")
        print(f"   Annual savings:     ${savings_annual:,.2f}")

        if controls_total > 0:
            reduction_pct = (controls_skipped / controls_total * 100)
            print(f"   Cost reduction:     {reduction_pct:.1f}%")
    else:
        # No controls yet - show estimates
        print(f"   No controls found yet - showing estimates:")
        print(f"   Expected before:  ~{total_policies * 1000:,} controls → ~${total_policies * 1000 * 0.05:,.2f}/month")
        print(f"   Expected after:   ~100 controls → ~$5/month")
        print(f"   Expected savings: ~${(total_policies * 1000 * 0.05) - 5:,.2f}/month")

    # Show still-enabled details if needed
    if enabled_count > 0 and enabled_count <= 20:
        print(f"\n📋 POLICIES STILL ENABLED:")
        for item in values_data["enabled"]["items"][:20]:
            resource_path = " > ".join([t["title"] for t in item["resource"]["trunk"]])
            print(f"   • {item['type']['title']}")
            print(f"     Resource: {resource_path} > {item['resource']['title']}")

    print("\n" + "=" * 70 + "\n")

    # Return status code based on state
    if pack_exists and pack_attached and controls_total > 0 and controls_skipped > (controls_total * 0.90):
        return 0  # Success - deployed and >90% controls skipped
    elif pack_exists and pack_attached and accounts_count == 0:
        return 0  # Success - deployed and ready for accounts
    else:
        return 1  # Not deployed or partial

def main():
    parser = argparse.ArgumentParser(
        description='Verify CMDB policy pack deployment with before/after stats',
        formatter_class=argparse.RawDescriptionHelpFormatter
    )
    parser.add_argument(
        'workspace',
        nargs='?',
        help='Workspace URL (e.g., myworkspace.turbot.com)'
    )
    parser.add_argument(
        '--profile', '-p',
        help='Profile name from ~/.config/turbot/credentials.yml'
    )

    args = parser.parse_args()

    profile = args.profile
    workspace = args.workspace

    if not profile and not workspace:
        print("Error: Specify --profile or workspace argument", file=sys.stderr)
        print("", file=sys.stderr)
        print("Usage:", file=sys.stderr)
        print("  ./verify.py --profile production", file=sys.stderr)
        print("  ./verify.py myworkspace.turbot.com", file=sys.stderr)
        sys.exit(1)

    exit_code = verify_cmdb_disabled(profile=profile, workspace=workspace)
    sys.exit(exit_code)

if __name__ == "__main__":
    main()
