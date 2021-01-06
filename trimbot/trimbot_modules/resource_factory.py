class ResourceFactory:
    def __init__(self, session) -> None:
        self.client_map = self.create_client_map()
        self.session = session
        super().__init__()

    def create_client(self, service, resource):
        key = f'{service}_{resource}'

        if key not in self.client_map:
            message = f'Resource factory unable to create a resource instance for service {service} and resource {resource}'
            raise RuntimeError(message)

        return self.client_map[key](self.session)

    def create_client_map(self):
        return {}
        # return {
        #     "sts_client": StsClient,
        #     "dynamodb_table": DynamoDbTable,
        #     "s3_bucket": S3Bucket,
        #     "cloudformation_stack": CfStack,
        #     "sqs_queue": SqsQueue,
        #     "codecommit_repo": CodeCommitRepo,
        #     "events_rule": EventsRule,
        #     "iam_policy": IamPolicy,
        #     "iam_group": IamGroup,
        #     "iam_user": IamUser,
        #     "iam_role": IamRole,
        #     "sns_topic": SnsTopic,
        #     "awslambda_function": LambdaFunction,
        #     "logs_logGroup": LogsLogGroup
        # }
