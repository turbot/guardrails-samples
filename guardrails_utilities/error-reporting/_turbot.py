import os
from base64 import b64encode
from xdg import XDG_CONFIG_HOME
import yaml
import requests
import traceback

class Config:
    """ Locates the users Turbot credentials, verifies connectivity to
        the specified Turbot workspace and instantiates a config object. """

    def __init__(self, custom_config_file, config_profile, debug=False, custom_credentials_file=None):

        config_dict = {}
        config_fail = ""
        # Use custom credentials file if provided, otherwise use default
        if custom_credentials_file:
            turbot_config = custom_credentials_file
        else:
            turbot_config = "{}/turbot/credentials.yml".format(XDG_CONFIG_HOME)
        graphql_path = 'api/latest/graphql'
        health_path = 'api/latest/turbot/health'

        # Option 1: Use custom yaml configuration file.
        if custom_config_file:
            with open(custom_config_file, 'r') as stream:
                try:
                    config_dict = yaml.safe_load(stream)
                except yaml.YAMLError as exc:
                    print(exc)

        # Option 2: Use environment variables
        elif (os.getenv("TURBOT_ACCESS_KEY_ID") and os.getenv("TURBOT_SECRET_ACCESS_KEY")):
            config_dict[config_profile] = {}
            config_dict[config_profile]['accessKey'] = os.getenv(
                "TURBOT_ACCESS_KEY_ID")
            config_dict[config_profile]['secretKey'] = os.getenv(
                "TURBOT_SECRET_ACCESS_KEY")

            # Option 2a: Use TURBOT_WORKSPACE environment variable
            if os.getenv("TURBOT_WORKSPACE"):
                config_dict[config_profile]['workspace'] = os.getenv(
                    "TURBOT_WORKSPACE")

            # Option 2b: Use TURBOT_GRAPHQL_ENDPOINT environment variable
            elif os.getenv("TURBOT_GRAPHQL_ENDPOINT"):
                if os.getenv("TURBOT_GRAPHQL_ENDPOINT").endswith(graphql_path):
                    config_dict[config_profile]['workspace'] = os.getenv(
                        "TURBOT_GRAPHQL_ENDPOINT")[:-len(graphql_path)]
                else:
                    config_fail = "Incorrect TURBOT_GRAPHQL_ENDPOINT format, exiting..."
            else:
                config_fail = "No workspace found in environment vars, exiting..."

        # Option 3: Use Turbot xdg configuration file (e.g. ~/.config/turbot/configuration.yml)
        elif os.path.exists(turbot_config):
            with open(turbot_config, 'r') as stream:
                try:
                    config_dict = yaml.safe_load(stream)
                except yaml.YAMLError as exc:
                    print(exc)

        if len(config_fail):
            print(config_fail)
            exit()

        if config_dict:

            if not config_profile in config_dict:
                config_fail = "No matching profile, exiting..."

            if not all(k in config_dict[config_profile] for k in ("workspace", "accessKey", "secretKey")):
                config_fail = "Incorrect config file format, exiting..."

            if len(config_fail):
                print(config_fail)
                exit()

            self.workspace = config_dict[config_profile]['workspace']
            self.accessKey = config_dict[config_profile]['accessKey']
            self.secretKey = config_dict[config_profile]['secretKey']
            # Set and Test Endpoints
            if self.workspace.endswith("/"):
                self.graphql_endpoint = "{}{}".format(
                    self.workspace, graphql_path)
                self.health_endpoint = "{}{}".format(
                    self.workspace, health_path)
            else:
                self.graphql_endpoint = "{}/{}".format(
                    self.workspace, graphql_path)
                self.health_endpoint = "{}/{}".format(
                    self.workspace, health_path)

            if debug:
                print("Testing connection to {} ...".format(self.workspace))
            self.test_health(debug)
            auth_bytes = '{}:{}'.format(
                self.accessKey, self.secretKey).encode("utf-8")
            self.auth_token = b64encode(auth_bytes).decode()

        else:
            print("Failed to find suitable configuration, please see README")
            exit()

    # def test_health(self):
    #     try:
    #         r = requests.get(self.health_endpoint)
    #     except requests.exceptions.ConnectionError:
    #         print("Failed to connect, exiting.")
    #         exit()

    #     if r.status_code == requests.codes.ok:
    #         print("Success! Status Code: {}".format(r.status_code))
    #     else:
    #         print("Failure! Status Code: {}".format(r.status_code))
    #         r.raise_for_status()
    
    def test_health(self, debug=False):
        if debug:
            print(f"Testing health endpoint: {self.health_endpoint}")
        try:
            r = requests.get(self.health_endpoint, timeout=5)
        except requests.exceptions.ConnectionError as e:
            print("Failed to connect to the endpoint.")
            if debug:
                print(f"Exception: {e}")
                traceback.print_exc()
            exit(1)
        except requests.exceptions.Timeout:
            print("Request timed out.")
            exit(1)
        except Exception as e:
            print("An unexpected error occurred.")
            if debug:
                print(f"Exception: {e}")
                traceback.print_exc()
            exit(1)

        if debug:
            print(f"Response received. Status Code: {r.status_code}")
            print(f"Response Headers: {r.headers}")
            print(f"Response Body: {r.text}")

        if r.status_code == requests.codes.ok:
            if debug:
                print("Health check succeeded.")
        else:
            print("Health check failed.")
            r.raise_for_status()

    def graphql_query(self, query, variables=None, timeout=240):
        """Execute a GraphQL query against the Turbot workspace
        
        Args:
            query (str): The GraphQL query string
            variables (dict): Optional variables for the query
            timeout (int): Request timeout in seconds (default: 240)
            
        Returns:
            dict: The JSON response from the GraphQL endpoint
            
        Raises:
            requests.exceptions.RequestException: On network errors
            SystemExit: On GraphQL errors
        """
        headers = {
            'Authorization': f'Basic {self.auth_token}',
            'Content-Type': 'application/json'
        }
        
        payload = {
            'query': query
        }
        
        if variables:
            payload['variables'] = variables
            
        try:
            response = requests.post(
                self.graphql_endpoint,
                json=payload,
                headers=headers,
                timeout=timeout
            )
            response.raise_for_status()
            
            result = response.json()
            
            # Check for GraphQL errors
            if "errors" in result:
                print("GraphQL errors:")
                for error in result['errors']:
                    print(f"  {error}")
                print(f"Query: {query[:200]}...")
                print(f"Variables: {variables}")
                exit()
                
            return result
            
        except requests.exceptions.RequestException as e:
            print(f"Request failed: {e}")
            if hasattr(e, 'response') and e.response is not None:
                try:
                    error_detail = e.response.json()
                    print(f"Error details: {error_detail}")
                except:
                    print(f"Response text: {e.response.text[:500]}")
            exit()