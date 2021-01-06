import jsonschema
import yaml
import logging


class Configuration:
    def __init__(self, config_file) -> None:
        try:
            config = yaml.safe_load(config_file)

            schema = self.get_config_schema()
            jsonschema.validate(instance=config, schema=schema)

            self.workspaces = config['workspaces']
            super().__init__()

        except yaml.YAMLError as e:
            logging.error(
                f'Error occurred while trying to load the configuration file {config_file.name}')
            raise
        except jsonschema.exceptions.ValidationError as e:
            logging.error('Config file schema validation error')
            raise

    def get_config_schema(self):
        schema = {
            '$schema': 'http://json-schema.org/schema#',
            'type': 'object',
            'properties': {
                'workspaces': {
                    'type': 'array',
                    'items': [
                        {
                            'type': 'object',
                            'properties': {
                                'account': {'type': 'string'},
                                'roleArn': {'type': 'string'}
                            },
                            'required': [
                                'account'
                            ]
                        }
                    ]
                }
            },
            'required': [
                'workspaces'
            ]
        }

        return schema
