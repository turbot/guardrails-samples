from .resource_service import ResourceService
from .resource import Resource
import logging


class IamGroup(Resource):
    def __init__(self, session, region, group) -> None:
        self.group = group
        self.region = region

        super().__init__(session)

    def details(self):
        return f'iam/group {self.group["GroupName"]}'

    def delete(self, dry_run):
        logger = logging.getLogger(__name__)
        iam_client = self.session.create_client('iam', self.region)

        response = iam_client.get_group(
            GroupName=self.group["GroupName"]
        )

        for user in response["Users"]:
            if not dry_run:
                iam_client.remove_user_from_group(
                    GroupName=self.group["GroupName"],
                    UserName=user["UserName"]
                )

                logger.info(f"Removed {user['UserName']} from group {self.group['GroupName']}")
            else:
                logger.info(f"Would remove {user['UserName']} from group {self.group['GroupName']}")

        response = iam_client.list_attached_group_policies(
            GroupName=self.group["GroupName"],
            PathPrefix=self.group["Path"]
        )
        for attached_policy in response["AttachedPolicies"]:
            if not dry_run:
                iam_client.detach_group_policy(
                    GroupName=self.group["GroupName"],
                    PolicyArn=attached_policy["PolicyArn"]
                )

                logger.info(f"Detached policy {attached_policy['PolicyName']} from group {self.group['GroupName']}")
            else:
                logger.info(f"Would detach {attached_policy['PolicyName']} from group {self.group['GroupName']}")

        response = iam_client.list_group_policies(
            GroupName=self.group["GroupName"]
        )
        for inline_policy in response["PolicyNames"]:
            if not dry_run:
                iam_client.delete_group_policy(
                    GroupName=self.group["GroupName"],
                    PolicyName=inline_policy
                )

                logger.info(f"Deleted inline policy {inline_policy} from group {self.group['GroupName']}")
            else:
                logger.info(f"Would delete inline policy {inline_policy} from group {self.group['GroupName']}")

        if not dry_run:
            iam_client.delete_group(
                GroupName=self.group["GroupName"]
            )
            logger.info(f"Deleted group {self.group['GroupName']}")
        else:
            logger.info(f"Would delete group {self.group['GroupName']}")


class IamGroupResourceService(ResourceService):
    def __init__(self, session, recipe) -> None:
        super().__init__(session, recipe, "iam", "group", True)

    def get_all(self, region):
        iam_client = self.session.create_client('iam', region)

        path_prefix = "/"
        for filter in self.recipe["filters"]:
            if filter["field"] == "PathPrefix":
                path_prefix = filter["value"]

        response = iam_client.list_groups(
            PathPrefix=path_prefix
        )

        resources = []
        for group in response["Groups"]:
            resources.append(IamGroup(self.session, region, group))

        return resources
