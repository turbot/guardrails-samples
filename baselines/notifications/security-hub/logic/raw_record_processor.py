import json
import datetime as dt
from .record import Record
from .account_record_collection import AccountRecordCollection


class RawRecordProcessor:
    def __init__(self, raw_records) -> None:
        self.raw_records = raw_records

    def create_account_record_collection(self):
        print("[INFO] Started - Create account record collection")
        print(f"[INFO] Number of raw records received: {len(self.raw_records)}")

        account_record_collection = AccountRecordCollection()

        for raw_record in self.raw_records:
            json_body = json.loads(raw_record['body'])
            notification = json.loads(json_body['Message'])

            control = notification["control"]
            control_id = control["turbot"]["id"]

            new_record_timestamp = notification["turbot"]["createTimestamp"]
            print(f"[INFO] Processing raw record")

            notification_type = notification["notificationType"]
            if notification_type != "control_updated":
                print(
                    f"[INFO] Ignore record - Notification type `{notification_type}` is not handled currently")
                continue

            resource_metadata = control["resource"]["metadata"]
            if "aws" not in resource_metadata:
                print(f"[INFO] Ignore record - Cloud provider not AWS")
                continue

            account_id = resource_metadata["aws"]["accountId"]
            region = resource_metadata["aws"]["regionName"] if resource_metadata["aws"]["regionName"] else "global"
            finding_id = self.__create_finding_id(control_id, account_id, region)

            previous_record = account_record_collection.get_account_record(account_id, finding_id)

            if previous_record:
                previous_record_timestamp = previous_record.updated_timestamp

                previous_record_dt = dt.datetime.fromisoformat(previous_record_timestamp[:-1])
                new_record_dt = dt.datetime.fromisoformat(new_record_timestamp[:-1])

                if previous_record_dt <= new_record_dt:
                    account_record_collection.add_record(
                        account_id, finding_id, self.__create_record(finding_id, notification))
                    print(f"[INFO] Updated existing entry in sorted records - {finding_id} - {new_record_timestamp}")
                else:
                    print(
                        f"[INFO] Ignore record - {finding_id} - More recent update `{previous_record_timestamp}` exists compared to record `{new_record_timestamp}`")
            else:
                account_record_collection.add_record(
                    account_id, finding_id, self.__create_record(finding_id, notification))
                print(f"[INFO] Created new entry in sorted records - {finding_id} - {new_record_timestamp}")

        print(f"[INFO] Process record count: {account_record_collection.get_record_count()}")
        print("[INFO] Completed - Create account record collection")

        return account_record_collection

    def __create_record(self, id, notification):
        record = {}

        control_type = notification["control"]["type"]["trunk"]["title"]
        aws_metadata = notification["control"]["resource"]["metadata"]["aws"]
        control_reason = notification["control"]["reason"]

        record["id"] = id
        record["control_type"] = control_type

        partition = aws_metadata["partition"] if "partition" in aws_metadata else None
        region_name = aws_metadata["regionName"] if "regionName" in aws_metadata else None
        description = control_reason if control_reason else "No reason given"
        title = ""

        control_state = notification["control"]["state"]
        if control_state == "ok":
            old_control_state = notification["oldControl"]["state"]
            title = f"{old_control_state.capitalize()} - {control_type}"
        else:
            title = f"{control_state.capitalize()} - {control_type}"

        tags = {}
        if "tags" in notification["control"]["resource"]["turbot"]:
            tags = notification["control"]["resource"]["turbot"]["tags"]

        # TODO: Remove
        tags = {
            "including-tags": "hey-its-a-tag",
            "itau-hyphens-in-key": "Hyphens make nunjucks complicated"
        }

        return Record(
            id,
            control_type,
            aws_metadata["accountId"],
            notification["turbot"]["createTimestamp"],
            partition,
            region_name,
            notification["control"]["resource"]["turbot"]["id"],
            title,
            description,
            notification["control"]["resource"]["akas"],
            control_state,
            tags
        )

    def __create_finding_id(self, control_id, account_id, region):
        return f"arn:aws:securityhub:{region}:{account_id}:turbot/{control_id}"
