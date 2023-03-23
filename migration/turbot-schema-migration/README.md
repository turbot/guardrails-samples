# Usage
* Use this script for Turbot Disaster Recovery exercise.

Syntax:
```bash
nohup ./migration.sh --region <aws_region> --turbot-schema <schema> --source-endpoint <RDS_endpoint_of_source> --target-endpoint <RDS_endpoint_of_target> &

Example:
nohup ./migration.sh --region us-east-2 --turbot-schema panda --source-endpoint turbot-panda.abcxyzabcxyz.us-east-1.rds.amazonaws.com --target-endpoint turbot-babbage.abcxyzabcxyz.us-east-1.rds.amazonaws.com &
```

* If the schema already exists in the Target database, this script will drop it before proceeding with the restore.
* As the product evolves, more triggers will be added that could make this script obsolete, please check with the Turbot Customer Support (help@turbot.com) for complete list of triggers that need to be dropped before pg_dump.
