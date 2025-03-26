import click
import turbot
import requests
import csv
from datetime import datetime

# Counter for API calls
api_call_count = 0

def fetch_workspace_url(session, api_url, headers):
    """
    Fetch workspace URL using the GraphQL API
    """
    global api_call_count
    
    query = '''
    query PolicySetting {
      policySetting(
        uri: "tmod:@turbot/turbot#/policy/types/workspaceUrl"
        resourceAka: "tmod:@turbot/turbot#/"
      ) {
        value
        turbot {
          id
        }
      }
    }
    '''
    
    response = session.post(
        api_url,
        json={'query': query},
        headers=headers
    )
    api_call_count += 1  # Increment API call count
    
    if not response.ok:
        print(f"Error fetching workspace URL: {response.text}")
        response.raise_for_status()
    
    data = response.json()
    
    if "errors" in data:
        for error in data["errors"]:
            print(f"Error: {error['message']}")
        return None
    
    return data['data']['policySetting']['value']

def fetch_identity_permissions(session, api_url, headers, days_filter=7):
    """
    Fetch identity and permissions data using the GraphQL API
    """
    global api_call_count
    
    # Define the filter based on parameters
    if days_filter:
        filter_str = f"!$.lastLoginTimestamp:null $.lastLoginTimestamp:>=T-{days_filter}d sort:-updateTimestamp"
    else:
        filter_str = "!$.lastLoginTimestamp:null sort:-updateTimestamp"
        
    # Convert to array of strings as required by the API
    filter_array = [filter_str]
    
    query = '''
    query ($filter: [String!]) {
      permissionsDetailsByIdentity(filter: $filter) {
        items {
          identity {
            turbot {
              id 
            }
            trunk {
              title
            }
            email: get(path: "email")
            title: get(path: "title")
            status: get(path: "Active")
            givenName: get(path: "givenName")
            profileId: get(path: "profileId")
            familyName: get(path: "familyName")
            displayName: get(path: "displayName")
            lastLoginTimestamp: get(path: "lastLoginTimestamp")
          }
          permissions {
            activeGrants {
              grant {
                level {
                  turbot {
                    title
                  }
                }
                type {
                  trunk {
                    title
                  }
                }
                resource {
                  turbot {
                    id
                  } 
                  trunk {
                    title
                  }
                }
              }
            }
          }
        }
      }
    }
    '''
    
    variables = {'filter': filter_array}
    response = session.post(
        api_url,
        json={'query': query, 'variables': variables},
        headers=headers
    )
    api_call_count += 1  # Increment API call count
    
    if not response.ok:
        print(f"Error fetching identity permissions: {response.text}")
        response.raise_for_status()
    
    data = response.json()
    
    if "errors" in data:
        for error in data["errors"]:
            print(f"Error: {error['message']}")
        return []
    
    return data['data']['permissionsDetailsByIdentity']['items']

def process_identity_data(items, workspace_url=None):
    """
    Process the identity data and return rows for CSV output
    
    Args:
        items: List of identity permission data items
        workspace_url: URL of the workspace for creating hyperlinks (optional)
    """
    rows = []
    
    for item in items:
        identity = item['identity']
        
        # Extract identity details
        email = identity.get('email', '')
        last_login = identity.get('lastLoginTimestamp', '')
        profile = identity.get('trunk', {}).get('title', '')
        first_name = identity.get('givenName', '')
        last_name = identity.get('familyName', '')
        profile_id = identity.get('turbot', {}).get('id', '')
        
        # Create hyperlink for profile only if workspace_url is provided
        profile_link = profile
        if workspace_url and profile_id:
            profile_link = f'=HYPERLINK("{workspace_url}/profiles/{profile_id}","{profile}")'
        
        # Process permissions
        permissions = item.get('permissions', [])
        if not permissions:
            # Add a row with no permissions
            rows.append([
                profile_link, email, first_name, last_name, last_login, '', '', ''
            ])
        else:
            for permission in permissions:
                active_grants = permission.get('activeGrants', [])
                if not active_grants:
                    # Add a row with identity but no grants
                    rows.append([
                        profile_link, email, first_name, last_name, last_login, '', '', ''
                    ])
                else:
                    for grant in active_grants:
                        grant_data = grant.get('grant', {})
                        
                        # Extract permission details
                        level = grant_data.get('level', {}).get('turbot', {}).get('title', '')
                        perm_type = grant_data.get('type', {}).get('trunk', {}).get('title', '')
                        resource_title = grant_data.get('resource', {}).get('trunk', {}).get('title', '')
                        resource_id = grant_data.get('resource', {}).get('turbot', {}).get('id', '')
                        
                        # Create hyperlink for resource only if workspace_url is provided
                        resource_link = resource_title
                        if workspace_url and resource_id:
                            resource_link = f'=HYPERLINK("{workspace_url}/resources/{resource_id}","{resource_title}")'
                        
                        # Add a row for each permission
                        rows.append([
                            profile_link, email, first_name, last_name, last_login, perm_type, level, resource_link
                        ])
    
    return rows

@click.command()
@click.option('-c', '--config-file', type=click.Path(dir_okay=False), help="[String] Pass an optional yaml config file.")
@click.option('-p', '--profile', default="default", help="[String] Profile to be used from config file.")
@click.option('-i', '--insecure', is_flag=True, help="Disable SSL certificate verification.")
@click.option('-d', '--days', default=7, type=int, help="[Integer] Number of days to look back for last login. Default is 7.")
@click.option('-o', '--output', default=None, help="[String] Output file name. Default is '{profile}_turbot_active_users_permissions_{date}.csv'.")
@click.option('--hyperlinks', is_flag=True, help="Include hyperlinks to profiles and resources in the CSV output.")
def get_identity_permissions(config_file, profile, insecure, days, output, hyperlinks):
    """Generate a CSV report of identities and their permissions"""
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
    
    print(f"Collecting identity permissions data for the last {days} day(s)...\n")
    
    api_call_count = 0  # Initialize API call count before making any requests
    
    # Fetch the workspace URL only if hyperlinks are enabled
    workspace_url = None
    if hyperlinks:
        workspace_url = fetch_workspace_url(session, api_url, headers)
        print(f"Using workspace URL: {workspace_url}")
    
    # Fetch identity permissions
    items = fetch_identity_permissions(session, api_url, headers, days)
    
    # Process the data
    rows = process_identity_data(items, workspace_url)
    
    # Define output file name if not provided
    if not output:
        # Use profile name from config as prefix for the CSV file
        sanitized_profile = profile.replace(" ", "_").replace("/", "_")
        output = f'{sanitized_profile}_turbot_active_users_permissions_{datetime.now().strftime("%Y%m%d")}.csv'
    
    # Write to CSV
    with open(output, 'w', newline='') as csvfile:
        writer = csv.writer(csvfile)
        writer.writerow([
            'profile', 'email', 'First Name', 'Last Name', 'Last login', 'Permission Type', 
            'Permission Level', 'Resource'
        ])
        writer.writerows(rows)
    
    end_time = datetime.now()
    elapsed_time = (end_time - start_time).total_seconds()
    
    print(f"Data successfully written to {output}")
    print(f"Total identities processed: {len(items)}")
    print(f"Total rows written: {len(rows)}")
    print(f"Script completed at {end_time}")
    print(f"Total time taken: {elapsed_time:.2f} seconds")
    print(f"Total API calls made: {api_call_count}")

if __name__ == '__main__':
    get_identity_permissions()