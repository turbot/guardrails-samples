import jsonschema
import yaml
import logging


class Workspace:
    def __init__(self, workspace) -> None:
        self.workspace = workspace
        super().__init__()

    def get_role_arn(self):
        return self.workspace["roleArn"] if "roleArn" in self.workspace else ""

    def get_external_id(self):
        return self.workspace["externalId"] if "externalId" in self.workspace else ""

    def get_account(self):
        return self.workspace["account"] if "account" in self.workspace else ""

    def get_verify_ssl(self):
        return self.workspace["verifySsl"] if "verifySsl" in self.workspace else None

    def get_profile(self):
        return self.workspace["profile"] if "profile" in self.workspace else ""

    def get_recipe(self):
        return self.workspace["recipe"] if "recipe" in self.workspace else ""

    def get_turbot_host(self):
        host = ""
        if "turbot" in self.workspace and "host" in self.workspace["turbot"]:
            host = self.workspace["turbot"]["host"]

        return host

    def get_turbot_access_key(self):
        access_key = ""
        if "turbot" in self.workspace and "accessKey" in self.workspace["turbot"]:
            access_key = self.workspace["turbot"]["accessKey"]

        return access_key

    def get_turbot_secret_access_key(self):
        secret_access_key = ""
        if "turbot" in self.workspace and "secretAccessKey" in self.workspace["turbot"]:
            secret_access_key = self.workspace["turbot"]["secretAccessKey"]

        return secret_access_key

    def get_turbot_account(self):
        account = ""
        if "turbot" in self.workspace and "account" in self.workspace["turbot"]:
            account = self.workspace["turbot"]["account"]

        return account


class Configuration:
    def __init__(self, config_file) -> None:
        try:
            self.config = yaml.safe_load(config_file)

            schema = self.get_config_schema()
            jsonschema.validate(instance=self.config, schema=schema)

            self.workspaces = self.create_workspaces(self.config['workspaces'])
            super().__init__()

        except yaml.YAMLError as e:
            logging.error(
                f'Error occurred while trying to load the configuration file {config_file.name}')
            raise
        except jsonschema.exceptions.ValidationError as e:
            logging.error('Config file schema validation error')
            raise

    def create_workspaces(self, workspaces):
        workspace_list = []
        for workspace in workspaces:
            workspace_list.append(Workspace(workspace))

        return workspace_list

    def get_recipe(self):
        return self.config["recipe"]

    def get_verify_ssl(self):
        return self.config["verifySsl"] if "verifySsl" in self.config else False

    def get_profile(self):
        return self.config["profile"] if "profile" in self.config else "default"

    def get_turbot_host(self):
        host = ""
        if "turbot" in self.config and "host" in self.config["turbot"]:
            host = self.config["turbot"]["host"]

        return host

    def get_turbot_access_key(self):
        access_key = ""
        if "turbot" in self.config and "accessKey" in self.config["turbot"]:
            access_key = self.config["turbot"]["accessKey"]

        return access_key

    def get_turbot_secret_access_key(self):
        secret_access_key = ""
        if "turbot" in self.config and "secretAccessKey" in self.config["turbot"]:
            secret_access_key = self.config["turbot"]["secretAccessKey"]

        return secret_access_key

    def get_turbot_account(self):
        account = ""
        if "turbot" in self.config and "account" in self.config["turbot"]:
            account = self.config["turbot"]["account"]

        return account

    def get_config_schema(self):
        schema = {
            "$schema": "http://json-schema.org/schema#",
            "type": "object",
            "properties": {
                "recipe": {
                    "type": "string"
                },
                "workspaces": {
                    "type": "array",
                    "items": [
                        {
                            "type": "object",
                            "properties": {
                                "verifySsl": {
                                    "type": "boolean"
                                },
                                "account": {
                                    "type": "string"
                                },
                                "turbotAccount": {
                                    "type": "string"
                                },
                                "roleArn": {
                                    "type": "string"
                                },
                                "externalId": {
                                    "type": "string"
                                }
                            },
                            "anyOf": [
                                {
                                    "required": [
                                        "account",
                                        "externalId",
                                        "roleArn",
                                        "turbotAccount",
                                    ]
                                },
                                {
                                    "required": [
                                        "account",
                                        "turbotAccount",
                                        "roleArn"
                                    ],
                                    "not": {
                                        "required": [
                                            "externalId"
                                        ]
                                    }
                                },
                                {
                                    "required": [
                                        "account"
                                    ],
                                    "not": {
                                        "required": [
                                            "turbotAccount",
                                            "roleArn",
                                            "externalId"
                                        ]
                                    }
                                },

                            ]
                        }
                    ]
                }
            },
            "required": [
                "recipe",
                "workspaces"
            ]
        }

        return schema
