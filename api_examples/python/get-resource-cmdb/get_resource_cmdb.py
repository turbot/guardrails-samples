import os
import click
import requests
import json
import sys
import yaml
from base64 import b64encode
from xdg import XDG_CONFIG_HOME


GRAPHQL_PATH = 'api/latest/graphql'
_json_mode = False


def log(msg):
    """Print status messages to stderr in JSON mode, stdout otherwise."""
    if _json_mode:
        print(msg, file=sys.stderr)
    else:
        print(msg)

PROVIDER_PREFIXES = {
    'aws': ['arn:aws:'],
    'azure': ['azure:///'],
    'gcp': ['//compute.googleapis.com/', '//storage.googleapis.com/', '//container.googleapis.com/'],
    'oci': ['ocid1.'],
}

RESOURCE_BY_AKA_QUERY = '''
  query GetResource($id: ID!) {
    resource(id: $id) {
      turbot {
        id
        title
        akas
        createTimestamp
        updateTimestamp
        resourceTypeId
        parentId
        path
        tags
      }
      type {
        title
        uri
      }
      data
    }
  }
'''

RESOURCE_BY_FILTER_QUERY = '''
  query FindResource($filter: [String!]!) {
    resources(filter: $filter) {
      items {
        turbot {
          id
          title
          akas
          createTimestamp
          updateTimestamp
          resourceTypeId
          parentId
          path
          tags
        }
        type {
          title
          uri
        }
        data
      }
    }
  }
'''

VALIDATE_RESOURCE_TYPE_QUERY = '''
  query ValidateResourceType($id: ID!) {
    resourceType(id: $id) {
      title
      uri
    }
  }
'''


def load_config(config_path=None):
    """Load the workspace configuration file."""
    if config_path is None:
        config_path = os.path.join(os.path.dirname(os.path.abspath(__file__)), '.config')

    if not os.path.exists(config_path):
        print("Config file not found: {}".format(config_path))
        print("Copy .config.example to .config and edit it with your workspace details.")
        sys.exit(1)

    with open(config_path, 'r') as f:
        config = yaml.safe_load(f)

    if not config or 'workspaces' not in config:
        print("Invalid config file: missing 'workspaces' key.")
        sys.exit(1)

    return config['workspaces']


def detect_provider(identifier):
    """Detect the cloud provider from an AKA or resource type URI."""
    for provider, prefixes in PROVIDER_PREFIXES.items():
        for prefix in prefixes:
            if identifier.startswith(prefix):
                return provider
    # Check resource type URIs like tmod:@turbot/aws-ec2#...
    if 'aws' in identifier.lower().split('#')[0]:
        return 'aws'
    if 'azure' in identifier.lower().split('#')[0]:
        return 'azure'
    if 'gcp' in identifier.lower().split('#')[0]:
        return 'gcp'
    if 'oci' in identifier.lower().split('#')[0]:
        return 'oci'
    return None


def create_session(workspace):
    """Create an authenticated requests.Session for a workspace.

    Returns (endpoint, session) where session has auth headers pre-configured.
    Credentials are encapsulated in the session and not exposed to callers.
    """
    auth = workspace.get('auth', 'profile')
    url = workspace['url'].rstrip('/')

    if auth == 'profile':
        profile_name = workspace.get('profile', 'default')
        turbot_config = "{}/turbot/credentials.yml".format(XDG_CONFIG_HOME)
        if not os.path.exists(turbot_config):
            raise ValueError("Credentials file not found: {}".format(turbot_config))
        with open(turbot_config, 'r') as f:
            creds = yaml.safe_load(f)
        if profile_name not in creds:
            raise ValueError("Profile '{}' not found in credentials file".format(profile_name))
        access_key = creds[profile_name]['accessKey']
        secret_key = creds[profile_name]['secretKey']

    elif auth == 'keys':
        access_key = workspace.get('access_key')
        secret_key = workspace.get('secret_key')
        if not access_key or not secret_key:
            raise ValueError("Workspace '{}' uses auth:keys but missing access_key or secret_key".format(
                workspace['name']))

    elif auth == 'env':
        ak_var = workspace.get('access_key_var', 'TURBOT_ACCESS_KEY_ID')
        sk_var = workspace.get('secret_key_var', 'TURBOT_SECRET_ACCESS_KEY')
        access_key = os.getenv(ak_var)
        secret_key = os.getenv(sk_var)
        if not access_key or not secret_key:
            raise ValueError("Auth type 'env' requires {} and {} environment variables".format(ak_var, sk_var))

    else:
        raise ValueError("Unknown auth type: {}".format(auth))

    endpoint = "{}/{}".format(url, GRAPHQL_PATH)
    auth_bytes = '{}:{}'.format(access_key, secret_key).encode("utf-8")
    token = b64encode(auth_bytes).decode()

    session = requests.Session()
    session.headers.update({'Authorization': 'Basic {}'.format(token)})

    # Clear credential variables
    del access_key, secret_key, token  # noqa: F821

    return endpoint, session


def run_graphql(endpoint, session, query, variables):
    """Execute a GraphQL query using an authenticated session."""
    response = session.post(
        endpoint,
        json={'query': query, 'variables': variables}
    )
    if response.status_code != 200:
        raise Exception("HTTP {}".format(response.status_code))
    return response.json()


def validate_resource_type(endpoint, session, resource_type):
    """Validate that a resource type URI exists in the workspace. Returns the type title or None."""
    result = run_graphql(endpoint, session, VALIDATE_RESOURCE_TYPE_QUERY, {'id': resource_type})
    if "errors" in result:
        return None
    rt = result.get('data', {}).get('resourceType')
    if rt:
        return rt.get('title')
    return None


def query_by_aka(endpoint, session, aka):
    """Look up a resource by AKA. Returns the resource dict or None."""
    result = run_graphql(endpoint, session, RESOURCE_BY_AKA_QUERY, {'id': aka})
    if "errors" in result:
        return None
    return result['data']['resource']


def query_by_filter(endpoint, session, resource_id, resource_type):
    """Look up a resource by resource ID and type using a filter query. Returns the resource dict or None."""
    filter_str = "resourceTypeId:'{}' {} limit:1".format(resource_type, resource_id)
    result = run_graphql(endpoint, session, RESOURCE_BY_FILTER_QUERY, {'filter': filter_str})
    if "errors" in result:
        return None
    items = result['data']['resources']['items']
    if items:
        return items[0]
    return None


def format_resource(resource, ws_name, ws_url):
    """Format a resource for display. Returns a string."""
    lines = []
    lines.append("--- Resource Summary ---")
    lines.append("Workspace:     {} ({})".format(ws_name, ws_url))
    lines.append("Turbot ID:     {}".format(resource['turbot']['id']))
    lines.append("Title:         {}".format(resource['turbot']['title']))
    lines.append("Type:          {} ({})".format(resource['type']['title'], resource['type']['uri']))
    lines.append("Created:       {}".format(resource['turbot']['createTimestamp']))
    lines.append("Updated:       {}".format(resource['turbot']['updateTimestamp']))
    lines.append("AKAs:          {}".format(', '.join(resource['turbot']['akas'])))

    if resource['turbot'].get('tags'):
        lines.append("\n--- Tags ---")
        for key, value in resource['turbot']['tags'].items():
            lines.append("  {}: {}".format(key, value))

    lines.append("\n--- CMDB Data ---")
    lines.append(json.dumps(resource['data'], indent=2))
    return '\n'.join(lines)


def format_json(resource, ws_name, ws_url):
    """Format a resource as JSON. Returns a string."""
    output = {
        '_workspace': ws_name,
        '_url': ws_url,
        'turbot': resource['turbot'],
        'type': resource['type'],
        'data': resource['data'],
    }
    return json.dumps(output, indent=2)


@click.command()
@click.option('-c', '--config-file', type=click.Path(dir_okay=False), help="Path to workspace config file. Default: .config")
@click.option('-w', '--workspace', help="Search only this workspace (by name from config).")
@click.option('-a', '--aka', help="The AKA (e.g. ARN) of the resource to look up.")
@click.option('-r', '--resource-id', help="The cloud resource ID (e.g. i-01dcb5c09e8f46d28). Requires --resource-type.")
@click.option('-t', '--resource-type', help="The Guardrails resource type URI (e.g. tmod:@turbot/aws-ec2#/resource/types/instance).")
@click.option('--json-output', is_flag=True, help="Output raw JSON instead of formatted text.")
def get_resource_cmdb(config_file, workspace, aka, resource_id, resource_type, json_output):
    """Look up a Guardrails CMDB resource by AKA or by resource ID + type.

    \b
    Two lookup modes:
      --aka                     Direct lookup by AKA (e.g. ARN). Fast, single API call.
      --resource-id + --resource-type  Filter-based lookup by cloud resource ID and type.

    \b
    Examples:
      python3 get_resource_cmdb.py --aka "arn:aws:ec2:us-east-1:123456789012:instance/i-abc123"
      python3 get_resource_cmdb.py --resource-id i-abc123 --resource-type tmod:@turbot/aws-ec2#/resource/types/instance
    """

    global _json_mode
    _json_mode = json_output

    # Validate options
    if aka and (resource_id or resource_type):
        log("Error: --aka and --resource-id/--resource-type are mutually exclusive.")
        sys.exit(1)

    if not aka and not resource_id:
        log("Error: Provide either --aka or --resource-id with --resource-type.")
        sys.exit(1)

    if resource_id and not resource_type:
        log("Error: --resource-id requires --resource-type.")
        log("Browse resource types at: https://hub.guardrails.turbot.com")
        sys.exit(1)

    if resource_type and not resource_id:
        log("Error: --resource-type requires --resource-id.")
        sys.exit(1)

    use_filter = bool(resource_id)

    workspaces = load_config(config_file)

    # Filter to a single workspace if --workspace is specified
    if workspace:
        matches = [w for w in workspaces if w['name'] == workspace]
        if not matches:
            available = ', '.join(w['name'] for w in workspaces)
            log("Workspace '{}' not found in config. Available: {}".format(workspace, available))
            sys.exit(1)
        workspaces = matches

    # Detect provider and filter workspaces
    identifier = aka or resource_type
    provider = detect_provider(identifier)
    if provider and not workspace:
        original_count = len(workspaces)
        workspaces = [w for w in workspaces if provider in w.get('providers', [])]
        if not workspaces:
            log("No workspaces configured for provider '{}'. Check your .config file.".format(provider))
            sys.exit(1)
        skipped = original_count - len(workspaces)
        if skipped > 0:
            log("Detected {} resource, skipping {} non-{} workspace(s).".format(
                provider.upper(), skipped, provider))

    # Search workspaces in order
    for ws in workspaces:
        name = ws['name']

        try:
            endpoint, session = create_session(ws)
        except ValueError as e:
            log("[{}] Skipping: {}".format(name, e))
            continue

        log("[{}] Searching {}...".format(name, ws['url']))

        # Validate resource type if using filter mode
        if use_filter:
            type_title = validate_resource_type(endpoint, session, resource_type)
            if type_title is None:
                log("[{}] Resource type '{}' not found. It may not be installed in this workspace.".format(
                    name, resource_type))
                log("    Browse available types at: https://hub.guardrails.turbot.com")
                continue

        try:
            if use_filter:
                resource = query_by_filter(endpoint, session, resource_id, resource_type)
            else:
                resource = query_by_aka(endpoint, session, aka)
        except Exception as e:
            log("[{}] Error: {}".format(name, e))
            continue

        if resource:
            if not json_output:
                log("[{}] Found!\n".format(name))
            print(format_json(resource, name, ws['url']) if json_output
                  else format_resource(resource, name, ws['url']))
            return

    # Not found in any workspace
    if json_output:
        err = {"error": "not_found"}
        if aka:
            err["aka"] = aka
        else:
            err["resource_id"] = resource_id
            err["resource_type"] = resource_type
        print(json.dumps(err, indent=2))
    else:
        if aka:
            log("\nNo resource found matching AKA: {}".format(aka))
        else:
            log("\nNo resource found matching ID '{}' with type '{}'.".format(resource_id, resource_type))
        log("Searched {} workspace(s).".format(len(workspaces)))
    sys.exit(1)


if __name__ == "__main__":
    if (sys.version_info > (3, 4)):
        try:
            get_resource_cmdb()
        except Exception as e:
            print(e)
    else:
        print("This script requires Python v3.5+")
