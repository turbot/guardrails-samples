#!/usr/bin/env python3
"""
Verify CMDB Policy Pack Deployment

Checks that CMDB policies have been successfully disabled after deploying
the policy pack. Reports how many are still enabled vs. now skipped.

Usage:
    ./verify.py                      # Uses default workspace
    ./verify.py <workspace>          # Uses specified workspace
    ./verify.py --profile procare    # Uses profile from credentials
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
    """Verify CMDB policies are disabled."""

    query = """
    {
      stillEnabled: policyValues(
        filter: "controlCategoryId:\\"tmod:@turbot/turbot#/control/categories/cmdb\\" value:\\"Enforce: Enabled\\""
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
      nowSkipped: policyValues(
        filter: "controlCategoryId:\\"tmod:@turbot/turbot#/control/categories/cmdb\\" value:Skip"
      ) {
        metadata {
          stats {
            total
          }
        }
      }
    }
    """

    print(f"# Querying policy values...", file=sys.stderr)
    data = query_graphql(profile=profile, workspace=workspace, query=query)

    still_enabled_count = data["stillEnabled"]["metadata"]["stats"]["total"]
    now_skipped_count = data["nowSkipped"]["metadata"]["stats"]["total"]

    print("\n" + "=" * 70)
    print("CMDB POLICY PACK VERIFICATION")
    print("=" * 70)
    print(f"\n✓ CMDB policies now set to Skip:      {now_skipped_count}")
    print(f"✗ CMDB policies still Enforce Enabled: {still_enabled_count}")

    if still_enabled_count == 0:
        print("\n✅ SUCCESS! All CMDB policies are disabled (or only critical infrastructure)")
        print("\nExpected next steps:")
        print("  - Controls will start transitioning to 'Skipped' state")
        print("  - Control count should drop significantly within hours")
        print("  - Monitor billing portal for cost reduction")
    elif still_enabled_count <= 5:
        print(f"\n⚠️  WARNING: {still_enabled_count} CMDB policies still enabled")
        print("\nThis is likely expected if they are critical infrastructure:")
        print("  - Event Handlers (regional/global)")
        print("  - Account/Region/Organization CMDB")
        print("\nStill enabled policies:")
        for item in data["stillEnabled"]["items"]:
            resource_path = " > ".join([t["title"] for t in item["resource"]["trunk"]])
            print(f"  - {item['type']['title']}")
            print(f"    Resource: {resource_path} > {item['resource']['title']}")
            print(f"    Type: {item['type']['uri']}")
    else:
        print(f"\n❌ ERROR: {still_enabled_count} CMDB policies still enabled")
        print("\nThis suggests the policy pack may not have been attached correctly.")
        print("\nCheck:")
        print("  1. Policy pack is attached to the correct resource")
        print("  2. Policy pack precedence is set correctly")
        print("  3. Review policies still enabled:")
        print()
        for item in data["stillEnabled"]["items"][:10]:
            resource_path = " > ".join([t["title"] for t in item["resource"]["trunk"]])
            print(f"  - {item['type']['title']}")
            print(f"    Resource: {resource_path} > {item['resource']['title']}")

    print("\n" + "=" * 70 + "\n")

    return still_enabled_count

def main():
    parser = argparse.ArgumentParser(
        description='Verify CMDB policy pack deployment',
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

    still_enabled = verify_cmdb_disabled(profile=profile, workspace=workspace)
    sys.exit(0 if still_enabled <= 5 else 1)

if __name__ == "__main__":
    main()
