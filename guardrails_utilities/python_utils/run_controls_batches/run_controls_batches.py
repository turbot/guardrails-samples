import click
import turbot
import requests
import time
from datetime import datetime


@click.command()
@click.option('-c', '--config-file', type=click.Path(dir_okay=False), help="[String] Pass an optional yaml config file.")
@click.option('-p', '--profile', default="default", help="[String] Profile to be used from config file.")
@click.option('-f', '--filter', default="state:tbd", help="[String] Used to filter out matching controls.")
@click.option('-b', '--batch', default=100, help="[Int] The number of controls to run before cooldown per cycle.")
@click.option('-s', '--start-index', default=0, help="[Int] Sets the starting point in the returned control collection. All controls starting at the starting point will be run.")
@click.option('-d', '--cooldown', default=120, help="[Int] Number of seconds to pause before the next batch of controls are run. Setting this value to `0` will disable cooldown.")
@click.option('-m', '--max-batch', default=-1, help="[Int] The maximum number of batches to run. The value `-1` will run all the returned controls from the starting point.")
@click.option('-e', '--execute', is_flag=True, help="Will re-run controls when found.")
@click.option('-i', '--insecure', is_flag=True, help="Disable SSL certificate verification.")
def run_controls(config_file, profile, filter, batch, start_index, cooldown, max_batch, execute, insecure):
    """ Finds all controls matching the provided filter, then re-runs them if --execute is set."""
    """
        Example Filters
        ---------------
        Run controls in TBD state (Default):  "state:tbd"
        Run controls in error state:          "state:error"
        Run controls in multiple states:      "state:tbd,error,alarm"
        Re-run installed controls:            "state:tbd,error controlType:'tmod:@turbot/turbot#/control/types/controlInstalled'"
        Re-run AWS Event Handler controls:    "controlType:'tmod:@turbot/aws#/control/types/eventHandlers'"
        Re-run Discovery controls:            "Discovery controlCategory:'tmod:@turbot/turbot#/control/categories/cmdb'"
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
        targets: controls(filter: $filter, paging: $paging) {
          items {
            turbot { id }
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
      mutation RunControl($input: RunControlInput!) {
        runControl(input: $input) {
          turbot {
            id
          }
        }
      }
    '''

    completed_controls = 0
    skipped_controls = 0
    for index in range(start_index, total_targets):
        control = targets[index]

        # Validate control object
        if control is None:
            print(f"Skipping control at index {index} due to being None.")
            skipped_controls += 1
            continue
        if 'turbot' not in control or 'id' not in control['turbot']:
            print(f"Skipping control at index {index} due to missing required keys.")
            skipped_controls += 1
            continue

        control_id = control['turbot']['id']
        vars = {'input': {'id': control_id}}
        
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
                    print(f"Skipping control ID {control_id} due to {error['message']}")
                skipped_controls += 1
                continue

            # Ensure runControl is not None
            if 'data' not in result or 'runControl' not in result['data'] or result['data']['runControl'] is None:
                print(f"Skipping control ID {control_id} due to missing mutation data.")
                skipped_controls += 1
                continue

            process_id = result['data']['runControl']['turbot']['id']
            print(f'{{"controlId": "{control_id}", "processId": "{process_id}"}}')
            completed_controls += 1

        except requests.exceptions.RequestException as e:
            print(f"Error occurred during mutation for control ID {control_id}: {e}")
            skipped_controls += 1
            continue
        except Exception as e:
            print(f"Unexpected error during mutation for control ID {control_id}: {e}")
            skipped_controls += 1
            continue

        # Batch and cooldown handling
        if (completed_controls % batch == 0 or completed_controls + skipped_controls == total_targets):
            print(
                f"Triggered {completed_controls} of {total_targets} controls. "
                f"Skipped {skipped_controls} so far.", end=""
            )
            if completed_controls + skipped_controls < total_targets and cooldown > 0:
                print(f" Waiting for {cooldown} seconds before running the next batch...")
                time.sleep(cooldown)
            else:
                print()

    end_time = datetime.now()  # Record script end time
    elapsed_time = (end_time - start_time).total_seconds()

    print("\nSummary:")
    print(f"Total Targets Retrieved: {total_targets}")
    print(f"Total Controls Triggered: {completed_controls}")
    print(f"Total Controls Skipped: {skipped_controls}")
    print(f"Total Time Taken: {elapsed_time:.2f} seconds")

if __name__ == "__main__":
    try:
        run_controls()
    except Exception as e:
        print(e)