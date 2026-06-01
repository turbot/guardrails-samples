import turbot
import click
import csv
import requests
import sys
import time


CSP_RESOURCE_TYPE_IDS = {
    'aws':   'tmod:@turbot/aws#/resource/types/aws',
    'azure': 'tmod:@turbot/azure#/resource/types/azure',
    'gcp':   'tmod:@turbot/gcp#/resource/types/gcp',
}

NOTIFICATION_QUERY = '''
  query ActivityLedger($filter: [String!], $paging: String) {
    notifications(filter: $filter, paging: $paging, dataSource: DB) {
      metadata {
        stats {
          total
        }
      }
      paging {
        next
      }
      items {
        notificationType
        message
        turbot {
          id
          processId
          createTimestamp
        }
        actor {
          identity {
            title
          }
        }
        resource {
          trunk {
            title
          }
          turbot {
            id
            title
            akas
          }
          type {
            trunk {
              title
            }
            uri
          }
        }
      }
    }
  }
'''


def fmt_duration(seconds):
    if seconds < 60:
        return "{}s".format(int(seconds))
    elif seconds < 3600:
        return "{}m {}s".format(int(seconds // 60), int(seconds % 60))
    else:
        return "{}h {}m".format(int(seconds // 3600), int((seconds % 3600) // 60))


def run_query(endpoint, headers, query, variables):
    request = requests.post(
        endpoint,
        headers=headers,
        json={'query': query, 'variables': variables}
    )
    if request.status_code == 200:
        return request.json()
    else:
        raise Exception("Query failed with HTTP {}".format(request.status_code))


def get_turbot_identity_id(endpoint, headers):
    """Look up the Turbot Identity actor ID for this workspace."""
    query = '''
      query GetTurbotIdentity($filter: [String!]) {
        resources(filter: $filter) {
          items {
            turbot {
              id
              title
            }
          }
        }
      }
    '''
    variables = {"filter": ["resourceTypeId:'tmod:@turbot/turbot-iam#/resource/types/turbotIdentity' limit:1"]}
    result = run_query(endpoint, headers, query, variables)
    if "errors" in result:
        return None
    items = result.get('data', {}).get('resources', {}).get('items', [])
    if not items:
        return None
    return str(items[0]['turbot']['id'])


@click.command()
@click.option('-c', '--config-file', type=click.Path(dir_okay=False), help="[String] Pass an optional yaml config file.")
@click.option('-p', '--profile', default="default", help="[String] Profile to be used from config file.")
@click.option('--days', default=7, type=int, show_default=True, help="[Int] Fetch activity from the last N days. e.g. 90. Mutually exclusive with --hours.")
@click.option('--hours', default=None, type=int, help="[Int] Fetch activity from the last N hours. e.g. 24. Mutually exclusive with --days.")
@click.option('--actor-id', default=None, help="[String] Filter by a specific actor identity ID. Defaults to the Turbot Identity for this workspace.")
@click.option('--all-actors', is_flag=True, default=False, help="Include activity from all actors, not just Turbot Identity.")
@click.option('--csp', default=None, type=click.Choice(['aws', 'azure', 'gcp'], case_sensitive=False), help="[String] Limit to a cloud provider's resources: aws, azure, or gcp. Mutually exclusive with --resource-type.")
@click.option('--resource-type', default=None, help="[String] Filter by resource type IDs, comma-separated. Takes precedence over --csp. e.g. 'tmod:@turbot/aws#/resource/types/aws,tmod:@turbot/azure#/resource/types/azure'")
@click.option('--page-size', default=500, type=int, show_default=True, help="[Int] Number of notifications per API request. Default: 500.")
@click.option('-o', '--output', default="activity_ledger.csv", help="[String] Output CSV file path. Default: activity_ledger.csv")
def activity_ledger_export(config_file, profile, days, hours, actor_id, all_actors,
                           csp, resource_type, page_size, output):
    """Exports Turbot activity (action notifications) for the past N days or hours to a CSV file.

    Bypasses the 30-day / 5000-row limits of the Activity Ledger UI by paginating
    through all results via the GraphQL API.

    By default, results are filtered to the Turbot Identity actor (automated Turbot
    actions only). Use --all-actors to include actions by human users as well.
    """

    if hours:
        if days != 7:
            raise click.UsageError("--days and --hours are mutually exclusive. Use one or the other.")
        time_filter = "timestamp:>=T-{}h".format(hours)
        window_label = "last {} hours".format(hours)
    else:
        time_filter = "timestamp:>=T-{}h".format(days * 24)
        window_label = "last {} days".format(days)

    if actor_id and all_actors:
        raise click.UsageError("--actor-id and --all-actors are mutually exclusive.")

    script_start = time.time()

    config = turbot.Config(config_file, profile)
    headers = {'Authorization': 'Basic {}'.format(config.auth_token)}
    endpoint = config.graphql_endpoint
    workspace_url = config.workspace.rstrip('/')

    # Resolve actor filter: explicit ID > auto-lookup Turbot Identity > all actors
    if not all_actors:
        if not actor_id:
            print("Looking up Turbot Identity actor ID...")
            actor_id = get_turbot_identity_id(endpoint, headers)
            if actor_id:
                print("  Turbot Identity ID: {}".format(actor_id))
            else:
                print("  Warning: Could not resolve Turbot Identity. Falling back to all actors.")

    filter_parts = [
        "notificationType:action_notify",
        time_filter,
        "limit:{}".format(page_size),
    ]

    if resource_type:
        type_ids = [t.strip() for t in resource_type.split(',')]
        filter_parts.append("resourceTypeId:{}".format(','.join(type_ids)))
    elif csp:
        filter_parts.append("resourceTypeId:{}".format(CSP_RESOURCE_TYPE_IDS[csp.lower()]))

    if actor_id:
        filter_parts.append("actorIdentityId:'{}'".format(actor_id))

    print("\nFetching Turbot activity for the {}...".format(window_label))
    if actor_id:
        print("  Actor filter         : {}".format(actor_id))
    elif all_actors:
        print("  Actor filter         : all actors")
    if resource_type or csp:
        print("  Resource type filter : {}".format(resource_type or CSP_RESOURCE_TYPE_IDS[csp.lower()]))

    items = []
    paging = None
    total_reported = None
    fetch_start = time.time()

    while True:
        variables = {'filter': filter_parts, 'paging': paging}
        result = run_query(endpoint, headers, NOTIFICATION_QUERY, variables)

        if "errors" in result:
            for error in result['errors']:
                print("Error: {}".format(error.get('message', error)))
            sys.exit(1)

        data = result['data']['notifications']

        if total_reported is None:
            total_reported = data.get('metadata', {}).get('stats', {}).get('total', 0)
            print("  Total notifications  : {:,}\n".format(total_reported))

        batch = data['items']
        items.extend(batch)

        elapsed = time.time() - fetch_start
        rate = len(items) / elapsed if elapsed > 0 else 0
        eta = ((total_reported - len(items)) / rate) if rate > 0 and total_reported > len(items) else 0
        print("  Fetched {:>8,} / {:>8,}  |  {:.0f}/s  |  elapsed: {}  |  ETA: {}".format(
            len(items), total_reported,
            rate,
            fmt_duration(elapsed),
            fmt_duration(eta) if eta > 0 else "done"
        ))

        next_page = data['paging']['next'] if data.get('paging') else None
        if not next_page:
            break
        paging = next_page

    fetch_elapsed = time.time() - fetch_start
    print("\nFetched {:,} notification(s) in {}.".format(len(items), fmt_duration(fetch_elapsed)))

    if total_reported and len(items) < total_reported * 0.95:
        print("  Note: {:,} of {:,} total notifications were returned by the API.".format(
            len(items), total_reported))
        print("  This may reflect an API cache limit for short time windows. For complete")
        print("  results, use a longer time range (--days 30 or more).")

    if not items:
        print("No activity found for the specified filters.")
        return

    print("Sorting results...")
    items.sort(key=lambda x: x['turbot']['createTimestamp'], reverse=True)

    rows = []
    for item in items:
        resource = item.get('resource') or {}
        resource_turbot = resource.get('turbot') or {}
        resource_type_data = resource.get('type') or {}
        akas = resource_turbot.get('akas') or []
        resource_trunk = (resource.get('trunk') or {}).get('title') or ''
        resource_type_trunk = (resource_type_data.get('trunk') or {}).get('title') or ''

        actor = item.get('actor') or {}
        identity = actor.get('identity') or {}
        actor_title = identity.get('title') or ''

        notification_id = item['turbot']['id']
        process_id = item['turbot'].get('processId') or ''
        detail_link = "{}/apollo/processes/{}/notifications/{}".format(
            workspace_url, process_id, notification_id
        ) if process_id else ''

        rows.append({
            'notification_id':  str(notification_id),
            'timestamp':        item['turbot']['createTimestamp'],
            'actor':            actor_title,
            'message':          item.get('message') or '',
            'resource_aka':     akas[0] if akas else '',
            'resource_title':   resource_turbot.get('title', ''),
            'resource_type':    resource_type_trunk,
            'resource_trunk':   resource_trunk,
            'detail_link':      detail_link,
        })

    # Print preview table
    preview_cols = ['timestamp', 'actor', 'message', 'resource_aka']
    col_headers = {
        'timestamp':    'Timestamp',
        'actor':        'Actor',
        'message':      'Message',
        'resource_aka': 'Resource AKA',
    }
    col_widths = {}
    for col in preview_cols:
        col_widths[col] = max(
            len(col_headers[col]),
            max((len(str(row[col])[:60]) for row in rows), default=0)
        )

    header_line = "  ".join(col_headers[col].ljust(col_widths[col]) for col in preview_cols)
    separator   = "  ".join("-" * col_widths[col] for col in preview_cols)

    print("\n{}".format(header_line))
    print(separator)
    for row in rows[:50]:
        line = "  ".join(str(row[col])[:60].ljust(col_widths[col]) for col in preview_cols)
        print(line)
    if len(rows) > 50:
        print("... ({} more rows in CSV)".format(len(rows) - 50))

    csv_columns = [
        'notification_id',
        'timestamp',
        'actor',
        'message',
        'resource_aka',
        'resource_title',
        'resource_type',
        'resource_trunk',
        'detail_link',
    ]

    with open(output, 'w', newline='') as csvfile:
        writer = csv.DictWriter(csvfile, fieldnames=csv_columns)
        writer.writeheader()
        for row in rows:
            writer.writerow(row)

    total_elapsed = time.time() - script_start
    print("\nResults written to {}".format(output))
    print("Total time: {}  ({:,} notifications)".format(fmt_duration(total_elapsed), len(rows)))


if __name__ == "__main__":
    if sys.version_info > (3, 4):
        try:
            activity_ledger_export()
        except Exception as e:
            print(e)
    else:
        print("This script requires Python v3.5+")
        print("Your Python version is: {}.{}.{}".format(
            sys.version_info.major, sys.version_info.minor, sys.version_info.micro))
        if sys.version_info < (3, 0):
            hint = ["Maybe try: `python3"] + sys.argv
            hint[len(sys.argv)] = hint[len(sys.argv)] + "`"
            print(*hint)
