import click
import turbot
import requests
import time
from datetime import datetime


@click.command()
@click.option('-c', '--config-file', type=click.Path(dir_okay=False), help="[String] Pass an optional yaml config file.")
@click.option('-p', '--profile', default="default", help="[String] Profile to be used from config file.")
@click.option('-f', '--filter', default="state:tbd", help="[String] Used to filter out matching policies.")
@click.option('-b', '--batch', default=100, help="[Int] The number of policies to run before cooldown per cycle.")
@click.option('-s', '--start-index', default=0, help="[Int] Sets the starting point in the returned policy collection. All policies starting at the starting point will be run.")
@click.option('-d', '--cooldown', default=120, help="[Int] Number of seconds to pause before the next batch of policies are run. Setting this value to `0` will disable cooldown.")
@click.option('-m', '--max-batch', default=-1, help="[Int] The maximum number of batches to run. The value `-1` will run all the returned policies from the starting point.")
@click.option('-e', '--execute', is_flag=True, help="Will re-run policies when found.")
@click.option('-i', '--insecure', is_flag=True, help="Disable SSL certificate verification.")
def run_policies(config_file, profile, filter, batch, start_index, cooldown, max_batch, execute, insecure):
    """ Finds all policies matching the provided filter, then re-runs them if --execute is set."""
    """
        Example Filters
        ---------------
        Run policies in TBD (Default):          "state:tbd"
        Run policies in error state:            "state:error"
        Run policies in multiple states:        "state:tbd,error,invalid"
        Re-run CMDB policies:                   "controlCategoryId:'tmod:@turbot/turbot#/control/categories/cmdb'"
        Re-run policies that match policy type: "policyTypeId:'tmod:@turbot/azure-activedirectory#/policy/types/directoryCmdb'"
    """
    start_time = datetime.now()  # Record script start time

    # Validate the profile and connection
    try:
        config = turbot.Config(config_file, profile)
        headers = {'Authorization': f'Basic {config.auth_token}'}
        endpoint_url = config.graphql_endpoint
        # print(f"Testing connection to {endpoint_url} ...")
        # print("Connection successful!\n")
    except KeyError:
        print(f"Error: The profile '{profile}' does not exist in the configuration file.")
        print("Please check your configuration file or specify a valid profile using the -p option.")
        return
    except requests.exceptions.RequestException as e:
        print(f"Error: Unable to connect to the endpoint. {e}")
        return
    except Exception as e:
        print(f"Error: Unable to load configuration or connect to the endpoint. {e}")
        return

    # Set up a requests session
    session = requests.Session()
    session.verify = not insecure  # Disable SSL verification if insecure is True

    if insecure:
        requests.packages.urllib3.disable_warnings()

    print(f"\nUsing the filter: {filter}")
    print("Looking for targets...")

    query = '''
      query Targets($filter: [String!]!, $paging: String) {
        targets: policyValues(filter: $filter, paging: $paging) {
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
    '''

    targets = []
    paging = None

    while True:
        variables = {'filter': filter, 'paging': paging}
        try:
            response = session.post(
                endpoint_url,
                json={'query': query, 'variables': variables},
                headers=headers
            )
            response.raise_for_status()
            result = response.json()

            if "errors" in result:
                for error in result["errors"]:
                    print(f"Error: {error['message']}")
                print("Query failed. Please check the filter or query syntax and try again.")
                return

            for item in result['data']['targets']['items']:
                targets.append(item)
            if not result['data']['targets']['paging']['next']:
                break
            else:
                print("{} found...".format(len(targets)))
                paging = result['data']['targets']['paging']['next']

        except requests.exceptions.RequestException as e:
            print(f"Error occurred during request: {e}")
            return

    total_targets = len(targets)
    print(f"\nFound {total_targets} Total Targets")

    if not execute:
        print("\n --execute flag not set. Exiting.")
        return

    mutation = '''
      mutation RunPolicy($input: RunPolicyInput!) {
        runPolicy(input: $input) {
          turbot {
            id
          }
        }
      }
    '''

    completed_policies = 0
    skipped_policies = 0
    for index in range(start_index, total_targets):
        policy = targets[index]

        # Validate policy object
        if policy is None:
            print(f"Skipping policy at index {index} due to being None.")
            skipped_policies += 1
            continue
        if 'turbot' not in policy or 'id' not in policy['turbot']:
            print(f"Skipping policy at index {index} due to missing required keys.")
            skipped_policies += 1
            continue

        policy_id = policy['turbot']['id']
        vars = {'input': {'id': policy_id}}

        try:
            response = session.post(
                endpoint_url,
                json={'query': mutation, 'variables': vars},
                headers=headers
            )
            response.raise_for_status()
            result = response.json()

            # Check for errors in the response
            if "errors" in result:
                for error in result["errors"]:
                    print(f"Skipping policy ID {policy_id} due to {error['message']}")
                skipped_policies += 1
                continue

            # Ensure runPolicy is not None
            if 'data' not in result or 'runPolicy' not in result['data'] or result['data']['runPolicy'] is None:
                print(f"Skipping policy ID {policy_id} due to missing mutation data.")
                skipped_policies += 1
                continue

            process_id = result['data']['runPolicy']['turbot']['id']
            print(f'{{"policyId": "{policy_id}", "processId": "{process_id}"}}')
            completed_policies += 1

        except requests.exceptions.RequestException as e:
            print(f"Error occurred during mutation for policy ID {policy_id}: {e}")
            skipped_policies += 1
            continue
        except Exception as e:
            print(f"Unexpected error during mutation for policy ID {policy_id}: {e}")
            skipped_policies += 1
            continue

        # Batch and cooldown handling
        if (completed_policies % batch == 0 or completed_policies + skipped_policies == total_targets):
            print(
                f"Triggered {completed_policies} of {total_targets} policies. "
                f"Skipped {skipped_policies} so far.", end=""
            )
            if completed_policies + skipped_policies < total_targets and cooldown > 0:
                print(f" Waiting for {cooldown} seconds before running the next batch...")
                time.sleep(cooldown)
            else:
                print()

    end_time = datetime.now()  # Record script end time
    elapsed_time = (end_time - start_time).total_seconds()

    print("\nSummary:")
    print(f"Total Policies Retrieved: {total_targets}")
    print(f"Total Policies Triggered: {completed_policies}")
    print(f"Total Policies Skipped: {skipped_policies}")
    print(f"Total Time Taken: {elapsed_time:.2f} seconds")


if __name__ == "__main__":
    try:
        run_policies()
    except Exception as e:
        print(e)