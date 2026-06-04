import turbot
import click
import csv
import json
import os
import requests
import sys
import time
import threading
from datetime import datetime, timedelta
from concurrent.futures import ThreadPoolExecutor, as_completed


CSP_RESOURCE_TYPE_IDS = {
    'aws':        'tmod:@turbot/aws#/resource/types/aws',
    'azure':      'tmod:@turbot/azure#/resource/types/azure',
    'azure-ad':   'tmod:@turbot/azure-activedirectory#/resource/types/directory',
    'gcp':        'tmod:@turbot/gcp#/resource/types/gcp',
    'kubernetes': 'tmod:@turbot/kubernetes#/resource/types/kubernetes',
    'servicenow': 'tmod:@turbot/servicenow#/resource/types/serviceNow',
    'github':     'tmod:@turbot/github#/resource/types/github',
}

CSV_COLUMNS = [
    'notification_id',
    'notification_type',
    'timestamp',
    'actor',
    'message',
    'resource_aka',
    'resource_title',
    'resource_type',
    'resource_trunk',
    'detail_link',
]

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


def run_query(endpoint, headers, query, variables, timeout=120, max_retries=5):
    """Execute a GraphQL query with timeout and exponential backoff retry."""
    delay = 2
    last_error = None
    for attempt in range(max_retries):
        try:
            response = requests.post(
                endpoint,
                headers=headers,
                json={'query': query, 'variables': variables},
                timeout=timeout
            )
            if response.status_code == 200:
                return response.json()
            elif response.status_code in (429, 502, 503, 504):
                last_error = "HTTP {}".format(response.status_code)
                if attempt + 1 < max_retries:
                    tprint("  {} — retry {}/{} in {}s".format(last_error, attempt + 1, max_retries, delay))
                    time.sleep(delay)
                    delay = min(delay * 2, 60)
            else:
                raise Exception("Query failed with HTTP {}".format(response.status_code))
        except (requests.exceptions.Timeout, requests.exceptions.ConnectionError) as e:
            last_error = "{}: {}".format(type(e).__name__, e)
            if attempt + 1 < max_retries:
                tprint("  {} — retry {}/{} in {}s".format(type(e).__name__, attempt + 1, max_retries, delay))
                time.sleep(delay)
                delay = min(delay * 2, 60)
            else:
                break
    raise Exception("Query failed after {} retries: {}".format(max_retries, last_error))


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


def build_date_chunks(from_date_str, to_date_str, chunk_days):
    """Return list of (chunk_from, chunk_to_exclusive) string pairs covering [from_date, to_date]."""
    start = datetime.strptime(from_date_str, '%Y-%m-%d')
    end   = datetime.strptime(to_date_str,   '%Y-%m-%d')
    chunks = []
    current = start
    while current <= end:
        chunk_end = min(current + timedelta(days=chunk_days), end + timedelta(days=1))
        chunks.append((current.strftime('%Y-%m-%d'), chunk_end.strftime('%Y-%m-%d')))
        current = chunk_end
    return chunks


def _paginate(endpoint, headers, filter_parts, label, page_size, progress, progress_key,
              request_timeout=120, max_retries=5, write_fn=None):
    """
    Core pagination loop used by both worker types.

    Streams results to write_fn (per page) if provided, otherwise accumulates and returns them.
    progress_key is the counter name in the shared progress dict ('types_done' or 'days_done').
    """
    full_filter = filter_parts + ["limit:{}".format(page_size)]
    items = []
    item_count = 0
    paging = None
    page_num = 0
    t_start = time.time()

    while True:
        variables = {'filter': full_filter, 'paging': paging}
        try:
            result = run_query(endpoint, headers, NOTIFICATION_QUERY, variables,
                               timeout=request_timeout, max_retries=max_retries)
        except Exception as e:
            tprint("  [{}] Pagination stopped at page {}: {}".format(label, page_num + 1, e))
            break

        if "errors" in result:
            for error in result['errors']:
                tprint("  [{}] Error on page {}: {}".format(label, page_num + 1, error.get('message', error)))
            break

        data = result['data']['notifications']
        page_items = data['items']
        page_num += 1
        item_count += len(page_items)

        if write_fn:
            write_fn(page_items)
        else:
            items.extend(page_items)

        next_page = data['paging']['next'] if data.get('paging') else None
        if not next_page:
            break
        paging = next_page

    elapsed = time.time() - t_start
    total_returned = item_count if write_fn else len(items)

    with progress['lock']:
        progress[progress_key] += 1
        progress['items_fetched'] += total_returned
        done = progress[progress_key]
        total = progress['total_' + progress_key.replace('_done', '')]
        total_items = progress['items_fetched']
        run_elapsed = time.time() - progress['start_time']
        rate = total_items / run_elapsed if run_elapsed > 0 else 0
        tprint("  [{:>2}/{}] {:>22}  {:>8,} notifications  {:>6.1f}s  |  total so far: {:>9,}  ({:.0f}/s)".format(
            done, total, label, total_returned, elapsed, total_items, rate))

    return items


def fetch_resource_type(endpoint, headers, base_filter_parts, resource_type_id, page_size, progress,
                        request_timeout=120, max_retries=5, write_fn=None):
    """Worker for action_notify mode: paginates one CSP root type within a date range."""
    label = resource_type_id.split('@turbot/')[-1].split('#')[0] if '@turbot/' in resource_type_id else resource_type_id
    filter_parts = base_filter_parts + ["resourceTypeId:'{}'".format(resource_type_id)]
    return _paginate(endpoint, headers, filter_parts, label, page_size, progress,
                     'types_done', request_timeout, max_retries, write_fn)


def fetch_date_window(endpoint, headers, base_filter_parts, window_from, window_to, page_size, progress,
                      request_timeout=120, max_retries=5, write_fn=None):
    """Worker for all-notifications mode: paginates all records within a 1-day window."""
    label = "{} → {}".format(window_from, window_to)
    filter_parts = base_filter_parts + ["timestamp:>={} timestamp:<{}".format(window_from, window_to)]
    return _paginate(endpoint, headers, filter_parts, label, page_size, progress,
                     'days_done', request_timeout, max_retries, write_fn)


def item_to_row(item, workspace_url):
    """Convert a raw notification item to a CSV row dict."""
    resource = item.get('resource') or {}
    resource_turbot = resource.get('turbot') or {}
    resource_type_data = resource.get('type') or {}
    akas = resource_turbot.get('akas') or []

    actor_title = ((item.get('actor') or {}).get('identity') or {}).get('title') or ''
    turbot_data = item.get('turbot') or {}
    notification_id = turbot_data.get('id') or ''
    process_id = turbot_data.get('processId') or ''

    return {
        'notification_id':   str(notification_id),
        'notification_type': item.get('notificationType') or '',
        'timestamp':         item['turbot']['createTimestamp'],
        'actor':             actor_title,
        'message':           item.get('message') or '',
        'resource_aka':      akas[0] if akas else '',
        'resource_title':    resource_turbot.get('title', ''),
        'resource_type':     (resource_type_data.get('trunk') or {}).get('title') or '',
        'resource_trunk':    (resource.get('trunk') or {}).get('title') or '',
        'detail_link':       "{}/apollo/processes/{}/notifications/{}".format(
                                 workspace_url, process_id, notification_id) if process_id else '',
    }


def run_chunk(endpoint, headers, base_filter_parts, resource_type_ids,
              chunk_from, chunk_to, page_size, workers,
              chunk_label, chunk_num, total_chunks,
              all_notifications=False,
              request_timeout=120, max_retries=5, write_fn=None):
    """
    Fetch all notifications for one date chunk in parallel.

    action_notify mode  (all_notifications=False):
      One worker per CSP root type. base_filter_parts includes the time range.
      Works correctly because action_notify notifications are tagged to the
      accountable root resource type.

    all-notifications mode (all_notifications=True):
      One worker per day within the chunk. No resourceTypeId per worker.
      Required because the resourceTypeId filter captures only root-type records
      for non-action notification types; all other types need date-based splitting.
    """
    all_items = []

    if all_notifications:
        # Split chunk into 1-day sub-windows; each worker paginates one full day.
        chunk_end_inclusive = (datetime.strptime(chunk_to, '%Y-%m-%d') - timedelta(days=1)).strftime('%Y-%m-%d')
        day_windows = build_date_chunks(chunk_from, chunk_end_inclusive, 1)
        actual_workers = min(workers, len(day_windows))
        print("\nChunk {:>2}/{}: {}  ({} workers, {} days, all notification types)".format(
            chunk_num, total_chunks, chunk_label, actual_workers, len(day_windows)))

        progress = {
            'lock':       threading.Lock(),
            'days_done':  0,
            'items_fetched': 0,
            'total_days': len(day_windows),
            'start_time': time.time(),
        }

        with ThreadPoolExecutor(max_workers=actual_workers) as executor:
            futures = {
                executor.submit(
                    fetch_date_window,
                    endpoint, headers, base_filter_parts, w_from, w_to,
                    page_size, progress, request_timeout, max_retries, write_fn
                ): (w_from, w_to)
                for w_from, w_to in day_windows
            }
            for future in as_completed(futures):
                try:
                    result = future.result()
                    if not write_fn:
                        all_items.extend(result)
                except Exception as e:
                    tprint("  Worker error: {}".format(e))

    else:
        # One worker per CSP root type; base_filter_parts includes the time range.
        actual_workers = min(workers, len(resource_type_ids))
        print("\nChunk {:>2}/{}: {}  ({} workers, {} resource types)".format(
            chunk_num, total_chunks, chunk_label, actual_workers, len(resource_type_ids)))

        progress = {
            'lock':        threading.Lock(),
            'types_done':  0,
            'items_fetched': 0,
            'total_types': len(resource_type_ids),
            'start_time':  time.time(),
        }

        with ThreadPoolExecutor(max_workers=actual_workers) as executor:
            futures = {
                executor.submit(
                    fetch_resource_type,
                    endpoint, headers, base_filter_parts, rt_id,
                    page_size, progress, request_timeout, max_retries, write_fn
                ): rt_id
                for rt_id in resource_type_ids
            }
            for future in as_completed(futures):
                try:
                    result = future.result()
                    if not write_fn:
                        all_items.extend(result)
                except Exception as e:
                    tprint("  Worker error: {}".format(e))

    if not write_fn:
        all_items.sort(key=lambda x: x['turbot']['createTimestamp'], reverse=True)
    return all_items


@click.command(no_args_is_help=True)
@click.option('-c', '--config-file', type=click.Path(dir_okay=False), help="[String] Pass an optional yaml config file.")
@click.option('-p', '--profile', default="default", help="[String] Profile to be used from config file.")
@click.option('--days', default=7, type=int, show_default=True, help="[Int] Fetch activity from the last N days. Mutually exclusive with --from-date/--hours.")
@click.option('--hours', default=None, type=int, help="[Int] Fetch activity from the last N hours. Mutually exclusive with --days/--from-date.")
@click.option('--from-date', default=None, help="[String] Start date YYYY-MM-DD. Mutually exclusive with --days/--hours.")
@click.option('--to-date', default=None, help="[String] End date YYYY-MM-DD. Used with --from-date. Defaults to today.")
@click.option('--chunk-days', default=7, type=int, show_default=True, help="[Int] Process N days per chunk. Default: 7.")
@click.option('--resume', is_flag=True, default=False, help="Resume a previous interrupted run using the checkpoint file.")
@click.option('--actor-id', default=None, help="[String] Filter by a specific actor identity ID. Defaults to the Turbot Identity for this workspace.")
@click.option('--all-actors', is_flag=True, default=False, help="Include activity from all actors, not just Turbot Identity.")
@click.option('--all-notifications', is_flag=True, default=False,
              help="Export ALL notification types (resource, control, policy, action). "
                   "Default: action_notify only. Use for large full-history exports.")
@click.option('--csp', multiple=True,
              type=click.Choice(['aws', 'azure', 'azure-ad', 'gcp', 'kubernetes', 'servicenow', 'github'],
                                case_sensitive=False),
              help="[String] Limit to one or more platforms. Ignored with --all-notifications "
                   "(use post-export filtering instead).")
@click.option('--resource-type', default=None,
              help="[String] Filter by resource type IDs, comma-separated. Takes precedence over --csp. "
                   "Ignored with --all-notifications.")
@click.option('--workers', default=7, type=int, show_default=True,
              help="[Int] Parallel workers. For action_notify: one per CSP type. "
                   "For --all-notifications: one per day in each chunk. Default: 7.")
@click.option('--page-size', default=500, type=int, show_default=True, help="[Int] Notifications per API request. Default: 500.")
@click.option('--timeout', default=120, type=int, show_default=True, help="[Int] Per-request HTTP timeout in seconds. Default: 120.")
@click.option('--retries', default=5, type=int, show_default=True, help="[Int] Max retries per request on transient errors. Default: 5.")
@click.option('-o', '--output', default="activity_ledger.csv", help="[String] Output CSV file path. Default: activity_ledger.csv")
def activity_ledger_export(config_file, profile, days, hours, from_date, to_date,
                           chunk_days, resume, actor_id, all_actors, all_notifications,
                           csp, resource_type, workers, page_size, timeout, retries, output):
    """Exports Turbot notifications to a CSV file.

    \b
    Action notifications only (Activity Ledger, default):
      --days 90                         Last 90 days, Turbot Identity actor
      --from-date 2026-01-01 --to-date 2026-03-31

    \b
    All notification types (resource, control, policy, action):
      --all-notifications --from-date 2026-01-01 --to-date 2026-03-31
      --all-notifications --days 90 --workers 7

    \b
    Resume an interrupted run:
      <same command as before> --resume

    By default, action_notify results are filtered to the Turbot Identity actor.
    Use --all-actors for human + automation activity. --all-notifications always
    includes all actors unless --actor-id or --all-actors is explicitly set.
    """

    # Validate mutual exclusions
    if from_date:
        if hours or days != 7:
            raise click.UsageError("--from-date is mutually exclusive with --days and --hours.")
        if resume and not os.path.exists(output + '.checkpoint.json') and not os.path.exists(output):
            raise click.UsageError("--resume specified but no checkpoint or output file found for '{}'.".format(output))
    elif hours:
        if days != 7:
            raise click.UsageError("--days and --hours are mutually exclusive.")
        if all_notifications:
            raise click.UsageError(
                "--hours is not supported with --all-notifications (volumes are too large for a "
                "sub-day window). Use --from-date / --to-date --chunk-days 1 instead.")
    if actor_id and all_actors:
        raise click.UsageError("--actor-id and --all-actors are mutually exclusive.")

    # --all-notifications always uses the chunked streaming path regardless of --days size,
    # because date-based parallelization requires whole-day boundaries and can't accumulate
    # 700K+ records per day in memory.
    if not from_date and not hours and all_notifications:
        from_date = (datetime.now() - timedelta(days=days)).strftime('%Y-%m-%d')
        # Include today as a full day by extending to_date to tomorrow
        to_date = (datetime.now() + timedelta(days=1)).strftime('%Y-%m-%d')

    # Auto-convert large --days to the chunked path (action_notify can buffer small windows)
    elif not from_date and not hours and days > chunk_days:
        from_date = (datetime.now() - timedelta(days=days)).strftime('%Y-%m-%d')
        to_date = to_date or datetime.now().strftime('%Y-%m-%d')
        print("Note: --days {} > --chunk-days {}; auto-switching to chunked streaming mode.".format(days, chunk_days))

    script_start = time.time()

    config = turbot.Config(config_file, profile)
    headers = {'Authorization': 'Basic {}'.format(config.auth_token)}
    endpoint = config.graphql_endpoint
    workspace_url = config.workspace.rstrip('/')

    # Resolve actor filter
    # For all-notifications, default to all actors (no actor filter) unless explicitly set.
    if not all_actors and not actor_id and not all_notifications:
        print("Looking up Turbot Identity actor ID...")
        actor_id = get_turbot_identity_id(endpoint, headers)
        if actor_id:
            print("  Turbot Identity ID: {}".format(actor_id))
        else:
            print("  Warning: Could not resolve Turbot Identity. Falling back to all actors.")

    # Determine resource type IDs for action_notify mode
    if resource_type:
        resource_type_ids = [t.strip() for t in resource_type.split(',')]
    elif csp:
        resource_type_ids = [CSP_RESOURCE_TYPE_IDS[c.lower()] for c in csp]
    else:
        resource_type_ids = list(CSP_RESOURCE_TYPE_IDS.values())

    # Base filter (no time range, no resourceTypeId — added per worker)
    base_filter_parts = [] if all_notifications else ["notificationType:action_notify"]
    if actor_id:
        base_filter_parts.append("actorIdentityId:'{}'".format(actor_id))

    if all_notifications and (csp or resource_type):
        print("Note: --csp/--resource-type is ignored with --all-notifications.")
        print("  The notifications API resourceTypeId filter only captures root account-type records")
        print("  for non-action types. Filter by CSP in the exported CSV instead.")

    notification_mode = "all notification types" if all_notifications else "action_notify only"
    actor_desc = actor_id if actor_id else ("all actors" if (all_actors or all_notifications) else "all actors (fallback)")
    csp_desc = "all (date-based workers)" if all_notifications else ','.join(resource_type_ids)

    # -----------------------------------------------------------------------
    # MODE 1: chunked path — --from-date or auto-converted large --days
    # Streams writes directly to CSV per page (no in-memory accumulation).
    # -----------------------------------------------------------------------
    if from_date:
        effective_to_date = to_date or datetime.now().strftime('%Y-%m-%d')
        chunks = build_date_chunks(from_date, effective_to_date, chunk_days)
        checkpoint_path = output + '.checkpoint.json'

        completed_chunks = {}
        if resume and os.path.exists(checkpoint_path):
            try:
                with open(checkpoint_path) as f:
                    checkpoint = json.load(f)
                completed_chunks = {c['chunk']: c['count'] for c in checkpoint.get('completed', [])}
                print("Resuming — {} chunk(s) already completed.".format(len(completed_chunks)))
            except (json.JSONDecodeError, KeyError):
                print("Warning: checkpoint file is corrupt — starting from scratch.")
                completed_chunks = {}

        from_dt = datetime.strptime(from_date, '%Y-%m-%d')
        days_ago = (datetime.now() - from_dt).days
        if days_ago > 90:
            print("\nWarning: --from-date {} is {} days ago.".format(from_date, days_ago))
            print("  The API can COUNT notifications older than ~90 days but cannot RETRIEVE them.")
            print("  Chunks outside that window will return 0 rows even if the DB total shows data.")

        worker_desc = "{} per chunk (1 per day)".format(min(workers, chunk_days)) if all_notifications \
                      else "{} per chunk (1 per CSP type)".format(min(workers, len(resource_type_ids)))

        print("\nExporting {} from {} to {}".format(notification_mode, from_date, effective_to_date))
        print("  Actor filter    : {}".format(actor_desc))
        print("  CSP / types     : {}".format(csp_desc))
        print("  Chunks          : {} x {}-day windows".format(len(chunks), chunk_days))
        print("  Workers         : {}".format(worker_desc))
        print("  Timeout/Retries : {}s / {}".format(timeout, retries))

        file_mode = 'a' if resume and os.path.exists(output) else 'w'
        csvfile = open(output, file_mode, newline='')
        writer = csv.DictWriter(csvfile, fieldnames=CSV_COLUMNS)
        if file_mode == 'w':
            writer.writeheader()

        total_written = sum(completed_chunks.values())
        checkpoint_data = {'from_date': from_date, 'to_date': effective_to_date,
                           'chunk_days': chunk_days, 'completed': [
                               {'chunk': k, 'count': v} for k, v in completed_chunks.items()
                           ]}

        write_lock = threading.Lock()
        count_tracker = [0]

        def stream_write(page_items):
            rows = [item_to_row(item, workspace_url) for item in page_items]
            with write_lock:
                for row in rows:
                    writer.writerow(row)
                count_tracker[0] += len(rows)

        for idx, (chunk_from, chunk_to) in enumerate(chunks, 1):
            chunk_key = "{}_{}".format(chunk_from, chunk_to)

            if chunk_key in completed_chunks:
                print("\nChunk {:>2}/{}: {} → {} [SKIP — {:,} rows already written]".format(
                    idx, len(chunks), chunk_from, chunk_to, completed_chunks[chunk_key]))
                continue

            chunk_label = "{} → {}".format(chunk_from, chunk_to)

            # For action_notify: pass time range in base filter; workers split by resource type.
            # For all_notifications: pass time range to run_chunk; workers split by day.
            if all_notifications:
                chunk_base = base_filter_parts[:]
            else:
                time_filter = "timestamp:>={} timestamp:<{}".format(chunk_from, chunk_to)
                chunk_base = base_filter_parts + [time_filter]

            count_tracker[0] = 0
            run_chunk(
                endpoint, headers, chunk_base, resource_type_ids,
                chunk_from, chunk_to, page_size, workers,
                chunk_label, idx, len(chunks),
                all_notifications=all_notifications,
                request_timeout=timeout, max_retries=retries, write_fn=stream_write
            )

            csvfile.flush()
            chunk_count = count_tracker[0]
            total_written += chunk_count
            completed_chunks[chunk_key] = chunk_count
            checkpoint_data['completed'].append({'chunk': chunk_key, 'count': chunk_count})
            with open(checkpoint_path, 'w') as f:
                json.dump(checkpoint_data, f, indent=2)

            run_elapsed = time.time() - script_start
            chunks_remaining = len(chunks) - idx
            rate_chunks = idx / run_elapsed if run_elapsed > 0 else 0
            eta_secs = chunks_remaining / rate_chunks if rate_chunks > 0 else 0
            print("  Chunk {}/{} done: {:,} rows  |  total: {:,}  |  elapsed: {}  |  ETA: {}".format(
                idx, len(chunks), chunk_count, total_written,
                fmt_duration(run_elapsed),
                fmt_duration(eta_secs) if chunks_remaining > 0 else "done"))

        csvfile.close()

        if len(completed_chunks) == len(chunks) and os.path.exists(checkpoint_path):
            os.remove(checkpoint_path)
            print("\nAll chunks complete — checkpoint removed.")

        total_elapsed = time.time() - script_start
        print("\nResults written to {}".format(output))
        print("Total time: {}  ({:,} notifications)".format(fmt_duration(total_elapsed), total_written))
        return

    # -----------------------------------------------------------------------
    # MODE 2: relative --hours or small --days (action_notify only, in-memory, with preview)
    # Reached only for --hours N, or --days N where N <= chunk_days.
    # --all-notifications always goes through MODE 1 (chunked streaming).
    # -----------------------------------------------------------------------
    if hours:
        time_filter = "timestamp:>T-{}h".format(hours)
        window_label = "last {} hours".format(hours)
    else:
        time_filter = "timestamp:>T-{}d".format(days)
        window_label = "last {} days".format(days)

    relative_filter_parts = base_filter_parts + [time_filter]

    print("\nFetching {} for the {}...".format(notification_mode, window_label))
    print("  Actor filter    : {}".format(actor_desc))
    print("  CSP / types     : {}\n".format(csp_desc))

    all_items = run_chunk(
        endpoint, headers, relative_filter_parts, resource_type_ids,
        '', '', page_size, workers,
        window_label, 1, 1,
        all_notifications=False,
        request_timeout=timeout, max_retries=retries
    )

    fetch_elapsed = time.time() - script_start
    print("\nFetched {:,} notification(s) in {}.".format(len(all_items), fmt_duration(fetch_elapsed)))

    if not all_items:
        print("No notifications found for the specified filters.")
        return

    rows = [item_to_row(item, workspace_url) for item in all_items]

    preview_cols = ['timestamp', 'notification_type', 'actor', 'message', 'resource_aka']
    col_headers = {'timestamp': 'Timestamp', 'notification_type': 'Type',
                   'actor': 'Actor', 'message': 'Message', 'resource_aka': 'Resource AKA'}
    col_widths = {col: max(len(col_headers[col]),
                           max((len(str(row[col])[:50]) for row in rows), default=0))
                  for col in preview_cols}

    print("\n{}".format("  ".join(col_headers[col].ljust(col_widths[col]) for col in preview_cols)))
    print("  ".join("-" * col_widths[col] for col in preview_cols))
    for row in rows[:50]:
        print("  ".join(str(row[col])[:50].ljust(col_widths[col]) for col in preview_cols))
    if len(rows) > 50:
        print("... ({:,} more rows in CSV)".format(len(rows) - 50))

    with open(output, 'w', newline='') as csvfile:
        writer = csv.DictWriter(csvfile, fieldnames=CSV_COLUMNS)
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
