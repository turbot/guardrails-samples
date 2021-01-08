from .resource_service import ResourceService
from .resource import Resource
import logging


class IamUser(Resource):
    def __init__(self, session, region, user) -> None:
        self.user = user
        self.region = region

        super().__init__(session)

    def details(self):
        return f'iam/user {self.user["UserName"]}'

    def delete(self, dry_run):
        logger = logging.getLogger(__name__)
        iam_client = self.session.create_client('iam', self.region)

        response = iam_client.list_access_keys(
            UserName=self.user["UserName"],
        )
        for access_key in response["AccessKeyMetadata"]:
            if not dry_run:
                iam_client.delete_access_key(
                    UserName=self.user["UserName"],
                    AccessKeyId=access_key["AccessKeyId"]
                )
                logger.info(f"Removed access key {access_key['AccessKeyId']} for user {self.user['UserName']}")
            else:
                logger.info(f"Would remove access key {access_key['AccessKeyId']} for user {self.user['UserName']}")

        response = iam_client.list_attached_user_policies(
            UserName=self.user["UserName"]
        )
        for attached_policy in response["AttachedPolicies"]:
            if not dry_run:
                iam_client.detach_user_policy(
                    UserName=self.user["UserName"],
                    PolicyArn=attached_policy["PolicyArn"]
                )
                logger.info(f"Removed inline policy {attached_policy['PolicyName']} for user {self.user['UserName']}")
            else:
                logger.info(
                    f"Would remove inline policy {attached_policy['PolicyName']} for user {self.user['UserName']}")

        response = iam_client.list_groups_for_user(
            UserName=self.user["UserName"],
        )
        for user_group in response["Groups"]:
            if not dry_run:
                iam_client.detach_group_policy(
                    UserName=self.user["UserName"],
                    PolicyArn=user_group["Arn"]
                )
                logger.info(f"Detached group {user_group['GroupName']} for user {self.user['UserName']}")
            else:
                logger.info(f"Would detach group {user_group['GroupName']} for user {self.user['UserName']}")

        response = iam_client.list_signing_certificates(
            UserName=self.user["UserName"],
        )
        for certificate in response["Certificates"]:
            if not dry_run:
                iam_client.delete_signing_certificate(
                    UserName=self.user["UserName"],
                    CertificateId=certificate["CertificateId"]
                )
                logger.info(f"Detached group {certificate['CertificateId']} for user {self.user['UserName']}")
            else:
                logger.info(f"Would detach group {certificate['CertificateId']} for user {self.user['UserName']}")

        response = iam_client.list_mfa_devices(
            UserName=self.user["UserName"],
        )
        for mfa_device in response["MFADevices"]:
            if not dry_run:
                iam_client.deactivate_mfa_device(
                    UserName=self.user["UserName"],
                    SerialNumber=mfa_device["SerialNumber"]
                )
                logger.info(f"Deactivated {mfa_device['SerialNumber']} for user {self.user['UserName']}")
            else:
                logger.info(f"Would deactivate {mfa_device['SerialNumber']} for user {self.user['UserName']}")

        try:
            response = iam_client.get_login_profile(
                UserName=self.user["UserName"],
            )
            login_profile = response["LoginProfile"]
            if login_profile:
                if not dry_run:
                    iam_client.delete_login_profile(
                        UserName=self.user["UserName"]
                    )
                    logger.info(f"Deleted login profile for user {self.user['UserName']}")
                else:
                    logger.info(f"Would delete login profile for user {self.user['UserName']}")
        except Exception as e:
            if e.response["Error"]["Code"] != "NoSuchEntity":
                raise

        if not dry_run:
            iam_client.delete_user(
                UserName=self.user["UserName"]
            )
            logger.info(f"Deleted user {self.user['UserName']}")
        else:
            logger.info(f"Would delete user {self.user['UserName']}")


class IamUserResourceService(ResourceService):
    def __init__(self, session, recipe) -> None:
        super().__init__(session, recipe, "iam", "user", True)

    def get_all(self, region):
        iam_client = self.session.create_client('iam', region)

        path_prefix = "/"
        for filter in self.recipe["filters"]:
            if filter["field"] == "PathPrefix":
                path_prefix = filter["value"]

        response = iam_client.list_users(
            PathPrefix=path_prefix
        )

        resources = []
        for user in response["Users"]:
            resources.append(IamUser(self.session, region, user))

        return resources
