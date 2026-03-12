import turbot
import click
import requests
import sys
import time


@click.command()
@click.option('-c', '--config-file', type=click.Path(dir_okay=False), help="[String] Pass an optional YAML config file.")
@click.option('-p', '--profile', default="default", help="[String] Profile to be used from the config file.")
@click.option('-r', '--resource-id', required=True, help="[String] ID of the parent resource to delete along with its descendants.")
@click.option('-b', '--batch', default=100, help="[Int] Number of resources to delete per batch.")
@click.option('-d', '--cooldown', default=30, help="[Int] Cooldown time in seconds between batches.")
@click.option('--execute', is_flag=True, help="Execute the deletion process.")
@click.option('--disable', is_flag=True, help="Set discovery-related policies to 'Skip' before deletion.")
@click.option('-i', '--insecure', is_flag=True, help="Disable SSL certificate verification.")
def delete_resources(config_file, profile, resource_id, batch, cooldown, execute, disable, insecure):
    """
    This script optionally disables discovery-related policies for a resource (--disable)
    and then deletes the resource and its descendants.
    """
    start_time = time.time()

    # Validate profile and connection
    try:
        config = turbot.Config(config_file, profile)
        headers = {'Authorization': f'Basic {config.auth_token}'}
        endpoint = config.graphql_endpoint
    except Exception as e:
        print(f"Error setting up configuration or connection: {e}")
        sys.exit(1)

    # Handle SSL verification
    requests.packages.urllib3.disable_warnings()
    session = requests.Session()
    session.verify = not insecure

    if disable:
        print(f"\nDisabling discovery policies for resource ID: {resource_id}...")
        handle_cmdb_policies(endpoint, headers, resource_id)

    print("\nFetching descendants for deletion...")
    descendants = fetch_descendants(endpoint, headers, resource_id)
    if not descendants:
        print("No resources found to delete.")
        return

    print(f"\nFound {len(descendants)} resources (including parent) to delete.")

    if not execute:
        print("\n--execute flag not set. Exiting without deletion.")
        return

    print("\nStarting resource deletion...")
    delete_resources_in_batches(endpoint, headers, descendants, batch, cooldown)

    end_time = time.time()
    elapsed_time = end_time - start_time
    print(f"\nProcess completed in {elapsed_time:.2f} seconds.")


def handle_cmdb_policies(endpoint, headers, parent_resource_id):
    """
    Fetch and set CMDB policies to 'Skip' for the given resource.
    """
    cmdb_policy_query = '''
    query Policies($filter: [String!]!) {
        policies: policyTypes(filter: $filter) {
            items {
                uri
            }
            metadata {
                stats {
                    total
                }
            }
        }
    }
    '''
    cmdb_policy_filter = f"resourceId:{parent_resource_id} Cmdb -CmdbAttributes"
    policies = run_query(endpoint, headers, cmdb_policy_query, {'filter': cmdb_policy_filter})['data']['policies']['items']

    if not policies:
        print("No CMDB policies found.")
        return

    print(f"Found {len(policies)} policies to update.")

    find_setting_query = '''
    query FindSetting($filter: [String!]!) {
        policySettings(filter: $filter) {
            items {
                turbot {
                    id
                }
            }
            metadata {
                stats {
                    total
                }
            }
        }
    }
    '''

    for policy in policies:
        policy_uri = policy['uri']
        # Create the filter dynamically
        filter_value = [f"resourceId:'{parent_resource_id}' policyTypeId:'{policy_uri}'"]
        # Pass the filter as a list
        setting_result = run_query(endpoint, headers, find_setting_query, {'filter': filter_value})
        setting_exists = setting_result['data']['policySettings']['metadata']['stats']['total'] > 0

        if setting_exists:
            policy_setting_id = setting_result['data']['policySettings']['items'][0]['turbot']['id']
            update_mutation = '''
            mutation UpdatePolicySetting($input: UpdatePolicySettingInput!) {
                updatePolicySetting(input: $input) {
                    turbot {
                        id
                    }
                }
            }
            '''
            update_vars = {
                "input": {
                    "id": policy_setting_id,
                    "precedence": "REQUIRED",
                    "value": "Skip",
                    "note": "Set via delete script to prevent re-discovery"
                }
            }
            print(f"Updating policy {policy_uri} to 'Skip'...")
            run_query(endpoint, headers, update_mutation, update_vars)
        else:
            create_mutation = '''
            mutation CreatePolicySetting($input: CreatePolicySettingInput!) {
                createPolicySetting(input: $input) {
                    turbot {
                        id
                    }
                }
            }
            '''
            create_vars = {
                "input": {
                    "type": policy_uri,
                    "resource": parent_resource_id,
                    "precedence": "REQUIRED",
                    "value": "Skip",
                    "note": "Set via delete script to prevent re-discovery"
                }
            }
            print(f"Creating policy {policy_uri} with 'Skip'...")
            run_query(endpoint, headers, create_mutation, create_vars)


def fetch_descendants(endpoint, headers, parent_resource_id):
    """
    Fetch descendants of a resource for deletion.
    """
    query = '''
    query Descendants($id: ID!, $filter: [String!], $paging: String) {
        resource(id: $id) {
            children(filter: $filter, paging: $paging) {
                items {
                    turbot {
                        id
                    }
                }
                paging {
                    next
                }
            }
        }
    }
    '''
    variables = {'id': parent_resource_id, 'filter': ["level:descendant"], 'paging': None}
    result = run_query(endpoint, headers, query, variables)

    # Check if the resource exists
    if not result.get('data') or not result['data'].get('resource'):
        print(f"Resource with ID {parent_resource_id} does not exist.")
        return []

    # Proceed to fetch descendants
    descendants = []
    while True:
        children = result['data']['resource']['children']
        items = children.get('items', [])
        descendants.extend(items)

        paging = children.get('paging', {}).get('next')
        if not paging:
            break

        # Fetch next page of descendants
        variables['paging'] = paging
        result = run_query(endpoint, headers, query, variables)

    # Add the parent resource itself for deletion
    descendants.append({'turbot': {'id': parent_resource_id}})
    return descendants

def delete_resources_in_batches(endpoint, headers, resources, batch_size, cooldown):
    """
    Delete resources in batches with cooldown periods.
    """
    mutation = '''
    mutation DeleteResource($input: DeleteResourceInput!) {
        deleteResource(input: $input) {
            turbot {
                id
            }
        }
    }
    '''
    total_resources = len(resources)
    deleted = 0
    skipped = 0
    failed = 0

    for index, resource in enumerate(resources):
        resource_id = resource['turbot']['id']
        variables = {'input': {'id': resource_id}}
        print(f"Deleting resource {resource_id}...")

        try:
            run_query(endpoint, headers, mutation, variables)
            deleted += 1
        except Exception as e:
            error_msg = str(e)
            # Handle "Not Found" errors gracefully - resource may have been deleted already
            # or deleted as a child of a parent resource
            if "Not Found" in error_msg or "not found" in error_msg.lower():
                print(f"  ⚠️  Resource {resource_id} not found (may have been already deleted) - skipping...")
                skipped += 1
            else:
                # Re-raise other errors (permissions, network, etc.)
                print(f"  ❌ Failed to delete resource {resource_id}: {error_msg}")
                failed += 1
                # Continue processing other resources instead of crashing
                # Uncomment the line below if you want to stop on any non-Not-Found error:
                # raise

        # Cooldown logic
        processed = deleted + skipped + failed
        if processed % batch_size == 0 and processed < total_resources:
            print(f"Cooldown: Waiting {cooldown} seconds before the next batch...")
            time.sleep(cooldown)

    print(f"\n{'='*60}")
    print(f"Deletion Summary:")
    print(f"  ✅ Successfully deleted: {deleted} resources")
    print(f"  ⚠️  Skipped (not found): {skipped} resources")
    print(f"  ❌ Failed: {failed} resources")
    print(f"  📊 Total processed: {deleted + skipped + failed} / {total_resources} resources")
    print(f"{'='*60}")


def run_query(endpoint, headers, query, variables):
    """
    Helper function to execute a GraphQL query or mutation.
    """
    response = requests.post(endpoint, headers=headers, json={'query': query, 'variables': variables}, verify=False)
    if response.status_code == 200:
        result = response.json()
        # Check for GraphQL errors in the response
        if 'errors' in result:
            error_messages = [err.get('message', str(err)) for err in result['errors']]
            raise Exception(f"GraphQL errors: {'; '.join(error_messages)}")
        return result
    elif response.status_code == 401:
        error_text = response.text
        if "PingFed" in error_text or "SSO" in error_text or "Directory" in error_text:
            raise Exception(
                f"Authentication failed (401): This workspace requires SSO/SAML authentication.\n"
                f"The script currently only supports API key (Basic) authentication.\n"
                f"Error details: {error_text}\n"
                f"Please contact your Guardrails administrator to:\n"
                f"  1. Generate API keys for programmatic access, OR\n"
                f"  2. Configure SSO to allow API key authentication"
            )
        else:
            raise Exception(f"Authentication failed (401): {error_text}")
    else:
        raise Exception(f"Query failed with status code {response.status_code}: {response.text}")


if __name__ == "__main__":
    if sys.version_info >= (3, 5):
        delete_resources()
    else:
        print("This script requires Python 3.5 or newer.")