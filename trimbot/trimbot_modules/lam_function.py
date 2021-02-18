from .resource_service import ResourceService
from .resource import Resource
import logging


class LambdaFunction(Resource):
    def __init__(self, session, region, function_name) -> None:
        self.function_name = function_name
        self.region = region
        self.lambda_client = session.create_client('lambda', self.region)
        self.logger = logging.getLogger(__name__)

        super().__init__(session)

    def details(self):
        return f'lambda/function {self.function_name}'

    def delete(self, dry_run):
        if not dry_run:
            self.lambda_client.delete_function(FunctionName=self.function_name)
            self.logger.info(f"Removed function {self.function_name}")
        else:
            self.logger.info(f"Would remove function {self.function_name}")

class LambdaFunctionResourceService(ResourceService):
    def __init__(self, session, recipe) -> None:
        super().__init__(session, recipe, "lambda", "function")
    
    def get_all(self, region):
        lambda_client = self.session.create_client("lambda", region)
        paginator = lambda_client.get_paginator('list_functions')
        response_iterator = paginator.paginate()
        
        results = []
        for response in response_iterator:
            results += response.get('Functions')
        
        function_names = [function['FunctionName'] for function in results]
    
        resources = []
        for function_name in function_names:
            for filter in self.recipe["filters"]:
                if filter["type"] == "startswith":
                    for value in filter["value"]:
                        if function_name.startswith(value):
                            resources.append(LambdaFunction(self.session, region, function_name))
        return resources