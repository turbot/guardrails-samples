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
from pathlib import Path
from datetime import datetime

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
    cmd = ["turbot", "graphql"]

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
        sys.exit(1)

    return json.loads(result.stdout)

def get_cmdb_policy_types(profile=None, workspace=None):
    """Get all CMDB policy types from installed mods."""
    query = """
    {
      policyTypes(filter: "title:CMDB modType:aws") {
        items {
          uri
          title
          mod {
            uri
            title
          }
          parent {
            trunk {
              title
            }
          }
        }
      }
    }
    """

    data = query_graphql(profile=profile, workspace=workspace, query=query)
    
    # Categorize policies
    critical_keywords = ["Account", "Region", "Organization", "Event Handler"]
    prevention_keywords = ["Service Control Policy", "Resource Control Policy"]
    
    categories = {
        "event_handlers": {},
        "prevention_cmdb": {},
        "service_cmdb_skip": {}
    }
    
    for policy in data["policyTypes"]["items"]:
        resource_path = " > ".join([t["title"] for t in policy["parent"]["trunk"]])
        uri = policy["uri"]
        
        # Skip critical infrastructure
        if any(keyword in resource_path for keyword in critical_keywords):
            continue
        
        # Categorize prevention-related
        if any(keyword in resource_path for keyword in prevention_keywords):
            key = uri.split("/")[-1].replace("Cmdb", "").lower()
            categories["prevention_cmdb"][key] = {
                "type": uri,
                "value": "Enforce: Enabled",
                "note": f"{resource_path}"
            }
        else:
            # Service resources
            key = uri.split("/")[-1].replace("Cmdb", "").lower()
            categories["service_cmdb_skip"][key] = {
                "type": uri,
                "note": f"{resource_path}"
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

def generate_yaml(workspace, categories):
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
    
    for key, value in categories["prevention_cmdb"].items():
        yaml += f"""  {key}:
    type: "{value['type']}"
    value: "{value['value']}"
    note: "{value['note']}"
"""
    
    yaml += """
# Service resource CMDB (disabled for cost)
service_cmdb_skip:
"""
    
    for key, value in categories["service_cmdb_skip"].items():
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
  ./discover.py                                # Use default workspace from credentials
  ./discover.py myworkspace.turbot.com         # Use specific workspace
  ./discover.py --profile production           # Use workspace from 'production' profile
  ./discover.py > policies.yaml                # Save output to file

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
    print(f"# Generating YAML...", file=sys.stderr)

    yaml_output = generate_yaml(workspace, categories)
    print(yaml_output)

    print(f"", file=sys.stderr)
    print(f"# Generated successfully!", file=sys.stderr)
    print(f"#", file=sys.stderr)
    print(f"# Next steps:", file=sys.stderr)
    print(f"#   1. Review the generated output", file=sys.stderr)
    print(f"#   2. Save to file: ./discover.py > policies.yaml", file=sys.stderr)
    print(f"#   3. Customize if needed (edit policies.yaml)", file=sys.stderr)
    print(f"#   4. Deploy: terraform init && terraform plan && terraform apply", file=sys.stderr)

if __name__ == "__main__":
    main()
