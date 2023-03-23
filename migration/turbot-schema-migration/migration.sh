#!/bin/bash

# Ansi color code variables
red="\e[0;91m"
blue="\e[0;94m"
expand_bg="\e[K"
blue_bg="\e[0;104m${expand_bg}"
red_bg="\e[0;101m${expand_bg}"
green_bg="\e[0;102m${expand_bg}"
green="\e[0;92m"
yellow="\e[0;93m"
white="\e[0;97m"
bold="\e[1m"
uline="\e[4m"
reset="\e[0m"

function displayHelp {
    echo "Usage: ./migration.sh [--help] [--turbot-schema TURBOT_SCHEMA] [--source-endpoint SOURCE_RDS_HOST] [--target-endpoint TARGET_RDS_HOST] [--region AWS_REGION]"
    echo ""
    echo "Mandatory arguments"
    echo "  --turbot-schema: Turbot Schema that needs to be migrated"
    echo "  --source-endpoint: Endpoint of the AWS RDS Source (backup) instance"
    echo "  --target-endpoint: Endpoint of the AWS RDS Target instance"
    echo "  --region: AWS Region in which the RDS instance resides"
    echo ""
    echo "Remarks"
    echo "  Make sure the executable script has executable permissions"
}

function db_conn() {
  export PGPASSWORD="$(aws rds generate-db-auth-token --hostname "$1" --port 5432 --region ${REGION} --username turbot)"
}

function run_sql() {
  export PGPASSWORD="$(aws rds generate-db-auth-token --hostname "$1" --port 5432 --region ${REGION} --username turbot)"
  psql -v ON_ERROR_STOP=1 -t -h "$1" -d turbot -U turbot -Antc "$2"
}

function exit_status () {
#   pid=$!
#   wait $pid
  if [[ $? == 0 ]] ; then
      echo -e "${green}${1:-"Success: The last command was executed successfully.\\n"}${reset}"
    else
      echo -e "${red}${2:-"Error: The last command ran into errors, please check.\\n"}${reset}"
      exit 1
  fi
}

function main {

    START=`date +%s`
    
    # Parse the command line into values required by script
    while (( "$#" )); do
        case "$1" in
            -ts|--turbot-schema)
                if [[ -n "$2" ]] && [[ ${2:0:1} != "-" ]]
                then
                    local TURBOT_SCHEMA=$2
                    shift 2
                else
                    echo "[ERROR] Argument for $1 is missing" >&2
                    displayHelp
                    exit 1
                fi
            ;;
            -se|--source-endpoint)
                if [[ -n "$2" ]] && [[ ${2:0:1} != "-" ]]
                then
                    local SOURCE_ENDPOINT=$2
                    shift 2
                else
                    echo "[ERROR] Argument for $1 is missing" >&2
                    displayHelp
                    exit 1
                fi
            ;;
            -te|--target-endpoint)
                if [[ -n "$2" ]] && [[ ${2:0:1} != "-" ]]
                then
                    local TARGET_ENDPOINT=$2
                    shift 2
                else
                    echo "[ERROR] Argument for $1 is missing" >&2
                    displayHelp
                    exit 1
                fi
            ;;
            -r|--region)
                if [[ -n "$2" ]] && [[ ${2:0:1} != "-" ]]
                then
                    local REGION=$2
                    shift 2
                else
                    echo "[ERROR] Argument for $1 is missing" >&2
                    displayHelp
                    exit 1
                fi
            ;;

            --help)
                displayHelp
                exit 0
            ;;
            -*|--*=) # unsupported flags
                echo "[ERROR] Unsupported flag $1" >&2
                displayHelp
                exit 1
            ;;
            *) # unsupported positional arguments
                echo "[ERROR] Error: Unsupported argument $1" >&2
                displayHelp
                exit 1
            ;;
        esac
    done

    if [[ -z ${TURBOT_SCHEMA} ]]
    then
        echo '[ERROR] Expected argument `--turbot-schema`' >&2
        echo ""
        displayHelp
        exit 2
    fi

    
    if [[ -z ${SOURCE_ENDPOINT} ]]
    then
        echo '[ERROR] Expected argument `--source-endpoint`' >&2
        echo ""
        displayHelp
        exit 2
    fi

    if [[ -z ${TARGET_ENDPOINT} ]]
    then
        echo '[ERROR] Expected argument `--target-endpoint`' >&2
        echo ""
        displayHelp
        exit 2
    fi

    if [[ -z ${REGION} ]]
    then
        echo '[ERROR] Expected argument `--region`' >&2
        echo ""
        displayHelp
        exit 2
    fi

    EXPECTED_COMMANDS=( psql envsubst)
    
    for EXPECTED_COMMAND in "${EXPECTED_COMMANDS[@]}"
    do
        if ! command -v ${EXPECTED_COMMAND} &> /dev/null
        then
            echo "Please install ${EXPECTED_COMMAND} in order for this script to work"
            exit
        fi
    done

    # Connectivity Check
    echo -e "${yellow}${uline}\nConnectivity Check:${reset}${yellow} Verifying connectivity to the source and target databases...${reset}"
    run_sql $SOURCE_ENDPOINT "\conninfo"
    exit_status "Source: Success, can connect to the source endpoint $SOURCE_ENDPOINT\n" "Source: Error, unable to connect to the source endpoint $SOURCE_ENDPOINT\n"
    source_db_version=$(run_sql $SOURCE_ENDPOINT  "SELECT version();")

    run_sql $TARGET_ENDPOINT "\conninfo"
    exit_status "Target: Success, can connect to the target endpoint $TARGET_ENDPOINT\n" "Target: Error, unable to connect to the target endpoint $TARGET_ENDPOINT\n"
    target_db_version=$(run_sql $TARGET_ENDPOINT "SELECT version();")

    # Schema Check
    echo -e "${yellow}${uline}Schema Check:${reset}${yellow} Verifying if the schema exists on the Source and Target databases...${reset}"
    turbot_schema_exists=$(run_sql $SOURCE_ENDPOINT "SELECT EXISTS(SELECT 1 FROM pg_namespace WHERE nspname='$TURBOT_SCHEMA');" | xargs)
    if [[ $turbot_schema_exists == "t" ]] ; then
        echo -e "${green}Source: Success, source schema "$TURBOT_SCHEMA" exists on $SOURCE_ENDPOINT${reset}"
        turbot_schema_size_source=$(run_sql $SOURCE_ENDPOINT  "SELECT pg_size_pretty(sum(pg_relation_size(quote_ident(schemaname) || '.' || quote_ident(tablename)))::bigint) FROM pg_tables WHERE schemaname = '$TURBOT_SCHEMA';")
        echo -e "Size of the source schema: $turbot_schema_size_source"
    else
        echo -e "${red}Source: Error, source schema "$TURBOT_SCHEMA" does NOT exists on $SOURCE_ENDPOINT\n${reset}"
        exit 1
    fi

    target_turbot_schema_exists=$(run_sql $TARGET_ENDPOINT "SELECT EXISTS(SELECT 1 FROM pg_namespace WHERE nspname='$TURBOT_SCHEMA');" | xargs)
    if [[ $target_turbot_schema_exists == "t" ]] ; then
        echo -e "\nTarget: Error, schema $TURBOT_SCHEMA ALREADY EXISTS on the target database $TARGET_ENDPOINT"
        echo -e "${blue}Deleting schema on the target database for pg_restore.${reset}"
        db_conn $TARGET_ENDPOINT
        psql -v ON_ERROR_STOP=1 -h $TARGET_ENDPOINT -d turbot -U turbot -c "DROP SCHEMA ${TURBOT_SCHEMA} CASCADE" -c "DROP table ${TURBOT_SCHEMA}_migrations" --log-file=${TURBOT_SCHEMA}_dropschema_before_restore.log 2>${TURBOT_SCHEMA}_dropschema_before_restore.log
    else
        echo -e "${green}\nTarget: Schema $TURBOT_SCHEMA does NOT exists on Target $TARGET_ENDPOINT\n${reset}"
    fi

    # Review the configuration details
    echo -e "${yellow}${uline}Input Review:${reset}${yellow} Proceeding with the below details...${reset}"
    echo -e "Schema: $TURBOT_SCHEMA\nSchema size: $turbot_schema_size_source\nSource Database Endpoint: $SOURCE_ENDPOINT\nSource Database Version: $source_db_version\nTarget Database Endpoint: $TARGET_ENDPOINT\nTarget Database Version: $target_db_version\n"

    # Drop triggers
    echo -e "${yellow}${uline}Drop Triggers:${reset}${yellow} Dropping the triggers for $TURBOT_SCHEMA on source database $SOURCE_ENDPOINT\n${reset}"
    rm -rf /tmp/drop_triggers_env.sql
    rm -rf /tmp/drop_triggers.sql
    cat > /tmp/drop_triggers_env.sql << 'EOF'
drop trigger control_category_path_au on $TURBOT_SCHEMA.control_categories;
drop trigger control_resource_category_path_au on $TURBOT_SCHEMA.resource_categories;
drop trigger control_resource_types_path_au on $TURBOT_SCHEMA.resource_types;
drop trigger control_types_path_au on $TURBOT_SCHEMA.control_types;
drop trigger policy_category_path_au on $TURBOT_SCHEMA.control_categories;
drop trigger policy_resource_category_path_au on $TURBOT_SCHEMA.resource_categories;
drop trigger policy_resource_types_path_au on $TURBOT_SCHEMA.resource_types;
drop trigger policy_types_path_au on $TURBOT_SCHEMA.policy_types;
drop trigger resource_resource_category_path_au on $TURBOT_SCHEMA.resource_categories;
drop trigger resource_resource_type_path_au on $TURBOT_SCHEMA.resource_types;
drop trigger resource_types_500_rt_path_update_au on $TURBOT_SCHEMA.resource_types;
drop trigger resources_update_to_deactivate_grants_au on $TURBOT_SCHEMA.resources;
EOF

    export TURBOT_SCHEMA=$TURBOT_SCHEMA
    envsubst < /tmp/drop_triggers_env.sql > /tmp/drop_triggers.sql
    db_conn $SOURCE_ENDPOINT
    psql -v ON_ERROR_STOP=1 -h $SOURCE_ENDPOINT -d turbot -U turbot -f "/tmp/drop_triggers.sql" --log-file=${TURBOT_SCHEMA}_droptriggers.log 2>${TURBOT_SCHEMA}_droptriggers.log
    # exit_status "${green}Drop Triggers: Success, dropped the triggers for $TURBOT_SCHEMA on $SOURCE_ENDPOINT.\n${reset}" "${red}Drop Triggers: Error, something went wrong while trying to drop the triggers for $TURBOT_SCHEMA on $SOURCE_ENDPOINT, please check log file ${TURBOT_SCHEMA}_droptriggers.log\n${reset}"

    # pg_dump
    echo -e "${yellow}${uline}Pg_dump:${reset}${yellow} Taking pg_dump of the schema $TURBOT_SCHEMA from $SOURCE_ENDPOINT\n${reset}"
    db_conn $SOURCE_ENDPOINT
    time pg_dump -h $SOURCE_ENDPOINT -Fc -d turbot -U turbot --schema=$TURBOT_SCHEMA > $TURBOT_SCHEMA.dump --verbose 2>${TURBOT_SCHEMA}_pgdump.log
    exit_status "${green}pg_dump: Success, completed pg_dump of the schema $TURBOT_SCHEMA from $SOURCE_ENDPOINT\n${reset}" "${red}pg_dump: Error, something went wrong with pg_dump of the schema $TURBOT_SCHEMA from $SOURCE_ENDPOINT, please check ${TURBOT_SCHEMA}_pgdump.log\n${reset}"

    db_conn $SOURCE_ENDPOINT
    time pg_dump -Fc -h $SOURCE_ENDPOINT -U turbot -d turbot -t ${TURBOT_SCHEMA}_migrations > ${TURBOT_SCHEMA}_migrations.dump --verbose 2>${TURBOT_SCHEMA}_migrations_pgdump.log
    exit_status "${green}pg_dump: Success, completed pg_dump of the table ${TURBOT_SCHEMA}_migrations from $SOURCE_ENDPOINT\n${reset}" "${red}pg_dump: Error, something went wrong with pg_dump of the table ${TURBOT_SCHEMA}_migrations from $SOURCE_ENDPOINT, please check ${TURBOT_SCHEMA}_migrations_pgdump.log\n${reset}"

    # pg_restore
    echo -e "${yellow}${uline}Pg_restore:${reset}${yellow} Restoring the schema $TURBOT_SCHEMA to $TARGET_ENDPOINT\n${reset}"
    db_conn $TARGET_ENDPOINT
    time pg_restore -h $TARGET_ENDPOINT -U turbot -d turbot --disable-triggers --exit-on-error $TURBOT_SCHEMA.dump --verbose -j 3 2>${TURBOT_SCHEMA}_pgrestore.log
    exit_status "${green}pg_restore: Success, completed pg_restore of the schema ${TURBOT_SCHEMA} onto $TARGET_ENDPOINT\n${reset}" "${red}pg_restore: Error, something went wrong with pg_restore of the schema ${TURBOT_SCHEMA} onto $TARGET_ENDPOINT, please check ${TURBOT_SCHEMA}_pgrestore.log\n${reset}"

    db_conn $TARGET_ENDPOINT
    time pg_restore -h $TARGET_ENDPOINT -U turbot -d turbot --disable-triggers --exit-on-error ${TURBOT_SCHEMA}_migrations.dump --verbose 2>${TURBOT_SCHEMA}_migrations_pgrestore.log
    exit_status "${green}pg_restore: Success, completed pg_restore of the table ${TURBOT_SCHEMA}_migrations onto $TARGET_ENDPOINT\n${reset}" "${red}pg_restore: Error, something went wrong with pg_restore of the table ${TURBOT_SCHEMA}_migrations onto $TARGET_ENDPOINT, please check ${TURBOT_SCHEMA}_migrations_pgrestore.log\n${reset}"


    # Create triggers
    rm -rf /tmp/create_triggers_env.sql
    rm -rf /tmp/create_triggers.sql
    cat > /tmp/create_triggers_env.sql << 'EOF'
create trigger control_category_path_au after update on $TURBOT_SCHEMA.control_categories for each row when (old.path is distinct from new.path) execute procedure $TURBOT_SCHEMA.types_path_au('controls', 'control_category_id', 'control_category_path');
create trigger control_resource_category_path_au after update on $TURBOT_SCHEMA.resource_categories  for each row when (old.path is distinct from new.path) execute procedure $TURBOT_SCHEMA.types_path_au('controls', 'resource_category_id', 'resource_category_path');
create trigger control_resource_types_path_au after update on $TURBOT_SCHEMA.resource_types for each row when (old.path is distinct from new.path) execute procedure $TURBOT_SCHEMA.types_path_au('controls', 'resource_type_id', 'resource_type_path');
create trigger control_types_path_au after update on $TURBOT_SCHEMA.control_types for each row when (old.path is distinct from new.path) execute procedure $TURBOT_SCHEMA.types_path_au('controls', 'control_type_id', 'control_type_path');
create trigger policy_category_path_au after update on $TURBOT_SCHEMA.control_categories  for each row when (old.path is distinct from new.path) execute procedure $TURBOT_SCHEMA.types_path_au('policy_values', 'control_category_id', 'control_category_path');
create trigger policy_resource_category_path_au after update on $TURBOT_SCHEMA.resource_categories  for each row when (old.path is distinct from new.path) execute procedure $TURBOT_SCHEMA.types_path_au('policy_values', 'resource_category_id', 'resource_category_path');
create trigger policy_resource_types_path_au after update on $TURBOT_SCHEMA.resource_types for each row when (old.path is distinct from new.path) execute procedure $TURBOT_SCHEMA.types_path_au('policy_values', 'resource_type_id', 'resource_type_path');
create trigger policy_types_path_au after update on $TURBOT_SCHEMA.policy_types for each row when (old.path is distinct from new.path) execute procedure $TURBOT_SCHEMA.types_path_au('policy_values', 'policy_type_id', 'policy_type_path');
create trigger resource_resource_category_path_au after update on $TURBOT_SCHEMA.resource_categories for each row when (old.path is distinct from new.path) execute procedure $TURBOT_SCHEMA.types_path_au('resources', 'resource_category_id', 'resource_category_path');
create trigger resource_resource_type_path_au after update on $TURBOT_SCHEMA.resource_types for each row when (old.path is distinct from new.path) execute procedure $TURBOT_SCHEMA.types_path_au('resources', 'resource_type_id', 'resource_type_path');
create trigger resource_types_500_rt_path_update_au after update on $TURBOT_SCHEMA.resource_types for each row when (old.path is distinct from new.path) execute procedure $TURBOT_SCHEMA.update_types_path();
create trigger resources_update_to_deactivate_grants_au after update on $TURBOT_SCHEMA.resources for each row when (old.path is distinct from new.path or old.parent_id is distinct from new.parent_id) execute procedure $TURBOT_SCHEMA.resources_hierarchy_deactivate_grants_au();
EOF
    rm -rf /tmp/create_triggers.sql
    export TURBOT_SCHEMA=$TURBOT_SCHEMA
    envsubst < /tmp/create_triggers_env.sql > /tmp/create_triggers.sql
    echo -e "${yellow}${uline}Create Triggers:${reset}${yellow} Creating triggers for the schema $TURBOT_SCHEMA on $TARGET_ENDPOINT\n${reset}"
    db_conn $TARGET_ENDPOINT
    psql -v ON_ERROR_STOP=1 -h $TARGET_ENDPOINT -d turbot -U turbot -f "/tmp/create_triggers.sql" --log-file=${TURBOT_SCHEMA}_createtriggers.log 2>${TURBOT_SCHEMA}_createtriggers.log
    exit_status "${green}Create Triggers: Success, completed creating triggers on $TARGET_ENDPOINT\n${reset}" "${red}Create Triggers: Error, something went wrong while trying to create triggers for $target_schema on $TARGET_ENDPOINT, please check ${TURBOT_SCHEMA}_createtriggers.log\n${reset}"

    # Create the index_recreation table in the public schema.
    echo -e "Create the index_recreation table in public schema if not exists"
    rm -rf /tmp/index_recreation_env.sql
    rm -rf /tmp/index_recreation.sql
    cat > /tmp/index_recreation_env.sql << 'EOF'
begin;
set local search_path to public;
create table if not exists index_recreation (
  indexoid
    bigint
    primary key,

  update_timestamp
    timestamptz
    not null
    default ($TURBOT_SCHEMA.now_ms() at time zone 'utc')
);
end;
EOF
    export TURBOT_SCHEMA=$TURBOT_SCHEMA
    envsubst < /tmp/index_recreation_env.sql > /tmp/index_recreation.sql
    db_conn $TARGET_ENDPOINT
    psql -v ON_ERROR_STOP=1 -h $TARGET_ENDPOINT -d turbot -U turbot -f "/tmp/index_recreation.sql" --log-file=${TURBOT_SCHEMA}_index_recreation.log 2>${TURBOT_SCHEMA}_index_recreation.log

    # Post validation
    echo -e "${yellow}${uline}\nOutput:${reset}"
    turbot_schema_size_target=$(run_sql $TARGET_ENDPOINT  "SELECT pg_size_pretty(sum(pg_relation_size(quote_ident(schemaname) || '.' || quote_ident(tablename)))::bigint) FROM pg_tables WHERE schemaname = '$TURBOT_SCHEMA';")
    echo -e "Size on source: $turbot_schema_size_source\nSize on target: $turbot_schema_size_target"
    echo -e "Size of pg_dump file: $(du -sh $TURBOT_SCHEMA.dump | sed s/$TURBOT_SCHEMA.dump//g)"
    echo -e "Script Execution Complete!"

    END=`date +%s`
    RUNTIME=$((END - START))
    
    echo "Total time taken ${RUNTIME} second(s)"
}

main "$@"
