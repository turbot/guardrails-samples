from .resource_service import ResourceService
from .resource import Resource
import logging


class CodeCommitRepository(Resource):
    def __init__(self, session, repository_name) -> None:
        self.codecommit = session.create_client("codecommit", session.get_default_region())
        self.logger = logging.getLogger(__name__)
        self.repository_name = repository_name

        super().__init__(session)

    def details(self):
        return f'codecommit/repository {self.repository_name}'

    def delete(self, dry_run):
        if not dry_run:
            self.codecommit.delete_repository(repositoryName=self.repository_name)
            self.logger.info(f'Deleted repository {self.repository_name}')
        else:
            self.logger.info(f'Would delete repository {self.repository_name}')


class CodeCommitRepositoryResourceService(ResourceService):
    def __init__(self, session, recipe, account_id) -> None:
        self.account_id = account_id

        self.repository_names = self.create_repository_names(session)
        super().__init__(session, recipe, "codecommit", "repository", True)

    def create_repository_names(self, session):

        codecommit = session.create_client("codecommit", session.get_default_region())
        paginator = codecommit.get_paginator('list_repositories')
        response_iterator = paginator.paginate()

        results = []
        for response in response_iterator:
            results += response.get('repositories')

        return [repository['repositoryName'] for repository in results]

    def get_all(self, region):
        repository_name = f'turbot-{self.account_id}'

        if repository_name in self.repository_names:
            return [CodeCommitRepository(self.session, repository_name)]

        return []
