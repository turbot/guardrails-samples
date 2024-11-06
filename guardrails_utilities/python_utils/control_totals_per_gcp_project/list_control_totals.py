import click
import turbot
from sgqlc.endpoint.http import HTTPEndpoint

@click.command()
@click.option('-c', '--config-file', type=click.Path(dir_okay=False), help="[String] Optional YAML config file.")
@click.option('-p', '--profile', default="default", help="[String] Profile to be used from config file.")

def run_project_controls(config_file, profile):
    """Retrieves GCP projects and runs a subquery on each."""
    config = turbot.Config(config_file, profile)
    headers = {'Authorization': 'Basic {}'.format(config.auth_token)}
    endpoint = HTTPEndpoint(config.graphql_endpoint, headers)

    # Query to get the list of GCP projects
    list_projects_query = '''
    query ListProjects($filter: [String!]!, $paging: String) {
      resources(filter: $filter, paging: $paging) {
        items {
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
    gcp_proj_filter = "resourceTypeId:'tmod:@turbot/gcp#/resource/types/project' level:self"
    projects = []
    paging = None
    print("Retrieving GCP projects...")

    # Retrieve all GCP projects with paging
    while True:
        variables = {'filter': gcp_proj_filter, 'paging': paging}
        result = endpoint(list_projects_query, variables)

        if "errors" in result:
            for error in result['errors']:
                print(error)
            break

        projects.extend(result['data']['resources']['items'])

        if not result['data']['resources']['paging']['next']:
            break
        else:
            paging = result['data']['resources']['paging']['next']

    print(f"\nFound {len(projects)} GCP projects.\n")

    # Subquery to get control counts for each project
    controls_query = '''
    query ControlsByProject($projectId: ID!) {{
      resource(id: $projectId) {{
        turbot {{
          title
          id
        }}
        akas
        total: controls(filter: "controlTypeId:'{controlTypeId}'")                {{ metadata {{ stats {{ total }} }} }}
        ok: controls(filter: "controlTypeId:'{controlTypeId}' state:ok")           {{ metadata {{ stats {{ total }} }} }}
        alarm: controls(filter: "controlTypeId:'{controlTypeId}' state:alarm")     {{ metadata {{ stats {{ total }} }} }}
        error: controls(filter: "controlTypeId:'{controlTypeId}' state:error")     {{ metadata {{ stats {{ total }} }} }}
        invalid: controls(filter: "controlTypeId:'{controlTypeId}' state:invalid") {{ metadata {{ stats {{ total }} }} }}
        tbd: controls(filter: "controlTypeId:'{controlTypeId}' state:tbd")         {{ metadata {{ stats {{ total }} }} }}
      }}
    }}
    '''

    control_types_query = '''
    query ControlTypesByProject($filter: [String!]!) {
      policyTypes(filter: $filter) {
        items {
          uri
          title
          trunk {
            title
          }
        }
      }
    }
    '''

    # Iterate over each project and run the subquery
    for project in projects:
        project_id = project['turbot']['id']
        variables = {'filter': f"resourceId:{project_id} limit:2000"}

        control_types_result = endpoint(control_types_query, variables)
        if "errors" in control_types_result:
            print(f"Error fetching control types for project {project_id}:")
            for error in result['errors']:
                print(error)
            continue
        
        variables = {'projectId': project_id}
        for control_type in control_types_result['data']['policyTypes']['items']:
          print("inloop")
          result = endpoint(controls_query.format(controlTypeId=control_type['uri']), variables)

          if "errors" in result:
              print(f"Error fetching controls for project {project_id}:")
              for error in result['errors']:
                  print(error)
              continue

          resource = result['data']['resource']
          title = resource['turbot']['title']
          akas = resource.get('akas', [])
          control_type_title = control_type['title']
          total_controls = resource['total']['metadata']['stats']['total']
          ok_controls = resource['ok']['metadata']['stats']['total']
          alarm_controls = resource['alarm']['metadata']['stats']['total']
          error_controls = resource['error']['metadata']['stats']['total']
          invalid_controls = resource['invalid']['metadata']['stats']['total']
          tbd_controls = resource['tbd']['metadata']['stats']['total']

          print(f"Project: {title} ({project_id})")
          print(f"Control Type: {control_type_title} ")
          print(f"  Total Controls: {total_controls}")
          print(f"    OK: {ok_controls}")
          print(f"    Alarm: {alarm_controls}")
          print(f"    Error: {error_controls}")
          print(f"    Invalid: {invalid_controls}")
          print(f"    TBD: {tbd_controls}\n")

if __name__ == "__main__":
    try:
        run_project_controls()
    except Exception as e:
        print(f"An error occurred: {e}")