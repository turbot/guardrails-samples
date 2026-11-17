#!/bin/bash

function displayTotalItems {
    local TOTAL_ITEMS=$1

    echo "[INFO] Total amount of policies re-run: ${TOTAL_ITEMS}"
}

function displayHelp {
    echo "Mandatory arguments"
    echo "  --filter: the policy query filter that will return a subset of policies to re-run"
    echo "Optional arguments"
    echo "  --profile: policies the profile to run when using the AWS cli (blank)"
    echo "  --sleep-time: time to back off between run batches in seconds (10)"
    echo "  --batch-size: the maximum size of the batch to run next (20)"
    echo "  --dry-run: policies if the actual policies should be run (false)"
    echo "  --terminate-running: flag to terminate policies already running or queued before re-running"
    echo "Remarks"
    echo "  To list the policies to be re-run quicker then increase the batch size but note that the estimation time"
    echo "  will be calculated based on the larger batch size."
}

function terminateAndRetryPolicy {
    local POLICY_ID=$1

    echo "[INFO] Policy ${POLICY_ID} already has a running process, terminating it before re-run"

    local TERMINATE_MUTATION="mutation TerminateProcess(\$input: TerminateProcessInput!) { terminateProcess(input: \$input) { turbot { id } } }"
    local TERMINATE_VARIABLES='{ "input": { "policyValueId": '${POLICY_ID}' } }'
    local TERMINATE_RESULT=""

    if [[ -z ${PROFILE} ]]
    then
        TERMINATE_RESULT=$(turbot graphql --format json --query "'${TERMINATE_MUTATION}'" --variables "'${TERMINATE_VARIABLES}'")
    else
        TERMINATE_RESULT=$(turbot graphql --format json --query "'${TERMINATE_MUTATION}'" --variables "'${TERMINATE_VARIABLES}'" --profile "${PROFILE}")
    fi

    # The CLI returns error text instead of JSON when the mutation fails, so a parseable response
    # containing the terminateProcess key means the terminate succeeded (its turbot payload may be null)
    if ! echo "${TERMINATE_RESULT}" | jq -e 'has("terminateProcess")' > /dev/null 2>&1
    then
        echo "[INFO] Skipped policy ${POLICY_ID}, terminate failed: ${TERMINATE_RESULT}"
        return 1
    fi

    sleep 1

    local RUN_MUTATION="mutation RunPolicy(\$input: RunPolicyInput!) { runPolicy(input: \$input) { turbot { id } } }"
    local RUN_VARIABLES='{ "input": { "id": '${POLICY_ID}' } }'
    local RETRY_RESULT=""

    if [[ -z ${PROFILE} ]]
    then
        RETRY_RESULT=$(turbot graphql --format json --query "'${RUN_MUTATION}'" --variables "'${RUN_VARIABLES}'")
    else
        RETRY_RESULT=$(turbot graphql --format json --query "'${RUN_MUTATION}'" --variables "'${RUN_VARIABLES}'" --profile "${PROFILE}")
    fi

    if ! echo "${RETRY_RESULT}" | jq -e '.runPolicy' > /dev/null 2>&1
    then
        echo "[INFO] Skipped policy ${POLICY_ID}, retry after terminate failed: ${RETRY_RESULT}"
        return 1
    fi

    local PROCESS_ID=$(echo ${RETRY_RESULT} | jq -r '.runPolicy.turbot.id' 2> /dev/null)

    echo "[INFO] Process \"${PROCESS_ID}\" assigned to re-run policy ${POLICY_ID} (after terminating previous process)"
}

function runSinglePolicy {
    local POLICY_ID=$1

    local RUN_MUTATION="mutation RunPolicy(\$input: RunPolicyInput!) { runPolicy(input: \$input) { turbot { id } } }"
    local RUN_VARIABLES='{ "input": { "id": '${POLICY_ID}' } }'
    local RUN_RESULT=""

    if [[ -z ${PROFILE} ]]
    then
        RUN_RESULT=$(turbot graphql --format json --query "'${RUN_MUTATION}'" --variables "'${RUN_VARIABLES}'")
    else
        RUN_RESULT=$(turbot graphql --format json --query "'${RUN_MUTATION}'" --variables "'${RUN_VARIABLES}'" --profile "${PROFILE}")
    fi

    if echo "${RUN_RESULT}" | jq -e '.runPolicy' > /dev/null 2>&1
    then
        local PROCESS_ID=$(echo ${RUN_RESULT} | jq -r '.runPolicy.turbot.id' 2> /dev/null)
        echo "[INFO] Process \"${PROCESS_ID}\" assigned to re-run policy ${POLICY_ID}"
        return 0
    fi

    if [[ ${TERMINATE_RUNNING} == true ]] && [[ ${RUN_RESULT} == *"already started"* ]]
    then
        terminateAndRetryPolicy ${POLICY_ID}
        return $?
    fi

    echo "[INFO] Skipped policy ${POLICY_ID}: ${RUN_RESULT}"
    return 1
}

function runPolicies {
    local RUN_COLLECTION=("$@")
    local COLLECTION_COUNT=${#RUN_COLLECTION[@]}
    local INPUT_STRING=""
    local MUTATION_BODY=""
    local MUTATION_VARIABLES=""

    let "END_INDEX = COLLECTION_COUNT - 1"

    for (( INDEX=0; INDEX<${COLLECTION_COUNT}; INDEX++ ))
    do
        # Parameters
        if [[ -n ${INPUT_STRING} ]]
        then
            INPUT_STRING+=", "
        fi
        INPUT_STRING+="\$input${INDEX}: RunPolicyInput!"

        # Mutation
        MUTATION_BODY_ENTRY="run${INDEX}: runPolicy(input: \$input${INDEX}) { turbot { id } }"
        MUTATION_BODY+="${MUTATION_BODY_ENTRY} "

        # Variables
        VARIABLE_ENTRY='"input'${INDEX}'": { "id": '${RUN_COLLECTION[${INDEX}]}' }'
        if [[ ${INDEX} != ${END_INDEX} ]]
        then
            VARIABLE_ENTRY+=","
        fi

        MUTATION_VARIABLES+="${VARIABLE_ENTRY} "
    done

    local MUTATION="mutation RunPolicies(${INPUT_STRING}) { ${MUTATION_BODY}}"
    local VARIABLES="{ ${MUTATION_VARIABLES}}"

    if [[ -z ${PROFILE} ]]
    then
        local MUTATION_RESULT=$(turbot graphql --format json --query "'${MUTATION}'" --variables "'${VARIABLES}'")
    else
        local MUTATION_RESULT=$(turbot graphql --format json --query "'${MUTATION}'" --variables "'${VARIABLES}'" --profile "${PROFILE}")
    fi

    # When any policy in the batch errors (e.g. a process is already running for it), the CLI
    # returns the error text instead of JSON and the whole batch result is lost. With
    # --terminate-running, fall back to running this batch's policies individually so the
    # conflicting policies can be terminated and retried.
    if [[ ${TERMINATE_RUNNING} == true ]] && ! echo "${MUTATION_RESULT}" | jq -e '.run0.turbot.id' > /dev/null 2>&1
    then
        echo "[INFO] Batch run failed (${MUTATION_RESULT}), retrying this batch's policies individually"

        for (( INDEX=0; INDEX<${COLLECTION_COUNT}; INDEX++ ))
        do
            runSinglePolicy ${RUN_COLLECTION[${INDEX}]}
        done

        return
    fi

    for (( INDEX=0; INDEX<${COLLECTION_COUNT}; INDEX++ ))
    do
        local PROCESS_ID=$(echo ${MUTATION_RESULT} | jq '.run'${INDEX}'.turbot.id')
        echo "[INFO] Process ${PROCESS_ID} assigned to re-run policy ${RUN_COLLECTION[${INDEX}]}"
    done
}

function createTotalQuery {
    local FILTER=$1

    local TOTAL_QUERY
    read -r -d '' TOTAL_QUERY <<-EOM
        query GetPoliciesTotal {
          policyValues(filter: "${FILTER}") {
            metadata {
              stats {
                total
              }
            }
          }
        }
EOM

    echo ${TOTAL_QUERY}
}

function createPolicyQuery {
    local FILTER=$1
    local PAGING=$2
    local BATCH_SIZE=$3

    if [[ -z ${PAGING} ]]
    then
        PAGING='""'
    fi

    local POLICIES_QUERY
    read -r -d '' POLICIES_QUERY <<-EOM
        query GetPolicies {
          policyValues(filter: "${FILTER} limit:${BATCH_SIZE}" paging:${PAGING}) {
            paging {
              next
            }
            items {
              state
              reason
              type {
                title
              }
              resource {
                trunk {
                  title
                }
              }
              turbot {
                id
              }
            }
          }
        }
EOM

    echo ${POLICIES_QUERY}
}

function main {
    local TIME_SLEEP=20000
    local BATCH_SIZE=20
    local DRY_RUN=true
    local TERMINATE_RUNNING=false

    START=`date +%s`

    # Parse the command line into values required by script
    while (( "$#" )); do
        case "$1" in
            -f|--filter)
                if [[ -n "$2" ]] && [[ ${2:0:1} != "-" ]]
                then
                    local FILTER=$2
                    shift 2
                else
                    echo "[ERROR] Argument for $1 is missing" >&2
                    displayHelp
                    exit 1
                fi
            ;;
            -p|--profile)
                if [[ -n "$2" ]] && [[ ${2:0:1} != "-" ]]
                then
                    local PROFILE=$2
                    shift 2
                else
                    echo "[ERROR] Argument for $1 is missing" >&2
                    displayHelp
                    exit 1
                fi
            ;;
            -d|--dry-run)
                if [[ -n "$2" ]] && [[ ${2:0:1} != "-" ]]
                then
                    if [[ ${2} = "false" ]]
                    then
                        local DRY_RUN=false
                    fi

                    shift 2
                else
                    echo "[ERROR] Argument for $1 is missing" >&2
                    displayHelp
                    exit 1
                fi
            ;;
            # TODO: Fix seconds to milliseconds
            --sleep-time)
                if [[ -n "$2" ]] && [[ ${2:0:1} != "-" ]]
                then
                    TIME_SLEEP=$(($2 * 1000))
                    shift 2
                else
                    echo "[ERROR] Argument for $1 is missing" >&2
                    displayHelp
                    exit 1
                fi
            ;;
            --batch-size)
                if [[ -n "$2" ]] && [[ ${2:0:1} != "-" ]]
                then
                    BATCH_SIZE=$2
                    shift 2
                else
                    echo "[ERROR] Argument for $1 is missing" >&2
                    displayHelp
                    exit 1
                fi
            ;;
            --terminate-running)
                TERMINATE_RUNNING=true
                shift 1
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

    if [[ -z ${FILTER} ]]
    then
        echo '[ERROR] Expected argument `--filter`' >&2
        displayHelp
        exit 2
    fi

    EXPECTED_COMMANDS=( turbot jq )

    for EXPECTED_COMMAND in "${EXPECTED_COMMANDS[@]}"
    do
        if ! command -v ${EXPECTED_COMMAND} &> /dev/null
        then
            echo "Please install ${EXPECTED_COMMAND} in order for this script to work"
            exit
        fi
    done

    local TOTAL_QUERY_RESULT=""
    local TOTAL_QUERY=$(createTotalQuery "${FILTER}")

    if [[ -z ${PROFILE} ]]
    then
        TOTAL_QUERY_RESULT=$(turbot graphql --format json --query "${TOTAL_QUERY}")
    else
        TOTAL_QUERY_RESULT=$(turbot graphql --format json --query "${TOTAL_QUERY}" --profile "${PROFILE}")
    fi

    local TOTAL_POLICIES=$(echo ${TOTAL_QUERY_RESULT} | jq '.policyValues.metadata.stats.total')

    if ! [[ $TOTAL_POLICIES =~ ^[0-9]+$ ]]
    then
        echo '[ERROR] GraphQL returned from server did not match expected results' >&2
        echo '[ERROR] Server returned:' >&2
        echo -e ${TOTAL_QUERY_RESULT}
        exit 3
    fi

    local TOTAL_RETURNED=0
    local PAGING=""

    while (( ${TOTAL_RETURNED} < ${TOTAL_POLICIES} ))
    do
        local POLICIES_QUERY_RESULT=""
        let "OPTIMISED_BATCH_SIZE = TOTAL_POLICIES - TOTAL_RETURNED < BATCH_SIZE ? TOTAL_POLICIES - TOTAL_RETURNED : BATCH_SIZE "
        local POLICIES_QUERY=$(createPolicyQuery "${FILTER}" "${PAGING}" ${OPTIMISED_BATCH_SIZE} )

        if [[ -z ${PROFILE} ]]
        then
            POLICIES_QUERY_RESULT=$(turbot graphql --format json --query "${POLICIES_QUERY}")
        else
            POLICIES_QUERY_RESULT=$(turbot graphql --format json --query "${POLICIES_QUERY}" --profile "${PROFILE}")
        fi

        local TOTAL_ITEMS=$(echo ${POLICIES_QUERY_RESULT} | jq ".policyValues.items | length")
        local RUN_COLLECTION=()

        for ((INDEX = 0 ; INDEX < TOTAL_ITEMS ; INDEX++)); do
            local ITEM=$(echo ${POLICIES_QUERY_RESULT} | jq ".policyValues.items[${INDEX}]")
            local STATE=$(echo ${ITEM} | jq ".state")
            local REASON=$(echo ${ITEM} | jq ".reason")
            local RESOURCE=$(echo ${ITEM} | jq ".resource.trunk.title")
            local TYPE=$(echo ${ITEM} | jq ".type.title")
            local ID=$(echo ${ITEM} | jq ".turbot.id")

            echo "[INFO] Policy $(( INDEX + TOTAL_RETURNED + 1 )) of ${TOTAL_POLICIES}"
            echo "[INFO]    Type: ${TYPE}"
            echo "[INFO]    Resource: ${RESOURCE}"
            echo "[INFO]    State: ${STATE}"
            echo "[INFO]    Reason: ${REASON}"
            echo "[INFO]    ID: ${ID}"

            RUN_COLLECTION+=(${ID})
        done

        if [[ ${DRY_RUN} == false ]]
        then
            runPolicies "${RUN_COLLECTION[@]}"
        fi

        let "TOTAL_RETURNED += TOTAL_ITEMS"

        if [[ ${DRY_RUN} == false ]] && (( ${TOTAL_RETURNED} != ${TOTAL_ITEMS} ))
        then
            echo "[INFO] Backing off for" $((TIME_SLEEP / 1000)) "second(s)"
            sleep $((TIME_SLEEP / 1000))
        fi

        PAGING=$(echo ${POLICIES_QUERY_RESULT} | jq ".policyValues.paging.next")
    done

    displayTotalItems ${TOTAL_RETURNED}

    END=`date +%s`
    RUNTIME=$((END - START))

    echo "[INFO] Total time taken ${RUNTIME} second(s)"
}

main "$@"