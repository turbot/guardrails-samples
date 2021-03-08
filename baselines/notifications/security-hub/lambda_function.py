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
        cache = Cache.create()

        security_hub = SecurityHub.create(cache)

        account_id, region = get_account_id_and_region(context)
        raw_record_processor = RawRecordProcessor(event['Records'], account_id, region)

        records_to_process = raw_record_processor.process()

        ids = list(records_to_process.keys())
        existing_findings_map = find_existing_findings_map(security_hub, cache, ids)

        for key in records_to_process:
            record = records_to_process[key]

            notification_update_timestamp = record.updated_timestamp

            if key in existing_findings_map:
                # Check if findings is more recent, if not then ignore
                existing_finding_update_timestamp = existing_findings_map[key]

                existing_finding_dt = dt.datetime.fromisoformat(existing_finding_update_timestamp[:-1])
                notification_dt = dt.datetime.fromisoformat(notification_update_timestamp[:-1])

                if notification_dt < existing_finding_dt:
                    print(f"Ingoring record - More recent update - {key} - {notification_update_timestamp}")
                    continue

                if record.control_state == "alarm":
                    security_hub.reopen_finding(record)
                else:
                    security_hub.resolve_finding(record)
            else:
                # A notification that has resolved but not been recorded
                if record.control_state in ["ok", "skipped", "tbd"]:
                    print(f"Ignoring record - record is in a healthy state - {key}")
                    continue

                print(f"Create record - {key} - {notification_update_timestamp}")
                security_hub.insert_finding(record)

        partial_failure = security_hub.process_findings()

        if partial_failure == True:
            raise RuntimeError("Partial batch handled - retry")

        print("Completed - No Errors")
    except Exception as e:
        print(f'Exception: {str(e)}')
        print("Completed - With Errors")
        raise
