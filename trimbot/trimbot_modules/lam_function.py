from .resource_service import ResourceService
from .resource import Resource
import logging


class LambdaFunction(Resource):
    def __init__(self, session, region, function) -> None:
        self.function = function
        self.region = region
        self.lambda_client = session.create_client('lambda', self.region)
        self.logger = logging.getLogger(__name__)

        super().__init__(session)

    def details(self):
        return f'lambda/function {self.function["FunctionName"]}'

    # def delete(self, dry_run):
    #     if not dry_run:
    #         self.lambda_client.delete_function(FunctionName=self.function["FunctionName"])
    #         self.logger.info(f"Removed function {self.function["FunctionName"]}")
    #     else:
    #         self.logger.info(f"Would remove function {self.function["FunctionName"]}")


class LambdaFunctionResourceService(ResourceService):
    def __init__(self, session, recipe) -> None:
        super().__init__(session, recipe, "lambda", "function")

    def create_function_names(self, session):

        lambda_client = session.create_client("lambda", session.get_default_region())
        paginator = lambda_client.get_paginator('list_functions')
        response_iterator = paginator.paginate()

        results = []
        for response in response_iterator:
            results += response.get('Functions')

        return [Functions['FunctionName'] for function in results]


    def get_all(self, region):
        
        for function_name in results:
            for filter in self.recipe["filters"]:
                if filter["type"] == "NamePrefix":
                    for value in filter["value"]:
                        if function["FunctionName"].startswith(value):
                            resources.append(FunctionName(self.session, region, function))

        return []