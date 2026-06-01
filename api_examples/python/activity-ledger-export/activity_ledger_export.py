import turbot
import click
import csv
import requests
import sys
import time
import threading
from concurrent.futures import ThreadPoolExecutor, as_completed


CSP_RESOURCE_TYPE_IDS = {
    'aws':   'tmod:@turbot/aws#/resource/types/aws',
    'azure': 'tmod:@turbot/azure#/resource/types/azure',
    'gcp':   'tmod:@turbot/gcp#/resource/types/gcp',
}

NOTIFICATION_QUERY = '''
  query ActivityLedger($filter: [String!], $paging: String) {
    notifications(filter: $filter, paging: $paging) {
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

_print_lock = threading.Lock()


def tprint(msg):
    with _print_lock:
        print(msg)


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


def get_notification_count(endpoint, headers, base_filter_parts, total_hours):
    """Get total notification count for the full time range (single API call)."""
    query = '''
      query NotificationCount($filter: [String!]) {
        notifications(filter: $filter) {
          metadata {
            stats { total }
          }
        }
      }
    '''
    variables = {'filter': base_filter_parts + ["timestamp:>T-{}h".format(total_hours), "limit:1"]}
    result = run_query(endpoint, headers, query, variables)
    if "errors" in result:
        return None
    return result.get('data', {}).get('notifications', {}).get('metadata', {}).get('stats', {}).get('total')


def build_time_windows(total_hours, num_windows):
    """
    Split the time range into num_windows equal slices expressed as
    (hours_ago_start, hours_ago_end) pairs — oldest window first.
    Uses Turbot's T-Nh relative time notation to avoid ISO timestamp
    parsing issues in the filter engine.

    Example for total_hours=2160, num_windows=15 (window_size=144h):
      (2160, 2016), (2016, 1872), ..., (144, 0)
    The last window (hours_ago_end=0) uses no upper bound in the filter.
    """
    window_hours = total_hours / num_windows
    windows = []
    for i in range(num_windows):
        hours_ago_start = round(total_hours - i * window_hours)
        hours_ago_end   = round(total_hours - (i + 1) * window_hours)
        windows.append((hours_ago_start, hours_ago_end))
    return windows


def fetch_window(endpoint, headers, base_filter_parts, hours_ago_start, hours_ago_end,
                 page_size, window_idx, total_windows, progress):
    """Fetch all notifications for a single time window. Returns list of items.

    hours_ago_start > hours_ago_end (start is further back in time).
    Uses T-Nh relative time notation: T-2160h means '2160 hours ago'.
    The newest window (hours_ago_end == 0) has no upper-bound filter,
    matching the original single-query behaviour.
    """
    if hours_ago_end == 0:
        time_filter = "timestamp:>T-{}h".format(hours_ago_start)
    else:
        time_filter = "timestamp:>T-{}h timestamp:<T-{}h".format(hours_ago_start, hours_ago_end)
    filter_parts = base_filter_parts + [time_filter, "limit:{}".format(page_size)]

    items = []
    paging = None
    t_start = time.time()

    while True:
        variables = {'filter': filter_parts, 'paging': paging}
        result = run_query(endpoint, headers, NOTIFICATION_QUERY, variables)

        if "errors" in result:
            for error in result['errors']:
                tprint("  [Window {}/{}] Error: {}".format(
                    window_idx, total_windows, error.get('message', error)))
            break

        data = result['data']['notifications']
        items.extend(data['items'])

        next_page = data['paging']['next'] if data.get('paging') else None
        if not next_page:
            break
        paging = next_page

    elapsed = time.time() - t_start

    with progress['lock']:
        progress['windows_done'] += 1
        progress['items_fetched'] += len(items)
        done = progress['windows_done']
        total_items = progress['items_fetched']
        run_elapsed = time.time() - progress['start_time']
        # ETA: fraction of windows done → extrapolate total wall time
        fraction_done = done / total_windows
        eta_secs = (run_elapsed / fraction_done - run_elapsed) if fraction_done > 0 else 0
        tprint("  [{:>3}/{}] T-{}h → T-{}h  {:>6} notifications  {:.1f}s  |  total: {:>7,}  ETA: {}".format(
            done, total_windows,
            hours_ago_start,
            hours_ago_end,
            len(items),
            elapsed,
            total_items,
            fmt_duration(eta_secs) if done < total_windows else "done",
        ))

    return items


@click.command()
@click.option('-c', '--config-file', type=click.Path(dir_okay=False), help="[String] Pass an optional yaml config file.")
@click.option('-p', '--profile', default="default", help="[String] Profile to be used from config file.")
@click.option('--days', default=7, type=int, show_default=True, help="[Int] Fetch activity from the last N days. e.g. 90. Mutually exclusive with --hours.")
@click.option('--hours', default=None, type=int, help="[Int] Fetch activity from the last N hours. e.g. 24. Mutually exclusive with --days.")
@click.option('--actor-id', default=None, help="[String] Filter by a specific actor identity ID. Defaults to the Turbot Identity for this workspace.")
@click.option('--all-actors', is_flag=True, default=False, help="Include activity from all actors, not just Turbot Identity.")
@click.option('--csp', default=None, type=click.Choice(['aws', 'azure', 'gcp'], case_sensitive=False), help="[String] Limit to a cloud provider's resources: aws, azure, or gcp. Mutually exclusive with --resource-type.")
@click.option('--resource-type', default=None, help="[String] Filter by resource type IDs, comma-separated. Takes precedence over --csp. e.g. 'tmod:@turbot/aws#/resource/types/aws,tmod:@turbot/azure#/resource/types/azure'")
@click.option('--workers', default=5, type=int, show_default=True, help="[Int] Number of parallel workers. Each worker handles an independent time slice. Default: 5.")
@click.option('--page-size', default=500, type=int, show_default=True, help="[Int] Number of notifications per API request. Default: 500.")
@click.option('-o', '--output', default="activity_ledger.csv", help="[String] Output CSV file path. Default: activity_ledger.csv")
def activity_ledger_export(config_file, profile, days, hours, actor_id, all_actors,
                           csp, resource_type, workers, page_size, output):
    """Exports Turbot activity (action notifications) for the past N days or hours to a CSV file.

    Bypasses the 30-day / 5000-row limits of the Activity Ledger UI by paginating
    through all results via the GraphQL API. Uses parallel workers to split the time
    range into independent slices for faster export of large date ranges.

    By default, results are filtered to the Turbot Identity actor (automated Turbot
    actions only). Use --all-actors to include actions by human users as well.
    """

    if hours:
        if days != 7:
            raise click.UsageError("--days and --hours are mutually exclusive. Use one or the other.")
        window_label = "last {} hours".format(hours)
    else:
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

    # Build the base filter (everything except the time window)
    base_filter_parts = ["notificationType:action_notify"]
    if resource_type:
        type_ids = [t.strip() for t in resource_type.split(',')]
        base_filter_parts.append("resourceTypeId:{}".format(','.join(type_ids)))
    elif csp:
        base_filter_parts.append("resourceTypeId:{}".format(CSP_RESOURCE_TYPE_IDS[csp.lower()]))
    if actor_id:
        base_filter_parts.append("actorIdentityId:'{}'".format(actor_id))

    # Total time range expressed in whole hours (T-Nh notation)
    total_hours = (hours if hours else days * 24)

    # Window count: 1 per day (or per hour for --hours mode), capped at workers * 3
    num_windows = min(max(1, days if not hours else hours), workers * 3)
    actual_workers = min(workers, num_windows)

    # Get total notification count upfront
    print("\nCounting notifications for the {}...".format(window_label))
    total = get_notification_count(endpoint, headers, base_filter_parts, total_hours)
    if total is not None:
        print("  Total matching notifications: {:,}".format(total))
        est_pages = (total + page_size - 1) // page_size
        est_secs_seq = est_pages * 2  # ~2s per page (conservative)
        est_secs_par = est_secs_seq / actual_workers
        print("  Estimated pages              : {:,} (page size {})".format(est_pages, page_size))
        print("  Estimated time               : {} with {} workers  ({} sequential)".format(
            fmt_duration(est_secs_par), actual_workers, fmt_duration(est_secs_seq)))
    if actor_id:
        print("  Actor filter                 : {}".format(actor_id))
    elif all_actors:
        print("  Actor filter                 : all actors")
    if resource_type or csp:
        print("  Resource type filter         : {}".format(resource_type or CSP_RESOURCE_TYPE_IDS[csp.lower()]))
    print("  Workers                      : {}  |  Windows: {}".format(actual_workers, num_windows))

    # Build time windows (expressed as hours-ago pairs) and progress tracker
    windows = build_time_windows(total_hours, num_windows)
    progress = {
        'lock': threading.Lock(),
        'windows_done': 0,
        'items_fetched': 0,
        'start_time': time.time(),
    }

    print("\nFetching...\n")
    all_items = []

    with ThreadPoolExecutor(max_workers=actual_workers) as executor:
        futures = {
            executor.submit(
                fetch_window,
                endpoint, headers, base_filter_parts,
                hours_ago_start, hours_ago_end, page_size,
                idx + 1, num_windows, progress
            ): idx
            for idx, (hours_ago_start, hours_ago_end) in enumerate(windows)
        }
        for future in as_completed(futures):
            try:
                all_items.extend(future.result())
            except Exception as e:
                tprint("  Window error: {}".format(e))

    fetch_elapsed = time.time() - script_start
    print("\nFetched {:,} notification(s) in {}.".format(len(all_items), fmt_duration(fetch_elapsed)))

    if not all_items:
        print("No activity found for the specified filters.")
        return

    # Sort by timestamp descending (newest first) — parallel fetches may interleave
    print("Sorting results...")
    all_items.sort(key=lambda x: x['turbot']['createTimestamp'], reverse=True)

    rows = []
    for item in all_items:
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
    print("Total time: {}  ({:,} notifications, {} workers)".format(
        fmt_duration(total_elapsed), len(rows), actual_workers))


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
