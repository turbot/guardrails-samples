import turbot
import click
import csv
import requests
import sys


@click.command()
@click.option('-c', '--config-file', type=click.Path(dir_okay=False), help="[String] Pass an optional yaml config file.")
@click.option('-p', '--profile', default="default", help="[String] Profile to be used from config file.")
@click.option('--state', default="alarm", help="[String] Control states to filter, comma-delimited. Default: alarm. e.g. alarm,invalid")
@click.option('--control-type', default=None, help="[String] Control type ID to filter. e.g. tmod:@turbot/aws-events#/resource/types/target")
@click.option('-l', '--limit', default=5000, type=int, help="[Int] Maximum number of controls to return. Default: 5000.")
@click.option('--page-size', default=200, type=int, help="[Int] Number of controls per API request. Default: 200.")
@click.option('-o', '--output', default="control_detail_by_state.csv", help="[String] Output CSV file path.")
def control_detail_by_state_export(config_file, profile, state, control_type, limit, page_size, output):
    """Lists controls filtered by state and exports details to CSV."""

    config = turbot.Config(config_file, profile)
    headers = {'Authorization': 'Basic {}'.format(config.auth_token)}
    endpoint = config.graphql_endpoint

    query = '''
      query ControlsList($filter: [String!], $paging: String) {
        controls(filter: $filter, paging: $paging) {
          metadata {
            stats {
              total
            }
          }
          paging {
            next
          }
          items {
            state
            reason
            turbot {
              id
              createTimestamp
              updateTimestamp
              controlTypeId
              resourceId
              stateChangeTimestamp
            }
            type {
              uri
              title
              icon
              modUri
              trunk {
                title
                items {
                  turbot {
                    id
                    title
                  }
                }
              }
            }
            resource {
              metadata
              turbot {
                id
                title
                akas
              }
              type {
                uri
                title
                icon
                trunk {
                  items {
                    turbot {
                      id
                      title
                    }
                  }
                }
              }
              trunk {
                items {
                  turbot {
                    id
                    title
                  }
                }
              }
            }
          }
        }
      }
    '''

    filter_parts = [
        "state:{}".format(state),
        "controlTypeLevel:self,descendant",
        "controlCategoryLevel:self",
        "limit:{}".format(page_size),
    ]

    if control_type:
        filter_parts.append("controlTypeId:{}".format(control_type))

    items = []
    paging = None

    print("Looking for controls in {} state...".format(state))

    while True:
        variables = {'filter': filter_parts, 'paging': paging}
        result = run_query(endpoint, headers, query, variables)

        if "errors" in result:
            for error in result['errors']:
                print(error)
            break

        data = result['data']['controls']

        if not items and data.get('metadata', {}).get('stats', {}).get('total'):
            total = data['metadata']['stats']['total']
            print("Total controls matching filter: {}".format(total))

        for item in data['items']:
            items.append(item)
            if len(items) >= limit:
                break

        if len(items) >= limit or not data['paging']['next']:
            break
        else:
            print("{} controls fetched...".format(len(items)))
            paging = data['paging']['next']

    items = items[:limit]

    print("\nFound {} control(s)".format(len(items)))

    if not items:
        print("No results to export.")
        return

    rows = []
    for item in items:
        control_trunk = " > ".join(
            t['turbot']['title'] for t in item['type']['trunk']['items']
        ) if item['type'].get('trunk', {}).get('items') else ""

        resource = item.get('resource') or {}
        resource_turbot = resource.get('turbot') or {}

        resource_trunk = " > ".join(
            t['turbot']['title'] for t in resource['trunk']['items']
        ) if resource.get('trunk', {}).get('items') else ""

        akas = resource_turbot.get('akas') or []

        rows.append({
            'control_id': '="' + str(item['turbot']['id']) + '"',
            'control_state': item['state'],
            'control_type_trunk': control_trunk,
            'resource_aka': akas[0] if akas else '',
            'resource_trunk': resource_trunk,
            'state_change_timestamp': item['turbot'].get('stateChangeTimestamp') or '',
        })

    table_columns = ['control_state', 'control_type_trunk', 'resource_aka', 'state_change_timestamp']
    col_headers = {
        'control_state': 'State',
        'control_type_trunk': 'Control Type',
        'resource_aka': 'Resource AKA',
        'state_change_timestamp': 'State Changed',
    }
    col_widths = {}
    for col in table_columns:
        col_widths[col] = max(
            len(col_headers[col]),
            max((len(str(row[col])[:60]) for row in rows), default=0)
        )

    header_line = "  ".join(col_headers[col].ljust(col_widths[col]) for col in table_columns)
    separator = "  ".join("-" * col_widths[col] for col in table_columns)

    print("\n{}".format(header_line))
    print(separator)
    for row in rows[:50]:
        line = "  ".join(str(row[col])[:60].ljust(col_widths[col]) for col in table_columns)
        print(line)
    if len(rows) > 50:
        print("... ({} more rows in CSV)".format(len(rows) - 50))

    csv_columns = [
        'control_id',
        'control_state',
        'control_type_trunk',
        'resource_aka',
        'resource_trunk',
        'state_change_timestamp',
    ]

    with open(output, 'w', newline='') as csvfile:
        writer = csv.DictWriter(csvfile, fieldnames=csv_columns)
        writer.writeheader()
        for row in rows:
            writer.writerow(row)

    print("\nResults written to {}".format(output))


def run_query(endpoint, headers, query, variables):
    request = requests.post(
        endpoint,
        headers=headers,
        json={'query': query, 'variables': variables}
    )
    if request.status_code == 200:
        return request.json()
    else:
        raise Exception("Query failed to run by returning code of {}. {}".format(
            request.status_code, query))


if __name__ == "__main__":
    if (sys.version_info > (3, 4)):
        try:
            control_detail_by_state_export()
        except Exception as e:
            print(e)
    else:
        print("This script requires Python v3.5+")
        print("Your Python version is: {}.{}.{}".format(
            sys.version_info.major, sys.version_info.minor, sys.version_info.micro))
        if (sys.version_info < (3, 0)):
            hint = ["Maybe try: `python3"] + sys.argv
            hint[len(sys.argv)] = hint[len(sys.argv)] + "`"
            print(*hint)
