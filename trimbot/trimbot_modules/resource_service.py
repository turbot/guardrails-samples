from boto3 import resource


class ResourceService:
    def __init__(self, session, recipe, service_name, resource_name, global_resource=False) -> None:
        self.session = session
        self.recipe = recipe
        self.service_name = service_name
        self.resource_name = resource_name
        self.global_resource = global_resource
        self.user_defined_name = recipe["name"]

        super().__init__()

    def is_global_service(self):
        return self.global_resource

    def get_user_defined_name(self):
        return self.user_defined_name

    def get_resource_name(self):
        return self.resource_name

    def get_service_name(self):
        return self.service_name

    def get_all(self, region):
        pass
