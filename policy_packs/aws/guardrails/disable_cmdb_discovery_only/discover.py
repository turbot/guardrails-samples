#!/usr/bin/env python3
"""
Complete solution: Discover installed mods and generate YAML config
that Terraform can consume dynamically.

Usage:
    ./discover.py                           # Uses default workspace from ~/.config/turbot/credentials.yml
    ./discover.py <workspace>               # Uses specified workspace
    ./discover.py --profile production      # Uses workspace from 'production' profile
    ./discover.py > policies.yaml           # Save to file
"""

import subprocess
import json
import sys
import argparse
import time
from pathlib import Path
from datetime import datetime

# Import inquirer for interactive mode (optional)
try:
    import inquirer
    INQUIRER_AVAILABLE = True
except ImportError:
    INQUIRER_AVAILABLE = False

def get_credentials_config():
    """Load Turbot CLI credentials configuration."""
    config_path = Path.home() / ".config" / "turbot" / "credentials.yml"

    if not config_path.exists():
        return None

    try:
        import yaml
    except ImportError:
        print(f"# Note: PyYAML not installed, cannot read {config_path}", file=sys.stderr)
        print(f"# Install with: pip install -r requirements.txt", file=sys.stderr)
        print(f"# Or specify workspace explicitly: ./discover.py <workspace>", file=sys.stderr)
        return None

    try:
        with open(config_path, 'r') as f:
            config = yaml.safe_load(f)
        return config
    except Exception as e:
        print(f"# Warning: Could not read Turbot credentials config: {e}", file=sys.stderr)
        return None

def get_workspace_from_profile(profile_name):
    """Get workspace from a specific profile in credentials config."""
    config = get_credentials_config()
    if not config:
        return None

    # Try new format first (profiles.profile_name.workspace)
    profiles = config.get('profiles', {})
    if profiles:
        profile = profiles.get(profile_name, {})
        workspace = profile.get('workspace')
        if workspace:
            return workspace.replace('https://', '').replace('http://', '')

    # Fall back to flat format (profile_name.workspace)
    profile = config.get(profile_name, {})
    workspace = profile.get('workspace')

    if not workspace:
        print(f"# Warning: Profile '{profile_name}' not found or has no workspace", file=sys.stderr)
        return None

    # Strip protocol if present
    return workspace.replace('https://', '').replace('http://', '')

def get_default_workspace():
    """Get default workspace from Turbot CLI configuration."""
    config = get_credentials_config()
    if not config:
        return None

    # Try new format first (default -> profiles[default].workspace)
    default_profile = config.get('default')
    if default_profile:
        # Check if default_profile is itself a dict (flat format where 'default' is a profile)
        if isinstance(default_profile, dict):
            workspace = default_profile.get('workspace')
            if workspace:
                return workspace.replace('https://', '').replace('http://', '')

        # Otherwise it's a profile name, look it up
        workspace = get_workspace_from_profile(default_profile)
        if workspace:
            return workspace

    # No default found
    return None

def query_graphql(profile=None, workspace=None, query=None):
    """Execute GraphQL query against workspace.

    Args:
        profile: Profile name to use (takes precedence)
        workspace: Workspace URL (used if no profile)
        query: GraphQL query string
    """
    cmd = ["turbot", "graphql", "--format", "json"]

    if profile:
        cmd.extend(["--profile", profile])
    elif workspace:
        # For explicit workspace, check if there's a matching profile
        # Otherwise turbot CLI might not have credentials
        cmd.extend(["--workspace", workspace])

    cmd.extend(["--query", query])

    result = subprocess.run(
        cmd,
        capture_output=True,
        text=True
    )

    if result.returncode != 0:
        print(f"Error: {result.stderr}", file=sys.stderr)
        if result.stdout:
            print(f"Output: {result.stdout}", file=sys.stderr)
        sys.exit(1)

    try:
        return json.loads(result.stdout)
    except json.JSONDecodeError as e:
        print(f"Error: Failed to parse GraphQL response as JSON: {e}", file=sys.stderr)
        print(f"Response: {result.stdout[:500]}", file=sys.stderr)
        sys.exit(1)

def get_cmdb_policy_types(profile=None, workspace=None):
    """Get all CMDB policy types from installed mods."""

    print(f"# Fetching CMDB policy types...", file=sys.stderr)

    # Fetch CMDB policy types using controlCategoryId filter
    # This is much faster than fetching all policy types
    all_policies = []
    paging = None
    page_count = 0

    while True:
        page_count += 1
        paging_arg = f'\n                paging: "{paging}"' if paging else ""
        query = f"""
            {{
              policyTypes(
                filter: "Cmdb controlCategoryId:\\"tmod:@turbot/turbot#/control/categories/cmdb\\" limit:100"{paging_arg}
              ) {{
                items {{
                  uri
                  title
                  modUri
                }}
                paging {{
                  next
                }}
              }}
            }}
            """

        try:
            data = query_graphql(profile=profile, workspace=workspace, query=query)
            items = data.get("policyTypes", {}).get("items", [])
            all_policies.extend(items)
            print(f"# Fetched page {page_count}: {len(items)} items ({len(all_policies)} total)...", file=sys.stderr)

            # Check if there are more pages
            next_page = data.get("policyTypes", {}).get("paging", {}).get("next")
            if not next_page:
                break
            paging = next_page

            # Add small delay to avoid rate limits
            time.sleep(0.1)

        except Exception as e:
            print(f"# Warning: Error fetching page {page_count}: {e}", file=sys.stderr)
            print(f"# Continuing with {len(all_policies)} policies fetched so far...", file=sys.stderr)
            break

    print(f"# Total CMDB policy types fetched: {len(all_policies)}", file=sys.stderr)
    print(f"# Categorizing policies...", file=sys.stderr)

    # Categorize policies based on title and URI
    critical_keywords = ["Account", "Region", "Organization", "Event Handler"]
    prevention_keywords = ["Service Control Policy", "Resource Control Policy", "SCP", "RCP"]

    categories = {
        "event_handlers": {},
        "prevention_cmdb": {},
        "service_cmdb_skip": {}
    }

    for policy in all_policies:
        uri = policy["uri"]
        title = policy.get("title", "")
        mod_uri = policy.get("modUri", "")

        # Filter for AWS mods only (exclude benchmark mods like aws-cis, aws-nist, etc.)
        if not mod_uri.startswith("tmod:@turbot/aws"):
            continue

        # Skip benchmark mods
        if any(benchmark in mod_uri for benchmark in ["-cis", "-nist", "-pci", "-hipaa", "-soc2"]):
            continue

        # Skip critical infrastructure based on title/URI
        if any(keyword in title for keyword in critical_keywords):
            continue
        if any(keyword in uri.lower() for keyword in ["account", "region", "organization", "eventhandler"]):
            continue

        # Skip Attributes policies (they have different value formats)
        if "attributes" in uri.lower() or "Attributes" in uri:
            continue

        # Categorize prevention-related (SCPs/RCPs)
        if any(keyword in title for keyword in prevention_keywords):
            key = uri.split("/")[-1].replace("Cmdb", "").lower()
            categories["prevention_cmdb"][key] = {
                "type": uri,
                "value": "Enforce: Enabled",
                "note": f"{title}"
            }
        else:
            # Service resources
            key = uri.split("/")[-1].replace("Cmdb", "").lower()
            categories["service_cmdb_skip"][key] = {
                "type": uri,
                "note": f"{title}"
            }
    
    # Add event handlers explicitly
    categories["event_handlers"] = {
        "regional": {
            "type": "tmod:@turbot/aws#/policy/types/eventHandlers",
            "value": "Enforce: Configured",
            "note": "REQUIRED for real-time event processing"
        },
        "global": {
            "type": "tmod:@turbot/aws#/policy/types/eventHandlersGlobal",
            "value": "Enforce: Configured",
            "note": "REQUIRED for global event routing"
        }
    }
    
    return categories

def extract_service_name(policy_uri):
    """Extract service name from policy URI.

    Example: tmod:@turbot/aws-ec2#/policy/types/instanceCmdb -> EC2
    """
    try:
        # Extract the mod portion: @turbot/aws-ec2
        mod_part = policy_uri.split('#')[0].split('/')[-1]  # aws-ec2

        # Remove 'aws-' prefix and capitalize
        if mod_part.startswith('aws-'):
            service = mod_part[4:]  # Remove 'aws-'
            # Convert hyphenated names to proper case (e.g., 'elastic-cache' -> 'ElastiCache')
            parts = service.split('-')
            service = ''.join(word.capitalize() for word in parts)
            return service
        return mod_part.upper()
    except:
        return "Unknown"

def extract_resource_name(policy_uri):
    """Extract resource type name from policy URI.

    Example: tmod:@turbot/aws-ec2#/policy/types/instanceCmdb -> Instance
    """
    try:
        # Get the policy type name from the URI (e.g., "instanceCmdb")
        policy_type = policy_uri.split('/')[-1]

        # Remove "Cmdb" suffix and any other suffixes
        resource_name = policy_type.replace('Cmdb', '').replace('cmdb', '')

        # Handle camelCase by inserting spaces (e.g., "dbInstance" -> "DB Instance")
        import re
        # Insert space before uppercase letters that follow lowercase letters
        resource_name = re.sub(r'([a-z])([A-Z])', r'\1 \2', resource_name)
        # Insert space before uppercase letters that follow multiple uppercase (e.g., "DBInstance" -> "DB Instance")
        resource_name = re.sub(r'([A-Z]+)([A-Z][a-z])', r'\1 \2', resource_name)

        # Capitalize first letter of each word
        resource_name = ' '.join(word.capitalize() for word in resource_name.split())

        return resource_name if resource_name else "Unknown"
    except:
        return "Unknown"

def prompt_interactive_selection(categories):
    """Interactively prompt user to select which policies to keep enabled.

    Returns a set of policy keys that should be kept enabled (commented out in YAML).
    """
    if not INQUIRER_AVAILABLE:
        print("Error: inquirer library not installed", file=sys.stderr)
        print("Install with: pip install -r requirements.txt", file=sys.stderr)
        sys.exit(1)

    service_policies = categories["service_cmdb_skip"]

    if not service_policies:
        print("# No service CMDB policies found to configure", file=sys.stderr)
        return set()

    # Create choices sorted by service name then resource type for better UX
    choices = []
    for key, value in sorted(service_policies.items(), key=lambda x: (extract_service_name(x[1]['type']), extract_resource_name(x[1]['type']))):
        service = extract_service_name(value['type'])
        resource = extract_resource_name(value['type'])
        # Format: "EC2 > Instance CMDB" for clarity
        # Note: inquirer format is (display_label, return_value)
        choices.append((f"{service} > {resource} CMDB", key))

    print("\n" + "=" * 70, file=sys.stderr)
    print("INTERACTIVE POLICY SELECTION", file=sys.stderr)
    print("=" * 70, file=sys.stderr)
    print(f"\nFound {len(service_policies)} service CMDB policies", file=sys.stderr)
    print("\nSelect policies to KEEP ENABLED:", file=sys.stderr)
    print("  - Use arrow keys to navigate", file=sys.stderr)
    print("  - Press SPACE to select/deselect", file=sys.stderr)
    print("  - Press ENTER when done", file=sys.stderr)
    print("\nPolicies NOT selected will be disabled (set to Skip)", file=sys.stderr)
    print("=" * 70 + "\n", file=sys.stderr)

    questions = [
        inquirer.Checkbox(
            'keep_enabled',
            message="Select policies to KEEP ENABLED (use SPACE to select, ENTER when done)",
            choices=choices,
        ),
    ]

    answers = inquirer.prompt(questions)

    if answers is None:
        # User cancelled (Ctrl+C)
        print("\n# Interactive selection cancelled", file=sys.stderr)
        sys.exit(0)

    keep_enabled = set(answers['keep_enabled'])

    print(f"\n# Selected {len(keep_enabled)} policies to keep enabled", file=sys.stderr)
    print(f"# Will disable {len(service_policies) - len(keep_enabled)} policies", file=sys.stderr)

    return keep_enabled

def generate_yaml(workspace, categories, keep_enabled=None):
    """Generate YAML configuration."""
    timestamp = datetime.now().strftime("%Y-%m-%d %H:%M:%S")
    
    yaml = f"""# =============================================================================
# Auto-Generated CMDB Policy Configuration
# =============================================================================
# Workspace: {workspace}
# Generated: {timestamp}
#
# This file was auto-generated by discover_and_generate.py
# It reflects the actual installed mods in the workspace
# =============================================================================

# Critical infrastructure (always enabled)
event_handlers:
"""
    
    for key, value in categories["event_handlers"].items():
        yaml += f"""  {key}:
    type: "{value['type']}"
    value: "{value['value']}"
    note: "{value['note']}"
"""
    
    yaml += """
# Prevention discovery (enabled)
prevention_cmdb:
"""

    if categories["prevention_cmdb"]:
        for key, value in categories["prevention_cmdb"].items():
            yaml += f"""  {key}:
    type: "{value['type']}"
    value: "{value['value']}"
    note: "{value['note']}"
"""
    else:
        yaml += """  {}  # Empty - no prevention policies found
"""

    yaml += """
# Service resource CMDB (disabled for cost)
service_cmdb_skip:
"""

    if keep_enabled is None:
        keep_enabled = set()

    # Separate into kept (commented) and disabled (active) policies
    kept_policies = {k: v for k, v in categories["service_cmdb_skip"].items() if k in keep_enabled}
    disabled_policies = {k: v for k, v in categories["service_cmdb_skip"].items() if k not in keep_enabled}

    # First output commented policies (kept enabled)
    if kept_policies:
        yaml += """
  # =============================================================================
  # Policies below are COMMENTED OUT and will remain ENABLED
  # To disable them later, uncomment and run: terraform apply
  # =============================================================================

"""
        for key, value in sorted(kept_policies.items()):
            yaml += f"""  # {key}:
  #   type: "{value['type']}"
  #   note: "{value['note']}"

"""

    # Then output active policies (will be disabled)
    if disabled_policies:
        if kept_policies:
            yaml += """  # =============================================================================
  # Policies below will be DISABLED (set to Skip)
  # To re-enable them later, comment out and run: terraform apply
  # =============================================================================

"""
        for key, value in sorted(disabled_policies.items()):
            yaml += f"""  {key}:
    type: "{value['type']}"
    note: "{value['note']}"
"""

    return yaml

def main():
    parser = argparse.ArgumentParser(
        description='Discover installed mods and generate YAML config for Terraform',
        formatter_class=argparse.RawDescriptionHelpFormatter,
        epilog="""
Examples:
  ./discover.py                        # Use default workspace, writes to policies.yaml
  ./discover.py --profile production   # Use profile, writes to policies.yaml
  ./discover.py -i                     # Interactive mode, writes to policies.yaml
  ./discover.py -i -p production       # Interactive with profile
  ./discover.py -o custom.yaml         # Write to different file

To set a default workspace:
  turbot workspace set <workspace>
        """
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
    parser.add_argument(
        '--interactive', '-i',
        action='store_true',
        help='Interactively select which policies to keep enabled (requires inquirer library)'
    )
    parser.add_argument(
        '--output', '-o',
        default='cmdb-policies.yaml',
        help='Output file path (default: cmdb-policies.yaml)'
    )

    args = parser.parse_args()

    # Track both profile and workspace
    # Precedence: --profile > explicit workspace > default profile
    profile = None
    workspace = None

    if args.profile:
        # Use specified profile
        profile = args.profile
        workspace = get_workspace_from_profile(profile)
        if not workspace:
            print(f"Error: Could not get workspace from profile '{profile}'", file=sys.stderr)
            sys.exit(1)
    elif args.workspace:
        # Use explicit workspace argument (no profile)
        workspace = args.workspace
    else:
        # Try default profile from config
        config = get_credentials_config()
        if config:
            default_profile = config.get('default')
            if default_profile and isinstance(default_profile, dict):
                # Flat format: 'default' is itself a profile
                profile = 'default'
                workspace = default_profile.get('workspace', '').replace('https://', '').replace('http://', '')
            elif default_profile:
                # New format: 'default' points to a profile name
                profile = default_profile
                workspace = get_workspace_from_profile(profile)

    if not workspace:
        print("Error: No workspace specified and no default workspace found", file=sys.stderr)
        print("", file=sys.stderr)
        print("Usage:", file=sys.stderr)
        print("  ./discover.py                           # Uses default from ~/.config/turbot/credentials.yml", file=sys.stderr)
        print("  ./discover.py <workspace>               # Uses specified workspace", file=sys.stderr)
        print("  ./discover.py --profile production      # Uses workspace from profile", file=sys.stderr)
        print("", file=sys.stderr)
        print("To set a default workspace:", file=sys.stderr)
        print("  turbot workspace set <workspace>", file=sys.stderr)
        sys.exit(1)

    print(f"# Using workspace: {workspace}", file=sys.stderr)
    if profile:
        print(f"# Using profile: {profile}", file=sys.stderr)
    print(f"# Discovering CMDB policies...", file=sys.stderr)
    categories = get_cmdb_policy_types(profile=profile, workspace=workspace)

    prevention_count = len(categories["prevention_cmdb"])
    service_count = len(categories["service_cmdb_skip"])
    print(f"# Found {prevention_count} prevention policies, {service_count} service policies", file=sys.stderr)

    # Interactive mode - let user select which policies to keep enabled
    keep_enabled = None
    if args.interactive:
        keep_enabled = prompt_interactive_selection(categories)

    print(f"# Generating YAML...", file=sys.stderr)
    yaml_output = generate_yaml(workspace, categories, keep_enabled=keep_enabled)

    # Write output to file (default: policies.yaml)
    try:
        with open(args.output, 'w') as f:
            f.write(yaml_output)
        print(f"# Written to: {args.output}", file=sys.stderr)
    except Exception as e:
        print(f"Error writing to file {args.output}: {e}", file=sys.stderr)
        sys.exit(1)

    print(f"", file=sys.stderr)
    print(f"# Generated successfully!", file=sys.stderr)
    print(f"#", file=sys.stderr)
    print(f"# Next steps:", file=sys.stderr)
    print(f"#   1. Review the generated file: cat {args.output}", file=sys.stderr)
    print(f"#   2. Customize if needed (edit {args.output})", file=sys.stderr)
    print(f"#   3. Deploy: terraform init && terraform plan && terraform apply", file=sys.stderr)

if __name__ == "__main__":
    main()
