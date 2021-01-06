import jsonschema
import yaml
import logging
from os import path
import os


class BaseRecipe:
    def __init__(self, logger=logging.getLogger("Trimbot")) -> None:
        self.logger = logger

        self.resources = []
        super().__init__()

    def get_file_name(self):
        pass

    def load(self):
        try:
            recipe_location = path.join(os.getcwd(), f'./recipes/{self.get_file_name()}')
            self.logger.info(f'Loading recipe at location: {recipe_location}')
            recipe_stream = open(recipe_location, 'r')
            recipe = yaml.safe_load(recipe_stream)

            schema = self.get_config_schema()
            jsonschema.validate(instance=recipe, schema=schema)

            self.logger.info('Recipe loaded')
            self.resources = recipe["recipe"]["resources"]
        except Exception:
            self.logger.error('Unable to load recipe')
            raise

    def get_config_schema(self):
        schema = {
            '$schema': 'http://json-schema.org/schema#',
            'type': 'object',
            'properties': {
                'recipe': {
                    'type': 'object',
                    'properties': {
                        'name': {
                            'type': 'string'
                        },
                        'resources': {
                            'type': 'array',
                            'items': [
                                {
                                    'type': 'object',
                                    'properties': {
                                        'name': {
                                            'type': 'string'
                                        },
                                        'service': {
                                            'type': 'string'
                                        },
                                        'resource': {
                                            'type': 'string'
                                        },
                                        'regions': {
                                            'type': 'array',
                                            'items': [
                                                {
                                                    'type': 'string'
                                                }
                                            ]
                                        },
                                        'filters': {
                                            'type': 'array',
                                            'items': [
                                                {
                                                    'type': 'object',
                                                    'properties': {
                                                        'type': {
                                                            'type': 'string'
                                                        },
                                                        'value': {
                                                            'type': 'string'
                                                        }
                                                    },
                                                    'required': [
                                                        'type',
                                                        'value'
                                                    ]
                                                }
                                            ]
                                        },
                                        'actions': {
                                            'type': 'array',
                                            'items': [
                                                {
                                                    'type': 'string'
                                                }
                                            ]
                                        }
                                    },
                                    'required': [
                                        'name',
                                        'service',
                                        'resource',
                                        'filters'
                                    ]
                                }
                            ]
                        }
                    },
                    'required': [
                        'name',
                        'resources'
                    ]
                }
            },
            'required': [
                'recipe'
            ]
        }

        return schema


class ManagedRecipe(BaseRecipe):
    def get_file_name(self):
        return 'managed_recipe.yaml'


class MasterRecipe(BaseRecipe):
    def get_file_name(self):
        return 'master_recipe.yaml'


def load_recipe(managed_account):
    if managed_account:
        recipe = ManagedRecipe()
    else:
        recipe = MasterRecipe()

    recipe.load()

    return recipe
