import jsonschema
import yaml
import logging
from os import path
import os


class Recipe:
    def __init__(self, location) -> None:
        self.logger = logging.getLogger(__name__)
        self.location = location

        self.resources = []
        super().__init__()

    def load(self):
        try:
            recipe_location = path.join(os.getcwd(), self.location)
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
            "$schema": "http://json-schema.org/schema#",
            "type": "object",
            "properties": {
                "recipe": {
                    "type": "object",
                    "properties": {
                        "name": {
                            "type": "string"
                        },
                        "resources": {
                            "type": "array",
                            "items": [
                                {
                                    "type": "object",
                                    "properties": {
                                        "name": {
                                            "type": "string"
                                        },
                                        "service": {
                                            "type": "string"
                                        },
                                        "resource": {
                                            "type": "string"
                                        },
                                        "verifySsl": {
                                            "type": "boolean"
                                        },
                                        "filters": {
                                            "type": "array",
                                            "items": [
                                                {
                                                    "type": "object",
                                                    "properties": {
                                                        "field": {
                                                            "type": "string"
                                                        },
                                                        "type": {
                                                            "type": "string"
                                                        },
                                                        "value": {
                                                            "type": ["array", "string"],
                                                            "items": [
                                                                {
                                                                    "type": "string"
                                                                }
                                                            ]
                                                        },
                                                    },
                                                    "oneOf": [
                                                        {
                                                            "required": [
                                                                "field",
                                                                "value"
                                                            ]
                                                        },
                                                        {
                                                            "required": [
                                                                "type",
                                                                "value"
                                                            ]
                                                        },
                                                    ]
                                                }
                                            ]
                                        },
                                        "actions": {
                                            "type": "array",
                                            "items": [
                                                {
                                                    "type": "string"
                                                }
                                            ]
                                        }
                                    },
                                    "required": [
                                        "name",
                                        "service",
                                        "resource",
                                        "actions"
                                    ]
                                }
                            ]
                        }
                    },
                    "required": [
                        "name",
                        "resources"
                    ]
                }
            },
            "required": [
                "recipe"
            ]
        }

        return schema
