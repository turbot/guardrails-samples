#!/usr/bin/env python
import csv
import os
from base64 import b64encode
from datetime import datetime, timedelta

import click
import requests
import yaml

CMDB_CATEGORY = "tmod:@turbot/turbot#/control/categories/cmdb"
DISCOVERY_CATEGORY = "tmod:@turbot/turbot#/control/categories/cmdbDiscovery"
UNKNOWN = "(uninstalled or unknown)"

USAGE_QUERY = '''
query ControlUsages($filter: [String!]!, $paging: String) {
  list: controlUsagesByControlType(filter: $filter, paging: $paging) {
    items {
      type { uri }
      summary { activeControlDays }
    }
    paging { next }
  }
}
'''

CONTROL_TYPES_QUERY = '''
query ControlTypes($filter: [String!]!, $paging: String) {
  list: controlTypes(filter: $filter, paging: $paging) {
    items {
      uri
      turbot { id parentId }
    }
    paging { next }
  }
}
'''

RESOURCE_TYPES_QUERY = '''
query ResourceTypes($filter: [String!]!, $paging: String) {
  list: resourceTypes(filter: $filter, paging: $paging) {
    items {
      uri
      modUri
      trunk { title }
    }
    paging { next }
  }
}
'''


def load_config(config_file, profile):
    """ Returns (graphql_endpoint, auth_token) from environment variables or a Turbot credentials file. """
    if not config_file and os.getenv("TURBOT_ACCESS_KEY_ID") and os.getenv("TURBOT_SECRET_ACCESS_KEY"):
        workspace = os.getenv("TURBOT_WORKSPACE")
        if not workspace:
            raise click.ClickException("TURBOT_WORKSPACE must be set when using environment variable credentials.")
        access_key = os.getenv("TURBOT_ACCESS_KEY_ID")
        secret_key = os.getenv("TURBOT_SECRET_ACCESS_KEY")
    else:
        config_file = config_file or os.path.join(
            os.getenv("XDG_CONFIG_HOME", os.path.expanduser("~/.config")), "turbot", "credentials.yml")
        if not os.path.exists(config_file):
            raise click.ClickException(f"Credentials file not found: {config_file}")
        with open(config_file) as stream:
            config = yaml.safe_load(stream) or {}
        if profile not in config:
            raise click.ClickException(f"Profile '{profile}' not found in {config_file}")
        profile_config = config[profile]
        if not all(k in profile_config for k in ("workspace", "accessKey", "secretKey")):
            raise click.ClickException(f"Profile '{profile}' must define workspace, accessKey and secretKey.")
        workspace = profile_config["workspace"]
        access_key = profile_config["accessKey"]
        secret_key = profile_config["secretKey"]

    endpoint = "{}/api/latest/graphql".format(workspace.rstrip("/"))
    auth_token = b64encode(f"{access_key}:{secret_key}".encode("utf-8")).decode()
    return endpoint, auth_token


def fetch_all(session, endpoint, query, filter):
    """ Runs a paginated list query and returns all items. """
    items = []
    paging = None
    while True:
        response = session.post(endpoint, json={'query': query, 'variables': {'filter': filter, 'paging': paging}})
        response.raise_for_status()
        result = response.json()
        if "errors" in result:
            messages = "; ".join(error['message'] for error in result["errors"])
            raise click.ClickException(f"GraphQL query failed: {messages}")
        items.extend(result['data']['list']['items'])
        paging = result['data']['list']['paging']['next']
        if not paging:
            return items


@click.command()
@click.option('-c', '--config-file', type=click.Path(dir_okay=False), help="[String] Pass an optional yaml config file.")
@click.option('-p', '--profile', default="default", help="[String] Profile to be used from config file.")
@click.option('-d', '--date', help="[String] Usage date in YYYYMMDD format. Defaults to yesterday.")
@click.option('-o', '--output', help="[String] Output CSV file. Defaults to control_usage_by_resource_type_<date>.csv.")
@click.option('-i', '--insecure', is_flag=True, help="Disable SSL certificate verification.")
def control_usage_by_resource_type(config_file, profile, date, output, insecure):
    """ Writes a CSV of active control counts per resource type, split into CMDB and non-CMDB controls. """
    if date:
        try:
            usage_date = datetime.strptime(date, "%Y%m%d")
        except ValueError:
            raise click.BadParameter("Date must be in YYYYMMDD format.", param_hint="--date")
    else:
        usage_date = datetime.now() - timedelta(days=1)
    date_label = usage_date.strftime("%Y-%m-%d")
    output = output or f"control_usage_by_resource_type_{usage_date.strftime('%Y%m%d')}.csv"

    endpoint, auth_token = load_config(config_file, profile)

    session = requests.Session()
    session.headers.update({'Authorization': f'Basic {auth_token}'})
    session.verify = not insecure
    if insecure:
        requests.packages.urllib3.disable_warnings()

    print(f"Fetching control usage for {date_label} from {endpoint} ...")
    usage = fetch_all(session, endpoint, USAGE_QUERY, f"timestamp:{usage_date.strftime('%Y%m%d')}2359 limit:300")

    print("Fetching control types ...")
    control_types = fetch_all(session, endpoint, CONTROL_TYPES_QUERY, "limit:1000")
    cmdb_uris = {item['uri'] for item in fetch_all(
        session, endpoint, CONTROL_TYPES_QUERY, f"controlCategoryId:'{CMDB_CATEGORY}' limit:1000")}
    discovery_uris = {item['uri'] for item in fetch_all(
        session, endpoint, CONTROL_TYPES_QUERY, f"controlCategoryId:'{DISCOVERY_CATEGORY}' limit:1000")}

    print("Fetching resource types ...")
    resource_types = fetch_all(session, endpoint, RESOURCE_TYPES_QUERY, "limit:1000")

    # Start every installed resource type at zero so types with no active controls still appear
    rows = {}
    for resource_type in resource_types:
        rows[resource_type['uri']] = {
            'mod': resource_type['modUri'].replace("tmod:", "", 1),
            'title': resource_type['trunk']['title'] if resource_type['trunk'] else resource_type['uri'],
            'uri': resource_type['uri'],
            'total': 0,
            'cmdb': 0,
            'discovery': 0,
            'non_cmdb': 0,
        }

    # The control type hierarchy nests control types (and sub-controls) under their resource type,
    # so walk up the parents until we reach a resource type
    control_types_by_id = {item['turbot']['id']: item for item in control_types}

    def resource_type_for(control_type):
        while control_type and "#/resource/types/" not in control_type['uri']:
            control_type = control_types_by_id.get(control_type['turbot']['parentId'])
        return control_type['uri'] if control_type else None

    resource_type_by_control_type = {item['uri']: resource_type_for(item) for item in control_types}

    for item in usage:
        active = item['summary']['activeControlDays'] or 0
        if not active:
            continue
        control_type_uri = item['type']['uri']
        resource_type_uri = resource_type_by_control_type.get(control_type_uri)
        if resource_type_uri not in rows:
            # Control type has been uninstalled since the usage date
            resource_type_uri = UNKNOWN
            rows.setdefault(UNKNOWN, {
                'mod': UNKNOWN, 'title': UNKNOWN, 'uri': UNKNOWN,
                'total': 0, 'cmdb': 0, 'discovery': 0, 'non_cmdb': 0,
            })
        row = rows[resource_type_uri]
        row['total'] += active
        if control_type_uri in cmdb_uris:
            row['cmdb'] += active
            if control_type_uri in discovery_uris:
                row['discovery'] += active
        else:
            row['non_cmdb'] += active

    with open(output, 'w', newline='') as outfile:
        writer = csv.writer(outfile)
        writer.writerow(['Date', 'Mod', 'Resource Type', 'Resource Type URI', 'Active Controls',
                         'Active CMDB Controls', 'Active Discovery Controls', 'Active Non-CMDB Controls'])
        for row in sorted(rows.values(), key=lambda r: (r['mod'], r['title'])):
            writer.writerow([date_label, row['mod'], row['title'], row['uri'], row['total'],
                             row['cmdb'], row['discovery'], row['non_cmdb']])

    total_active = sum(row['total'] for row in rows.values())
    print(f"\nWrote {len(rows)} resource types ({total_active} active controls) to {output}")


if __name__ == '__main__':
    control_usage_by_resource_type()
