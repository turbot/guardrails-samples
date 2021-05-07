#!/bin/bash

function displayTotalItems {
    local TOTAL_ITEMS=$1
    
    echo "[INFO] Total amount of controls re-run: ${TOTAL_ITEMS}"
}

function displayHelp {
    echo "Mandatory arguments"
    echo "  --filter: the control query filter that will return a subset of controls to re-run"
    echo "Optional arguments"
    echo "  --profile: controls the profile to run when using the AWS cli (blank)"
    echo "  --sleep-time: time to back off between run batches in seconds (10)"
    echo "  --batch-size: the maximum size of the batch to run next (20)"
    echo "  --dry-run: controls if the actual controls should be run (false)"
    echo "Remarks"
    echo "  To list the controls to be re-run quicker then increase the batch size but note that the estimation time"
    echo "  will be calculated based on the larger batch size."
}

function runControls {
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
        INPUT_STRING+="\$input${INDEX}: RunControlInput!"
        
        # Mutation
        MUTATION_BODY_ENTRY="run${INDEX}: runControl(input: \$input${INDEX}) { turbot { id } }"
        MUTATION_BODY+="${MUTATION_BODY_ENTRY} "
        
        # Variables
        VARIABLE_ENTRY='"input'${INDEX}'": { "id": '${RUN_COLLECTION[${INDEX}]}' }'
        if [[ ${INDEX} != ${END_INDEX} ]]
        then
            VARIABLE_ENTRY+=","
        fi
        
        MUTATION_VARIABLES+="${VARIABLE_ENTRY} "
    done
    
    local MUTATION="mutation RunControls(${INPUT_STRING}) { ${MUTATION_BODY}}"
    local VARIABLES="{ ${MUTATION_VARIABLES}}"
    
    if [[ -z ${PROFILE} ]]
    then
        local MUTATION_RESULT=$(turbot graphql --format json --query "'${MUTATION}'" --variables "'${VARIABLES}'")
    else
        local MUTATION_RESULT=$(turbot graphql --format json --query "${MUTATION}" --variables "${VARIABLES}" --profile "${PROFILE}")
    fi
    
    for (( INDEX=0; INDEX<${COLLECTION_COUNT}; INDEX++ ))
    do
        local PROCESS_ID=$(echo ${MUTATION_RESULT} | jq '.run'${INDEX}'.turbot.id')
        echo "[INFO] Process ${PROCESS_ID} assigned to re-run control ${RUN_COLLECTION[${INDEX}]}"
    done
}

function createTotalQuery {
    local FILTER=$1
    
    local TOTAL_QUERY
    read -r -d '' TOTAL_QUERY <<-EOM
        query GetControlsTotal {
          controls(filter: "${FILTER}") {
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

function createControlQuery {
    local FILTER=$1
    local PAGING=$2
    local BATCH_SIZE=$3
    
    if [[ -z ${PAGING} ]]
    then
        PAGING='""'
    fi
    
    local CONTROL_QUERY
    read -r -d '' CONTROL_QUERY <<-EOM
        query GetControls {
          controls(filter: "${FILTER} limit:${BATCH_SIZE}" paging:${PAGING}) {
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
    
    echo ${CONTROL_QUERY}
}

function main {
    local TIME_SLEEP=20000
    local BATCH_SIZE=20
    local DRY_RUN=true
    
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
                    if [[ ${2,,} = "false" ]]
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
    
    local TOTAL_CONTROLS=$(echo ${TOTAL_QUERY_RESULT} | jq '.controls.metadata.stats.total')
    
    if ! [[ $TOTAL_CONTROLS =~ ^[0-9]+$ ]]
    then
        echo '[ERROR] GraphQL returned from server did not match expected results' >&2
        echo '[ERROR] Server returned:' >&2
        echo -e ${TOTAL_QUERY_RESULT}
        exit 3
    fi
    
    local TOTAL_RETURNED=0
    local PAGING=""
    
    while (( ${TOTAL_RETURNED} < ${TOTAL_CONTROLS} ))
    do
        local CONTROLS_QUERY_RESULT=""
        let "OPTIMISED_BATCH_SIZE = TOTAL_CONTROLS - TOTAL_RETURNED < BATCH_SIZE ? TOTAL_CONTROLS - TOTAL_RETURNED : BATCH_SIZE "
        local CONTROL_QUERY=$(createControlQuery "${FILTER}" "${PAGING}" ${OPTIMISED_BATCH_SIZE} )
        
        if [[ -z ${PROFILE} ]]
        then
            CONTROLS_QUERY_RESULT=$(turbot graphql --format json --query "${CONTROL_QUERY}")
        else
            CONTROLS_QUERY_RESULT=$(turbot graphql --format json --query "${CONTROL_QUERY}" --profile "${PROFILE}")
        fi
        
        local TOTAL_ITEMS=$(echo ${CONTROLS_QUERY_RESULT} | jq ".controls.items | length")
        local RUN_COLLECTION=()
        
        for ((INDEX = 0 ; INDEX < TOTAL_ITEMS ; INDEX++)); do
            local ITEM=$(echo ${CONTROLS_QUERY_RESULT} | jq ".controls.items[${INDEX}]")
            local STATE=$(echo ${ITEM} | jq ".state")
            local REASON=$(echo ${ITEM} | jq ".reason")
            local RESOURCE=$(echo ${ITEM} | jq ".resource.trunk.title")
            local TYPE=$(echo ${ITEM} | jq ".type.title")
            local ID=$(echo ${ITEM} | jq ".turbot.id")
            
            echo "[INFO] Control $(( INDEX + TOTAL_RETURNED + 1 )) of ${TOTAL_CONTROLS}"
            echo "[INFO]    Type: ${TYPE}"
            echo "[INFO]    Resource: ${RESOURCE}"
            echo "[INFO]    State: ${STATE}"
            echo "[INFO]    Reason: ${REASON}"
            echo "[INFO]    ID: ${ID}"
            
            RUN_COLLECTION+=(${ID})
        done
        
        if [[ ${DRY_RUN} == false ]]
        then
            runControls "${RUN_COLLECTION[@]}"
        fi
        
        
        let "TOTAL_RETURNED += TOTAL_ITEMS"
        
        if [[ ${DRY_RUN} == false ]] && (( ${TOTAL_RETURNED} != ${TOTAL_ITEMS} ))
        then
            echo "[INFO] Backing off for" $((TIME_SLEEP / 1000)) "second(s)"
            sleep $((TIME_SLEEP / 1000))
        fi
        
        PAGING=$(echo ${CONTROLS_QUERY_RESULT} | jq ".controls.paging.next")
    done
    
    displayTotalItems ${TOTAL_RETURNED}
    
    END=`date +%s`
    RUNTIME=$((END - START))
    
    echo "[INFO] Total time taken ${RUNTIME} second(s)"
}

main "$@"