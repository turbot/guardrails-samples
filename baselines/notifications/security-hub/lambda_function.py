import datetime as dt
from pymemcache.client import base

from logic import Cache, RawRecordProcessor, SecurityHub


def find_existing_findings_map(security_hub, cache_client, ids):
    cache_found_id_map, cache_missed_id_list = cache_client.get_findings(ids)
    sec_hub_found_id_map = security_hub.get_findings(cache_missed_id_list)

    return {**cache_found_id_map, **sec_hub_found_id_map}


def get_account_id_and_region(context):
    lambda_function_arn = context.invoked_function_arn.split(":")
    region = lambda_function_arn[3]
    account_id = lambda_function_arn[4]
    return account_id, region


def lambda_handler(event, context):
    try:
        # security_hub = SecurityHub.createOld(cache)
        # account_id, region = get_account_id_and_region(context)
        cache = Cache.create()
        raw_record_processor = RawRecordProcessor(event['Records'])

        account_record_collection = raw_record_processor.create_account_record_collection()

        partial_failure = False

        # Create all the sec hub sessions here
        for account_id in account_record_collection:
            print(f"[INFO] Started - Update findings for account {account_id}")

            # NOTE: We have a problem here, we are creating a new session but is this session in the correct region?
            security_hub = SecurityHub.create(cache, account_id)
            records = account_record_collection.get_records(account_id)
            ids = list(records.keys())

            existing_findings_map = find_existing_findings_map(security_hub, cache, ids)

            for key in records:
                record = records[key]

                notification_update_timestamp = record.updated_timestamp

                if key in existing_findings_map:
                    # Check if findings is more recent, if not then ignore
                    existing_finding_update_timestamp = existing_findings_map[key]

                    existing_finding_dt = dt.datetime.fromisoformat(existing_finding_update_timestamp[:-1])
                    notification_dt = dt.datetime.fromisoformat(notification_update_timestamp[:-1])

                    if notification_dt < existing_finding_dt:
                        print(f"[INFO] Ingoring record - More recent update - {key} - {notification_update_timestamp}")
                        continue

                    if record.control_state == "alarm":
                        security_hub.reopen_finding(record)
                    else:
                        security_hub.resolve_finding(record)
                else:
                    # A notification that has resolved but not been recorded
                    if record.control_state in ["ok", "skipped", "tbd"]:
                        print(f"[INFO] Ignoring record - record is in a healthy state - {key}")
                        continue

                    print(f"[INFO] Create record - {key} - {notification_update_timestamp}")
                    security_hub.insert_finding(record)

            print(f"[INFO] Completed - Update findings for account {account_id}")

            partial_failure = partial_failure | security_hub.process_findings()

        if partial_failure == True:
            raise RuntimeError("Partial batch handled - retry")

        print("[INFO] Completed - No Errors")
    except Exception as e:
        print(f'[ERROR] Exception: {str(e)}')
        print("[ERROR] Completed - With Errors")
        raise
