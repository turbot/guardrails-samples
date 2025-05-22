import os
from base64 import b64encode
from xdg import XDG_CONFIG_HOME
import yaml
import requests


class Config:
    """ Locates the users Turbot credentials, verifies connectivity to
        the specified Turbot workspace and instantiates a config object. """

    def __init__(self, custom_config_file, config_profile):

        config_dict = {}
        config_fail = ""
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

            print("Testing connection to {} ...".format(self.workspace))
            self.test_health()
            auth_bytes = '{}:{}'.format(
                self.accessKey, self.secretKey).encode("utf-8")
            self.auth_token = b64encode(auth_bytes).decode()

        else:
            print("Failed to find suitable configuration, please see README")
            exit()

    def test_health(self):
        try:
            r = requests.get(self.health_endpoint, verify=False)
        except requests.exceptions.ConnectionError:
            print("Failed to connect, exiting.")
            exit()

        if r.status_code == requests.codes.ok:
            print("Success! Status Code: {}".format(r.status_code))
        else:
            print("Failure! Status Code: {}".format(r.status_code))
            r.raise_for_status()
