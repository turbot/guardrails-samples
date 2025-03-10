import click
import turbot
import requests
from datetime import datetime

# Counter for API calls
api_call_count = 0

def fetch_projects(session, api_url, headers, project_turbot_id):
    global api_call_count
    query = '''
    query ($filter: [String!], $paging: String) {
      resources(filter: $filter, paging: $paging) {
        items {
          trunk {
            title
          }
          turbot {
            title
            id
          }
        }
        paging {
          next
        }
      }
    }
    '''
    projects = []
    paging = None
    
    if project_turbot_id:
        filter_str = f"resourceId:{project_turbot_id} resourceTypeId:tmod:@turbot/gcp#/resource/types/project level:self limit:5000"
    else:
        filter_str = "resourceTypeId:tmod:@turbot/gcp#/resource/types/project level:self limit:5000"

    while True:
        variables = {'filter': [filter_str], 'paging': paging}  # Wrap filter in a list
        response = session.post(
            api_url,
            json={'query': query, 'variables': variables},
            headers=headers
        )
        api_call_count += 1  # Increment API call count

        if not response.ok:
            print(f"Error fetching projects: {response.text}")
            response.raise_for_status()

        data = response.json()

        if "errors" in data:
            for error in data["errors"]:
                print(f"Error: {error['message']}")
            break

        projects.extend(data['data']['resources']['items'])
        paging = data['data']['resources']['paging']['next']
        if not paging:
            break

    return projects

def fetch_control_data(session, api_url, headers, resource_id, control_type_id, all_control_states):
    global api_call_count
    query = '''
    query ($filter: [String!], $paging: String) {
      controlSummariesByControlType(filter: $filter, paging: $paging) {
        items {
          summary {
            control {
              alarm
              error
              invalid
              muted
              ok
              skipped
              tbd
              total
            }
          }
          type {
            uri
            trunk {
              title
            }
          }
        }
        paging {
          next
        }
      }
    }
    '''
    controls = []
    paging = None
    
    if all_control_states:
        filter_str = f"resourceId:{resource_id} controlTypeId:{control_type_id} limit:5000"
    else:
        filter_str = f"resourceId:{resource_id} controlTypeId:{control_type_id} state:active limit:5000"

    while True:
        variables = {'filter': [filter_str], 'paging': paging}  # Wrap filter in a list
        response = session.post(
            api_url,
            json={'query': query, 'variables': variables},
            headers=headers
        )
        api_call_count += 1  # Increment API call count

        if not response.ok:
            print(f"Error fetching control summaries: {response.text}")
            response.raise_for_status()

        data = response.json()

        if "errors" in data:
            for error in data["errors"]:
                print(f"Error: {error['message']}")
            break

        controls.extend(data['data']['controlSummariesByControlType']['items'])
        paging = data['data']['controlSummariesByControlType']['paging']['next']
        if not paging:
            break

    return controls

def process_control_data(session, api_url, headers, resource_id, control_type_id, project_title, trunk_title, output_lines, all_control_states):
    items = fetch_control_data(session, api_url, headers, resource_id, control_type_id, all_control_states)
    current_date = datetime.now().strftime("%m-%d-%Y")
    for item in items:
        control_summary = item['summary']['control']
        type_uri = item['type']['uri']
        control_title = item['type']['trunk']['title']

        # Only include control/types in the output
        if 'control/types' in type_uri:
            output_lines.append(
                f"{current_date},{project_title},{trunk_title},{control_title},{type_uri},{control_summary['alarm']},{control_summary['error']},{control_summary['invalid']},{control_summary['muted']},{control_summary['ok']},{control_summary['skipped']},{control_summary['tbd']},{control_summary['total']}"
            )

        if 'resource/types' in type_uri:
            process_control_data(session, api_url, headers, resource_id, type_uri, project_title, trunk_title, output_lines, all_control_states)

@click.command()
@click.option('-c', '--config-file', type=click.Path(dir_okay=False), help="[String] Pass an optional yaml config file.")
@click.option('-p', '--profile', default="default", help="[String] Profile to be used from config file.")
@click.option('-i', '--insecure', is_flag=True, help="Disable SSL certificate verification.")
@click.option('--project-turbot-id', default=None, help="[String] Turbot ID of a single project to fetch usage for. If not provided, fetches usage for all projects.")
@click.option('--all-control-states', is_flag=True, help="Include all control states instead of only active ones.")
def get_workspace_usage(config_file, profile, insecure, project_turbot_id, all_control_states):
    global api_call_count
    start_time = datetime.now()
    print(f"Script started at {start_time}\n")

    try:
        config = turbot.Config(config_file, profile)
        headers = {'Authorization': f'Basic {config.auth_token}'}
        api_url = config.graphql_endpoint  # Use the endpoint directly from config
    except Exception as e:
        print(f"Error: Unable to load configuration or connect to the endpoint. {e}")
        return

    session = requests.Session()
    session.verify = not insecure

    if insecure:
        requests.packages.urllib3.disable_warnings()

    if project_turbot_id:
        if all_control_states:
            print(f"Collecting the usage summary (active and inactive) for the project with Turbot ID: {project_turbot_id}...\n")
        else:
            print(f"Collecting the active usage summary for the project with Turbot ID: {project_turbot_id}...\n")
    else:
        if all_control_states:
            print("Collecting the usage summary (active and inactive) for all projects...\n")
        else:
            print("Collecting the active usage summary for all projects...\n")

    api_call_count = 0  # Initialize API call count before making any requests
    projects = fetch_projects(session, api_url, headers, project_turbot_id)
    output_lines = []
    current_date = datetime.now().strftime("%m-%d-%Y")
    output_file = f'{profile}_control_usage_summary_{datetime.now().strftime("%m%d%Y")}.csv'  # Dynamic file name with date

    for project in projects:
        project_id = project['turbot']['id']
        project_title = project['turbot']['title']
        trunk_title = project['trunk']['title']

        process_control_data(session, api_url, headers, project_id, "tmod:@turbot/gcp#/resource/types/gcp", project_title, trunk_title, output_lines, all_control_states)

    with open(output_file, 'w') as f:
        f.write('Date,Project Title,Trunk Title,Control Title,Type URI,Alarm,Error,Invalid,Muted,OK,Skipped,TBD,Total\n')
        for line in output_lines:
            f.write(f"{line}\n")

    end_time = datetime.now()
    elapsed_time = (end_time - start_time).total_seconds()

    print(f"Data successfully written to {output_file}")
    print(f"Script completed at {end_time}")
    print(f"Total time taken: {elapsed_time:.2f} seconds")
    print(f"Total API calls made: {api_call_count}")

if __name__ == '__main__':
    get_workspace_usage()
